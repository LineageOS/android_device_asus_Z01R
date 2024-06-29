#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=Z01R
VENDOR=asus

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_FIRMWARE=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-firmware )
                ONLY_FIRMWARE=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
    vendor/lib64/hw/fingerprint.default.so | vendor/lib64/libgoodixhwfingerprint.so | vendor/lib64/libgoodixfingerprintd_binder.so | vendor/lib64/libvendor.goodix.hardware.fingerprintextension@1.0.so)
        # Remove unused dependencies
        "${PATCHELF_0_17_2}" --remove-needed libbacktrace.so "${2}"
        "${PATCHELF_0_17_2}" --remove-needed libunwind.so "${2}"
        "${PATCHELF_0_17_2}" --remove-needed libkeystore_binder.so "${2}"
        "${PATCHELF_0_17_2}" --remove-needed libkeymaster_messages.so "${2}"
        # Update libstdc++.vendor target name
        "${PATCHELF_0_17_2}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
        # fingerprint: use libhidlbase-v32 for goodix
        grep -q "libhidlbase-v32.so" "${2}" || "${PATCHELF_0_17_2}" --replace-needed "libhidlbase.so" "libhidlbase-v32.so" "${2}"
        ;;

    # Use libutils-v33 for pm-service
    vendor/bin/pm-service)
        grep -q libutils-v33.so "${2}" || "${PATCHELF}" --add-needed "libutils-v33.so" "${2}"
        ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

if [ -z "${ONLY_FIRMWARE}" ]; then
    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

BLOB_ROOT="$ANDROID_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary


if [ -z "${SECTION}" ]; then
    extract_firmware "${MY_DIR}/proprietary-firmware.txt" "${SRC}"
fi

"${MY_DIR}/setup-makefiles.sh"
