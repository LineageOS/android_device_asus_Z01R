#
# Copyright (C) 2018-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),Z01R)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# A/B builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

ADF_MOUNT_POINT := $(TARGET_OUT_VENDOR)/ADF
$(ADF_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(ADF_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/ADF

BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware
$(BT_FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(BT_FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

FACTORY_MOUNT_POINT := $(TARGET_OUT_VENDOR)/factory
$(FACTORY_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FACTORY_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/factory

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(ADF_MOUNT_POINT) $(BT_FIRMWARE_MOUNT_POINT) $(DSP_MOUNT_POINT) $(FACTORY_MOUNT_POINT)

WCNSS_MAC_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/wlan_mac.bin
$(WCNSS_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS MAC bin link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/factory/$(notdir $@) $@

WCNSS_INI_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini
$(WCNSS_INI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS config ini link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/etc/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_INI_SYMLINK) $(WCNSS_MAC_SYMLINK)

APD_MOUNT_SYMLINK := $(TARGET_OUT_VENDOR)/APD
$(APD_MOUNT_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating APD mount symlink: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /APD $@

ALL_DEFAULT_INSTALLED_MODULES += $(APD_MOUNT_SYMLINK)

ASDF_MOUNT_SYMLINK := $(TARGET_OUT_VENDOR)/asdf
$(ASDF_MOUNT_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating asdf mount symlink: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /asdf $@

ALL_DEFAULT_INSTALLED_MODULES += $(ASDF_MOUNT_SYMLINK)

endif
