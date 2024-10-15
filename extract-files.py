#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

blob_fixups: blob_fixups_user_type = {
    ('vendor/lib64/hw/fingerprint.default.so', 'vendor/lib64/libgoodixhwfingerprint.so', 'vendor/lib64/libgoodixfingerprintd_binder.so', 'vendor/lib64/libvendor.goodix.hardware.fingerprintextension@1.0.so'): blob_fixup()
        .remove_needed('libbacktrace.so')
        .remove_needed('libunwind.so')
        .remove_needed('libkeystore_binder.so')
        .remove_needed('libkeymaster_messages.so')
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so')
        .replace_needed('libhidlbase.so', 'libhidlbase-v32.so'),
    'vendor/bin/pm-service': blob_fixup()
        .add_needed('libutils-v33.so'),
    ('system_ext/lib64/lib-imscamera.so', 'system_ext/lib64/lib-imsvideocodec.so'): blob_fixup()
        .add_needed('libgui_shim.so')
        .replace_needed('libqdMetaData.so', 'libqdMetaData.system.so'),
    ('vendor/lib64/libwvhidl.so', 'vendor/lib64/mediadrm/libwvdrmengine.so'): blob_fixup()
        .add_needed('libcrypto_shim.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'Z01R',
    'asus',
    blob_fixups=blob_fixups,
    add_firmware_proprietary_file=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
