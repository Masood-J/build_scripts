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

# Step 3: Modify and rename files after creatio
# For A20e
if [ -f "device/samsung/a30s/lineage_a30s.mk" ]; then
    echo "Renaming and modifying lineage_a30s.mk to sigma_a30s.mk..."
    
    # Rename the file
    mv device/samsung/a30s/lineage_a30s.mk device/samsung/a30s/sigma_a30s.mk
    
    # Overwrite sigma_a20e.mk with the desired contents
    cat > device/samsung/a30s/sigma_a30s.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a30s/device.mk)

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
SIGMA_CHIPSET="exynos7904"
SIGMA_MAINTAINER="Masood"
SIGMA_DEVICE="a30s"

# Build package
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

# Device identifier
PRODUCT_DEVICE := a30s
PRODUCT_NAME := sigma_a30s
PRODUCT_MODEL := SM-A307F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
fi

# Modify AndroidProducts.mk for A20e
if [ -f "device/samsung/a30s/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk for A30s..."
    
    # Overwrite AndroidProducts.mk with the desired contents
    cat > device/samsung/a30s/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a30s/sigma_a30s.mk

COMMON_LUNCH_CHOICES := \
    sigma_a30s-eng \
    sigma_a30s-user \
    sigma_a30s-userdebug
EOF
fi

# For A30
if [ -f "device/samsung/a40/lineage_a40.mk" ]; then
    echo "Renaming and modifying lineage_a40.mk to sigma_a40.mk..."
    
    # Rename the file
    mv device/samsung/a40/lineage_a40.mk device/samsung/a40/sigma_a40.mk
    
    # Overwrite sigma_a30.mk with the desired contents
   cat > device/samsung/a40/sigma_a40.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a40/device.mk)

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
SIGMA_CHIPSET="exynos7904"
SIGMA_MAINTAINER="Masood"
SIGMA_DEVICE="a40"

# Build package
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

# Device identifier
PRODUCT_DEVICE := a40
PRODUCT_NAME := sigma_a40
PRODUCT_MODEL := SM-A405F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
fi

# Modify AndroidProducts.mk for A30
if [ -f "device/samsung/a40/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk for A30..."
    
    # Overwrite AndroidProducts.mk with the desired contents
    cat > device/samsung/a40/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a40/sigma_a40.mk

COMMON_LUNCH_CHOICES := \
    sigma_a40-eng \
    sigma_a40-user \
    sigma_a40-userdebug
EOF
fi

# For A30s


# Build for A10
lunch sigma_a30s-ap2a-user && make installclean && make bacon && lunch sigma_a40-ap2a-user && make installclean && make bacon
