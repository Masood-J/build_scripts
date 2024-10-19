#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Masood-J/local_manifests.git -b A14-EF .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=Masood
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export TARGET_USES_PICO_GAPPS=true
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
# List all files in a10 directory
cat > device/samsung/a30/derp_a30.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# Inherit device configuration
$(call inherit-product, device/samsung/a30/device.mk)
# Inherit some common derpfest stuff.
$(call inherit-product, vendor/derp/config/common_full_phone.mk)

TARGET_NOT_USES_BLUR := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_INCLUDE_LIVE_WALLPAPERS := false
TARGET_USES_PICO_GAPPS := true

# Device identifier
PRODUCT_DEVICE := a30
PRODUCT_NAME := derp_a30
PRODUCT_MODEL := SM-A305F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a30/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a30/derp_a30.mk
COMMON_LUNCH_CHOICES := \
    derp_a30-eng \
    derp_a30-user \
    derp_a30-userdebug
EOF

# Lunch
lunch derp_a30-user && make installclean && mka derp


