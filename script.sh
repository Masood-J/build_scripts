#!/bin/bash

# Remove existing local manifests
rm -rf .repo/local_manifests/

# Initialize the repo for AOSPA (Uvite branch)
repo init -u https://github.com/TenX-OS/manifest.git -b fourteen --git-lfs
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
# Write the aospa_a10.mk file

cat > device/samsung/a10/lineage_a10.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a10/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# TenX
TARGET_HAS_UDFPS := false
TARGET_ENABLE_BLUR := false
WITH_GMS := false
TARGET_BOOT_ANIMATION_RES := 1080

# Device identifier
PRODUCT_DEVICE := a10
PRODUCT_NAME := lineage_a10
PRODUCT_MODEL := SM-A105F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF

cat > device/samsung/a10/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a10/lineage_a10.mk
COMMON_LUNCH_CHOICES := \
    lineage_a10-eng \
    lineage_a10-user \
    lineage_a10-userdebug
EOF

# Write the aospa.dependencies file
echo "====== aospa_a10.mk Created ======"

# Build for A10
lunch lineage_a10-ap2a-userdebug && make installclean && mka bacon
