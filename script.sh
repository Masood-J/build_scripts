#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/sigmadroid-project/manifest.git -b sigma-14.3 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Masood-J/local_manifests.git -b Sigma-14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=Masood•BecomingTooSigma
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Device models mapping
declare -A device_models=(
    [a20e]="SM-A202K"
    [a30]="SM-A305F"
    [a30s]="SM-A307F"
    [a40]="SM-A405F"
)

# Step 3: Modify and rename files after creation

for device in a20e a30 a30s a40; do
    if [ -f "device/samsung/$device/lineage_$device.mk" ]; then
        echo "Renaming and modifying lineage_$device.mk to sigma_$device.mk..."
        
        # Rename the file
        mv "device/samsung/$device/lineage_$device.mk" "device/samsung/$device/sigma_$device.mk"
        
        # Overwrite sigma_$device.mk with the desired contents
        cat > "device/samsung/$device/sigma_$device.mk" << EOF
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/$device/device.mk)

# Inherit some common rom stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# Rom Specific Flags
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_BOOT_ANIMATION_RES := 1080
SYSTEM_OPTIMIZE_JAVA := true
SYSTEMUI_OPTIMIZE_JAVA := true

# SigmaDroid Variables
SIGMA_CHIPSET="exynos7885"
SIGMA_MAINTAINER="Masood"
SIGMA_DEVICE="$device"

# Build package
#WITH_GMS := true
WITH_GMS := false

# Launcher
TARGET_DEFAULT_PIXEL_LAUNCHER := true
TARGET_PREBUILT_LAWNCHAIR_LAUNCHER := true

# Blur
TARGET_SUPPORTS_BLUR := false

# Pixel features
TARGET_ENABLE_PIXEL_FEATURES := false

# Use Google telephony framework
TARGET_USE_GOOGLE_TELEPHONY := true

# Touch Gestures
TARGET_SUPPORTS_TOUCHGESTURES := true

# Debugging
TARGET_INCLUDE_MATLOG := false

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := $device
PRODUCT_NAME := sigma_$device
PRODUCT_MODEL := ${device_models[$device]}
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
    fi
done

# Modify AndroidProducts.mk to include sigma_* lunch choices for a20e, a30, a30s, and a40
for device in a20e a30 a30s a40; do
    if [ -f "device/samsung/$device/AndroidProducts.mk" ]; then
        echo "Modifying AndroidProducts.mk to include sigma_$device..."
        
        # Overwrite AndroidProducts.mk with the desired contents
        cat > "device/samsung/$device/AndroidProducts.mk" << EOF
PRODUCT_MAKEFILES := \
    device/samsung/$device/sigma_$device.mk

COMMON_LUNCH_CHOICES := \
    sigma_$device-eng \
    sigma_$device-user \
    sigma_$device-userdebug
EOF
    fi
done

# Step 4: Build for each device
for device in a20e a30 a30s a40; do
    lunch sigma_$device-ap2a-user
    make installclean
    make bacon
    echo "======================"
    echo "Build for $device completed!"
    echo "======================"
done
