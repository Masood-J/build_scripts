#!/bin/bash

# Remove existing local manifests
rm -rf .repo/local_manifests/

# Initialize the repo for AOSPA (Uvite branch)
repo init -u https://github.com/AOSPA/manifest -b uvite
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local manifests
git clone https://github.com/Masood-J/local_manifests.git -b A14-EF .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync the source using crave resync script
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export build environment variables
export BUILD_USERNAME=Masood
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
echo "====== Envsetup Done ======"

# Create the missing 'a10' directory if it doesn't exist
mkdir -p vendor/aospa/products/a10
# Write the aospa_a10.mk file

cat > vendor/aospa/products/a10/aospa_a10.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a10/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier
PRODUCT_DEVICE := a10
PRODUCT_NAME := aospa_a10
PRODUCT_MODEL := SM-A105F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF

cat > vendor/aospa/products/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    vendor/aospa/products/a10/aospa_a10.mk
COMMON_LUNCH_CHOICES := \
    aospa_a10-eng \
    aospa_a10-user \
    aospa_a10-userdebug
EOF

# Write the aospa.dependencies file
cat > vendor/aospa/products/a10/aospa.dependencies << 'EOF'
[
    {
        "remote": "eureka",
        "repository": "android_device_samsung_exynos7885",
        "target_path": "device/samsung/a10",
        "revision": "android-14"
    },
    {
        "remote": "eureka",
        "repository": "Eureka-Kernel-Exynos7885-Q-R-S",
        "target_path": "kernel/samsung/exynos7885",
        "revision": "R15_rom"
    },
    {
        "remote": "eureka",
        "repository": "android_vendor_samsung_exynos7885",
        "target_path": "vendor/samsung",
        "revision": "android-14"
    },
    {
        "remote": "lineage-cp",
        "repository": "android_hardware_samsung_slsi_libbt",
        "target_path": "hardware/samsung_slsi/libbt",
        "revision": "lineage-21"
    },
    {
        "remote": "lineage-cp",
        "repository": "android_hardware_samsung_slsi_scsc_wifibt_wifi_hal",
        "target_path": "hardware/samsung_slsi/scsc_wifibt/wifi_hal",
        "revision": "lineage-21"
    },
    {
        "remote": "lineage-cp",
        "repository": "android_hardware_samsung_slsi_scsc_wifibt_wpa_supplicant_lib",
        "target_path": "hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib",
        "revision": "lineage-21"
    },
    {
        "remote": "royna",
        "repository": "android_device_samsung_slsi_sepolicy",
        "target_path": "device/samsung_slsi/sepolicy",
        "revision": "lineage-21"
    },
    {
        "remote": "royna",
        "repository": "hardware_samsung-extra_interfaces",
        "target_path": "hardware/samsung-ext/interfaces",
        "revision": "lineage-21"
    },
    {
        "remote": "royna",
        "repository": "android_hardware_samsung",
        "target_path": "hardware/samsung",
        "revision": "fourteen"
    },
    {
        "remote": "eureka-slsi-linaro",
        "repository": "android_hardware_samsung_slsi-linaro_graphics",
        "target_path": "hardware/samsung_slsi-linaro/graphics",
        "revision": "lineage-21"
    },
    {
        "remote": "eureka-slsi-linaro",
        "repository": "android_hardware_samsung_slsi-linaro_interfaces",
        "target_path": "hardware/samsung_slsi-linaro/interfaces",
        "revision": "lineage-21"
    },
    {
        "remote": "eureka-slsi-linaro",
        "repository": "android_hardware_samsung_slsi-linaro_exynos",
        "target_path": "hardware/samsung_slsi-linaro/exynos",
        "revision": "lineage-21"
    },
    {
        "remote": "eureka-slsi-linaro",
        "repository": "android_hardware_samsung_slsi-linaro_config",
        "target_path": "hardware/samsung_slsi-linaro/config",
        "revision": "lineage-21"
    },
    {
        "remote": "eureka-slsi-linaro",
        "repository": "android_hardware_samsung_slsi-linaro_openmax",
        "target_path": "hardware/samsung_slsi-linaro/openmax",
        "revision": "lineage-21"
    }
]
EOF



echo "====== aospa_a10.mk Created ======"

# Build for A10
./rom-build.sh a10
