#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init --depth=1 -u https://github.com/AfterlifeOS/android_manifest.git -b 14 --git-lfs
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
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
cat > device/samsung/a10/afterlife_a10.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# Inherit device configuration
$(call inherit-product, device/samsung/a10/device.mk)
# Inherit some common AfterlifeOS stuff.
$(call inherit-product, vendor/afterlife/config/common_full_phone.mk)
AFTERLIFE_GAPPS := false
AFTERLIFE_MAINTAINER := Masood
# Device identifier
PRODUCT_DEVICE := a10
PRODUCT_NAME := afterlife_a10
PRODUCT_MODEL := SM-A105F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a10/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a10/genesis_a10.mk
COMMON_LUNCH_CHOICES := \
    afterlife_a10-eng \
    afterlife_a10-user \
    afterlife_a10-userdebug
EOF

# Build for A10
goafterlife a10
