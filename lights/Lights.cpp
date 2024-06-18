/*
 * Copyright (C) 2018-2024 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "LightService"

#include "Lights.h"

#include <android-base/logging.h>

namespace {

static constexpr int DEFAULT_MAX_BRIGHTNESS = 255;

static uint32_t rgbToBrightness(const HwLightState& state) {
    uint32_t color = state.color & 0x00ffffff;
    return ((77 * ((color >> 16) & 0xff)) + (150 * ((color >> 8) & 0xff)) +
            (29 * (color & 0xff))) >> 8;
}

static bool isLit(const HwLightState& state) {
    return (state.color & 0x00ffffff);
}

}  // anonymous namespace

namespace aidl {
namespace android {
namespace hardware {
namespace light {

Lights::Lights(std::pair<std::ofstream, uint32_t>&& lcd_backlight,
               std::ofstream&& red_led, std::ofstream&& green_led,
               std::ofstream&& red_blink, std::ofstream&& green_blink)
    : mLcdBacklight(std::move(lcd_backlight)),
      mRedLed(std::move(red_led)),
      mGreenLed(std::move(green_led)),
      mRedBlink(std::move(red_blink)),
      mGreenBlink(std::move(green_blink)) {
    auto attnFn(std::bind(&Lights::setAttentionLight, this, std::placeholders::_1));
    auto backlightFn(std::bind(&Lights::setLcdBacklight, this, std::placeholders::_1));
    auto batteryFn(std::bind(&Lights::setBatteryLight, this, std::placeholders::_1));
    auto notifFn(std::bind(&Lights::setNotificationLight, this, std::placeholders::_1));
    mLights.emplace(std::make_pair(LightType::ATTENTION, attnFn));
    mLights.emplace(std::make_pair(LightType::BACKLIGHT, backlightFn));
    mLights.emplace(std::make_pair(LightType::BATTERY, batteryFn));
    mLights.emplace(std::make_pair(LightType::NOTIFICATIONS, notifFn));
}

// Methods from ::aidl::android::hardware::light::BnLights follow.
ndk::ScopedAStatus Lights::setLightState(int32_t id, const HwLightState& state) {
    auto it = mLights.find(static_cast<LightType>(id));

    if (it == mLights.end()) {
        return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
    }

    it->second(state);

    return ndk::ScopedAStatus::ok();
}

#define AutoHwLight(light) {.id = (int32_t)light, .type = light, .ordinal = 0}

ndk::ScopedAStatus Lights::getLights(std::vector<HwLight> *_aidl_return) {
    for (auto const& light : mLights) {
        _aidl_return->push_back(AutoHwLight(light.first));
    }

    return ndk::ScopedAStatus::ok();
}

void Lights::setAttentionLight(const HwLightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mAttentionState = state;
    setSpeakerBatteryLightLocked();
}

void Lights::setLcdBacklight(const HwLightState& state) {
    std::lock_guard<std::mutex> lock(mLock);

    uint32_t brightness = rgbToBrightness(state);

    // If max panel brightness is not the default (255),
    // apply linear scaling across the accepted range.
    if (mLcdBacklight.second != DEFAULT_MAX_BRIGHTNESS) {
        int old_brightness = brightness;
        brightness = brightness * mLcdBacklight.second / DEFAULT_MAX_BRIGHTNESS;
        LOG(VERBOSE) << "scaling brightness " << old_brightness << " => " << brightness;
    }

    mLcdBacklight.first << brightness << std::endl;
}

void Lights::setBatteryLight(const HwLightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mBatteryState = state;
    setSpeakerBatteryLightLocked();
}

void Lights::setNotificationLight(const HwLightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mNotificationState = state;
    setSpeakerBatteryLightLocked();
}

void Lights::setSpeakerBatteryLightLocked() {
    if (isLit(mNotificationState)) {
        setSpeakerLightLocked(mNotificationState);
    } else if (isLit(mAttentionState)) {
        setSpeakerLightLocked(mAttentionState);
    } else if (isLit(mBatteryState)) {
        setSpeakerLightLocked(mBatteryState);
    } else {
        // Lights off
        mRedLed << 0 << std::endl;
        mGreenLed << 0 << std::endl;
        mRedBlink << 0 << std::endl;
        mGreenBlink << 0 << std::endl;
    }
}

void Lights::setSpeakerLightLocked(const HwLightState& state) {
    int red, green, blink;
    int onMs, offMs;
    int totalMs, pwm, fake_pwm;

    // Retrieve each of the RGB colors
    red = (state.color >> 16) & 0xff;
    green = (state.color >> 8) & 0xff;

    switch (state.flashMode) {
        case FlashMode::TIMED:
            onMs = state.flashOnMs;
            offMs = state.flashOffMs;
            break;
        case FlashMode::NONE:
        default:
            onMs = 0;
            offMs = 0;
            break;
    }
    blink = onMs > 0 && offMs > 0;

    // Disable all blinking to start
    mRedBlink << 0 << std::endl;
    mGreenBlink << 0 << std::endl;

    if (blink) {
        totalMs = onMs + offMs;

        // pwm specifies the ratio of ON versus OFF
        // pwm = 0 -> always off
        // pwm = 255 -> always on
		fake_pwm = (onMs * 255) / totalMs;

        // the low 4 bits are ignored, so round up if necessary
        if (fake_pwm > 0 && fake_pwm < 16)
            fake_pwm = 16;

        pwm = offMs * 1000;

		if (red) {
            mRedLed << fake_pwm << std::endl;
            mRedBlink << pwm << std::endl;
		} else if (green) {
            mGreenLed << fake_pwm << std::endl;
            mGreenBlink << pwm << std::endl;
		}

    } else {
        mRedBlink << 100 << std::endl;
        mGreenBlink << 100 << std::endl;

        if (!red || (red && green)) {
            mRedLed << red << std::endl;
            mGreenLed << green << std::endl;
        } else {
            mGreenLed << green << std::endl;
            mRedLed << red << std::endl;
        }
	}
}

}  // namespace light
}  // namespace hardware
}  // namespace android
}  // namespace aidl
