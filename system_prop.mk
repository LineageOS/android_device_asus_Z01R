#
# Copyright (C) 2018 The LineageOS Project
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

# Audio

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.voicerec=false \
    persist.audio.fluence.speaker=true \
    ro.qc.sdk.audio.ssr=false \
    ro.qc.sdk.audio.fluencetype=none \
    tunnel.audio.encode=true \
    ro.config.media_vol_steps=25 \
    ro.config.vc_call_vol_steps=7

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=true

# CNE and DPM
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cne.feature=1 \
    persist.vendor.dpm.feature=10 \
    persist.vendor.dpm.tcm=2

# Data modules
PRODUCT_PROPERTY_OVERRIDES += \
    persist.data.df.dev_name=rmnet_usb0 \
    ro.vendor.use_data_netmgrd=true \
    persist.vendor.data.mode=concurrent

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.enable_hwc_vds=1

# IMS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    audio.offload.video=true \
    media.settings.xml=/system/etc/media_profiles_vendor.xml

# Netflix custom property
PRODUCT_PROPERTY_OVERRIDES += \
    ro.netflix.bsp_rev=Q845-14477-1

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.core_ctl_min_cpu=2 \
    ro.vendor.qti.core_ctl_max_cpu=4 \
    vendor.iop.enable_uxe=0 \
    vendor.perf.iop_v3.enable=1

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    persist.rcs.supported=0 \
    persist.vendor.radio.sglte_target=0 \
    ril.qcril_pre_init_lock_held=0 \
    ril.subscription.types=NV,RUIM \
    telephony.lteOnCdmaDevice=1 \
    DEVICE_PROVISIONED=1 \
    ro.telephony.default_network=22,22

# Asus RIL Hax
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hexedit.manufacturer=unknown

# Expose AUX
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.asus.camera
