# Copyright (C) 2018-2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := asus

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

DEVICE_PATH := device/asus/Z01R

TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_PATH)/include

# Assert
TARGET_OTA_ASSERT_DEVICE := ASUS_Z01R_1,ASUS_Z01RD,Z01R,Z01RD,WW_Z01RD

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := kryo385

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm845
TARGET_NO_BOOTLOADER := true

BUILD_BROKEN_DUP_RULES := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 service_locator.enable=1 swiotlb=2048 androidboot.configfs=true androidboot.usbcontroller=a600000.dwc3 loop.max_part=7
BOARD_KERNEL_CMDLINE += buildv=WW_100.10.107.123
BOARD_KERNEL_CMDLINE += buildvariant=$(TARGET_BUILD_VARIANT)
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/asus/sdm845
TARGET_KERNEL_CONFIG := Z01R_defconfig

# Platform
TARGET_BOARD_PLATFORM := sdm845
TARGET_BOARD_PLATFORM_GPU := qcom-adreno630

# Treble
BOARD_VNDK_VERSION := current

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "qualcomm-hidl"

# Audio
AUDIO_FEATURE_ENABLED_AAC_ADTS_OFFLOAD := true
AUDIO_FEATURE_ENABLED_AUDIOSPHERE := true
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true
AUDIO_FEATURE_ENABLED_HDMI_SPK := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
TARGET_PROVIDES_AUDIO_EXTNS := true
USE_CUSTOM_AUDIO_POLICY := 1
USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include

# Camera
TARGET_USES_QTI_CAMERA_DEVICE := true

# Charger
WITH_LINEAGE_CHARGER := false

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

# FM
BOARD_HAS_QCA_FM_SOC := "cherokee"
BOARD_HAVE_QCOM_FM := true

# Graphics
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 2
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_SCREEN_DENSITY := 440
TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true
TARGET_USES_ION := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

# LMKD
TARGET_LMKD_STATS_LOG := true

# Media
TARGET_PROVIDES_LIBPLATFORMCONFIG := true
TARGET_USES_MEDIA_EXTENSIONS := true

# Network Routing
TARGET_NEEDS_NETD_DIRECT_CONNECT_RULE := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2986344448
BOARD_USERDATAIMAGE_PARTITION_SIZE := 52554575872
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/driver/dclick"

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# QCOM
BOARD_USES_QCOM_HARDWARE := true
TARGET_FWK_SUPPORTS_FULL_VALUEADDS := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true
TARGET_RIL_VARIANT := caf

# Root
BOARD_ROOT_EXTRA_FOLDERS := APD asdf odm oem

BOARD_ROOT_EXTRA_SYMLINKS := \
    /vendor/ADF:/ADF \
    /vendor/factory:factory

# Security patch level
VENDOR_SECURITY_PATCH := 2021-01-05

# SELinux
include device/qcom/sepolicy_vndr/SEPolicy.mk

BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
PRODUCT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
PRODUCT_PUBLIC_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/public

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flag 2

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Inherit from the proprietary version
include vendor/asus/Z01R/BoardConfigVendor.mk
