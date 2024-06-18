/*
 * Copyright (C) 2018-2024 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "android.hardware.light-service.asus_Z01R"

#include <android/binder_manager.h>
#include <android/binder_process.h>
#include <android-base/logging.h>

#include "Lights.h"

using aidl::android::hardware::light::Lights;

const static std::string kLcdBacklightPath = "/sys/class/backlight/panel0-backlight/brightness";
const static std::string kLcdMaxBacklightPath = "/sys/class/backlight/panel0-backlight/max_brightness";
const static std::string kRedLedPath = "/sys/class/leds/red/brightness";
const static std::string kGreenLedPath = "/sys/class/leds/green/brightness";
const static std::string kRedBlinkPath = "/sys/class/leds/red/pwm_us";
const static std::string kGreenBlinkPath = "/sys/class/leds/green/pwm_us";

int main() {
    uint32_t lcdMaxBrightness = 255;

    std::ofstream lcdBacklight(kLcdBacklightPath);
    if (!lcdBacklight) {
        LOG(ERROR) << "Failed to open " << kLcdBacklightPath << ", error=" << errno
                   << " (" << strerror(errno) << ")";
        return -errno;
    }

    std::ifstream lcdMaxBacklight(kLcdMaxBacklightPath);
    if (!lcdMaxBacklight) {
        LOG(ERROR) << "Failed to open " << kLcdMaxBacklightPath << ", error=" << errno
                   << " (" << strerror(errno) << ")";
        return -errno;
    } else {
        lcdMaxBacklight >> lcdMaxBrightness;
    }

    std::ofstream redLed(kRedLedPath);
    if (!redLed) {
        LOG(ERROR) << "Failed to open " << kRedLedPath << ", error=" << errno
                   << " (" << strerror(errno) << ")";
        return -errno;
    }

    std::ofstream greenLed(kGreenLedPath);
    if (!greenLed) {
        LOG(ERROR) << "Failed to open " << kGreenLedPath << ", error=" << errno
                   << " (" << strerror(errno) << ")";
        return -errno;
    }

    std::ofstream redBlink(kRedBlinkPath);
    if (!redBlink) {
        LOG(ERROR) << "Failed to open " << kRedBlinkPath << ", error=" << errno
                   << " (" << strerror(errno) << ")";
        return -errno;
    }

    std::ofstream greenBlink(kGreenBlinkPath);
    if (!greenBlink) {
        LOG(ERROR) << "Failed to open " << kGreenBlinkPath << ", error=" << errno
                   << " (" << strerror(errno) << ")";
        return -errno;
    }

    ABinderProcess_setThreadPoolMaxThreadCount(0);
    std::shared_ptr<Lights> lights = ndk::SharedRefBase::make<Lights>(
            std::make_pair(std::move(lcdBacklight), lcdMaxBrightness),
            std::move(redLed), std::move(greenLed),
            std::move(redBlink), std::move(greenBlink));

    const std::string instance = std::string() + Lights::descriptor + "/default";
    binder_status_t status = AServiceManager_addService(lights->asBinder().get(), instance.c_str());
    CHECK(status == STATUS_OK);

    ABinderProcess_joinThreadPool();
    return EXIT_FAILURE; // should not reach
}
