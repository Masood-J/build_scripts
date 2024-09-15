#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b udc --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Masood-J/local_manifests.git -b evo-x-udc .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
echo "======= Export Done ======"

# Set up build environment
export WITH_GMS=true
export TARGET_USES_MINI_GAPPS=false
export TARGET_USES_PICO_GAPPS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Rename pixel-style_a10.mk to lineage_a10.mk after envsetup
if [ -f "device/samsung/a10/pixel-style_a10.mk" ]; then
    echo "Renaming pixel-style_a10.mk to lineage_a10.mk..."
    mv device/samsung/a10/pixel-style_a10.mk device/samsung/a10/lineage_a10.mk
    echo "Rename successful."
else
    echo "pixel-style_a10.mk not found. Skipping rename."
fi

# Modify lineage_a30.mk
if [ -f "device/samsung/a10/lineage_a10.mk" ]; then
    echo "Modifying lineage_a10.mk..."

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

# Inherit from common lineage configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# ROM Flags
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
EVO_BUILD_TYPE := Unofficial
TARGET_DISABLE_EPPE := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_BUILD_APERTURE_CAMERA := false
TARGET_HAS_UDFPS := false

# Boot animation
TARGET_SCREEN_HEIGHT := 1520
TARGET_SCREEN_WIDTH := 720

# GMS
WITH_GMS ?= true
ifeq ($(WITH_GMS),true)
ifeq ($(TARGET_USES_MINI_GAPPS),true)
$(call inherit-product, vendor/gms/gms_mini.mk)
else ifeq ($(TARGET_USES_PICO_GAPPS),true)
$(call inherit-product, vendor/gms/gms_pico.mk)
else
$(call inherit-product, vendor/gms/gms_full.mk)
endif
endif


# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := a10
PRODUCT_NAME := lineage_a10
PRODUCT_MODEL := SM-A105F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF

    echo "lineage_a10.mk modified successfully."
fi

# Modify AndroidProducts.mk
if [ -f "device/samsung/a10/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk..."

    cat > device/samsung/a10/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a10/lineage_a10.mk

COMMON_LUNCH_CHOICES := \
    lineage_a10-user \
    lineage_a10-userdebug
EOF

    echo "AndroidProducts.mk modified successfully."
fi




# Attempt first lunch target
lunch lineage_a10-user 
make installclean 
m evolution 

echo "Build process completed."
