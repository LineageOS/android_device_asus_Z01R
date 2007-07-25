/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */


#include "TouchscreenGesture.h"

#include <bitset>
#include <fstream>
#include <map>
#include <type_traits>
#include <vector>

namespace {
template <typename T>
std::enable_if_t<std::is_integral<T>::value, std::string> encode_binary(T i) {
    return std::bitset<sizeof(T) * 8>(i).to_string();
}
}  // anonymous namespace

namespace aidl {
namespace vendor {
namespace lineage {
namespace touch {

const std::string kGesturePath = "/proc/driver/gesture_type";

const std::map<int32_t, TouchscreenGesture::GestureInfo> TouchscreenGesture::kGestureInfoMap = {
    // clang-format off
    {0, {46, "Letter C"}},
    {1, {18, "Letter e"}},
    {2, {31, "Letter S"}},
    {3, {47, "Letter V"}},
    {4, {17, "Letter W"}},
    {5, {44, "Letter Z"}},
    // clang-format on
};

const uint8_t kKeyMaskGestureControl = 0x40;
const std::vector<uint8_t> kGestureMasks = {
    0x04,  // C gesture mask
    0x08,  // e gesture mask
    0x10,  // S gesture mask
    0x01,  // V gesture mask
    0x20,  // W gesture mask
    0x02,  // Z gesture mask
};

ndk::ScopedAStatus TouchscreenGesture::getSupportedGestures(std::vector<Gesture>* _aidl_return) {
    std::vector<Gesture> gestures;

    for (const auto& entry : kGestureInfoMap) {
        gestures.push_back({entry.first, entry.second.name, entry.second.keycode});
    }

    *_aidl_return = gestures;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus TouchscreenGesture::setGestureEnabled(const Gesture& gesture, bool enabled) {
    uint8_t gestureMode;
    uint8_t mask = kGestureMasks[gesture.id];
    std::fstream file(kGesturePath);
    file >> gestureMode;
    if (enabled)
        gestureMode |= mask;
    else
        gestureMode &= ~mask;
    if (gestureMode != 0) gestureMode |= kKeyMaskGestureControl;
    // Strip first digit
    file << encode_binary(gestureMode).substr(1);

    return ndk::ScopedAStatus::ok();
}

}  // namespace touch
}  // namespace lineage
}  // namespace vendor
}  // namespace aidl
