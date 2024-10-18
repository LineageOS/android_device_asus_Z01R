#
# Copyright (C) 2018-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o.mk)

# Inherit from Z01R device
$(call inherit-product, device/asus/Z01R/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_BRAND := asus
PRODUCT_DEVICE := Z01R
PRODUCT_MANUFACTURER := asus
PRODUCT_MODEL := Zenfone 5Z
PRODUCT_NAME := lineage_Z01R

PRODUCT_GMS_CLIENTID_BASE := android-asus

TARGET_VENDOR_PRODUCT_NAME := Z01R
TARGET_VENDOR_DEVICE_NAME := Z01R

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="Z01R-user 8.0.0 OPR1.170623.032 WW_user_80.30.96.221_20181018 release-keys" \
    BuildFingerprint=asus/WW_Z01RD/ASUS_Z01R_1:8.0.0/OPR1.170623.032/WW_80.30.96.221_20181018:user/release-keys \
    DeviceProduct=ASUS_Z01R_1
