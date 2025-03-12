#
# Copyright (C) 2018-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(TARGET_DEVICE),Z01R)

include $(CLEAR_VARS)

# A/B builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

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

endif
