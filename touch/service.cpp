/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "lineage.touch-service.asus_Z01R"

#include "GloveMode.h"

#include <android-base/logging.h>
#include <android/binder_manager.h>
#include <android/binder_process.h>

using aidl::vendor::lineage::touch::GloveMode;

int main() {
    binder_status_t status = STATUS_OK;

    ABinderProcess_setThreadPoolMaxThreadCount(0);

    std::shared_ptr<GloveMode> gm = ndk::SharedRefBase::make<GloveMode>();
    const std::string gm_instance = std::string(GloveMode::descriptor) + "/default";
    status = AServiceManager_addService(gm->asBinder().get(), gm_instance.c_str());
    CHECK_EQ(status, STATUS_OK) << "Failed to add service " << gm_instance << " " << status;

    ABinderProcess_joinThreadPool();
    return EXIT_FAILURE;  // should not reach
}
