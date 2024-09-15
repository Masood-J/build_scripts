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
export WITH_GMS=false
export TARGET_USES_MINI_GAPPS=false
export TARGET_USES_PICO_GAPPS=false
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Rename pixel-style_a10.mk to lineage_a10.mk after envsetup
if [ -f "device/samsung/a30/pixel-style_a30.mk" ]; then
    echo "Renaming pixel-style_a30.mk to lineage_a30.mk..."
    mv device/samsung/a30/pixel-style_a30.mk device/samsung/a10/lineage_a30.mk
    echo "Rename successful."
else
    echo "pixel-style_a30.mk not found. Skipping rename."
fi

# Modify lineage_a30.mk
if [ -f "device/samsung/a30/lineage_a30.mk" ]; then
    echo "Modifying lineage_a30.mk..."

    cat > device/samsung/a30/lineage_a30.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a30/device.mk)

# Inherit from common lineage configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# ROM Flags
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
EVO_BUILD_TYPE := Unofficial
TARGET_DISABLE_EPPE := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_BUILD_APERTURE_CAMERA := false
TARGET_HAS_UDFPS := true

# Boot animation
TARGET_SCREEN_HEIGHT := 1520
TARGET_SCREEN_WIDTH := 720

# GMS
WITH_GMS ?= false
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
PRODUCT_DEVICE := a30
PRODUCT_NAME := lineage_a30
PRODUCT_MODEL := SM-A305F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF

    echo "lineage_a30.mk modified successfully."
fi

# Modify AndroidProducts.mk
if [ -f "device/samsung/a30/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk..."

    cat > device/samsung/a30/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a30/lineage_a30.mk

COMMON_LUNCH_CHOICES := \
    lineage_a30-user \
    lineage_a30-userdebug
EOF

    echo "AndroidProducts.mk modified successfully."
fi

if [ -f "device/samsung/a20/pixel-style_a20.mk" ]; then
    echo "Renaming pixel-style_a20.mk to lineage_a20.mk..."
    mv device/samsung/a20/pixel-style_a20.mk device/samsung/a20/lineage_a20.mk
    echo "Rename successful."
else
    echo "pixel-style_a20.mk not found. Skipping rename."
fi

# Modify lineage_a10.mk
if [ -f "device/samsung/a20/lineage_a20.mk" ]; then
    echo "Modifying lineage_a20.mk..."

    cat > device/samsung/a10/lineage_a20.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a20/device.mk)

# Inherit from common lineage configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# ROM Flags
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
EVO_BUILD_TYPE := Unofficial
TARGET_DISABLE_EPPE := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_BUILD_APERTURE_CAMERA := false
TARGET_HAS_UDFPS := true

# Boot animation
TARGET_SCREEN_HEIGHT := 1520
TARGET_SCREEN_WIDTH := 720

# GMS
WITH_GMS ?= false
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
PRODUCT_DEVICE := a20
PRODUCT_NAME := lineage_a20
PRODUCT_MODEL := SM-A205F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF

    echo "lineage_a20.mk modified successfully."
fi

# Modify AndroidProducts.mk
if [ -f "device/samsung/a20/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk..."

    cat > device/samsung/a20/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a20/lineage_a20.mk

COMMON_LUNCH_CHOICES := \
    lineage_a20-user \
    lineage_a20-userdebug
EOF

    echo "AndroidProducts.mk modified successfully."
fi

if [ -f "device/samsung/a20e/pixel-style_a20e.mk" ]; then
    echo "Renaming pixel-style_a20e.mk to lineage_a20e.mk..."
    mv device/samsung/a20e/pixel-style_a20e.mk device/samsung/a20e/lineage_a20e.mk
    echo "Rename successful."
else
    echo "pixel-style_a20e.mk not found. Skipping rename."
fi

# Modify lineage_a10.mk
if [ -f "device/samsung/a20e/lineage_a20e.mk" ]; then
    echo "Modifying lineage_a20e.mk..."

    cat > device/samsung/a20e/lineage_a20e.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a20e/device.mk)

# Inherit from common lineage configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# ROM Flags
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
EVO_BUILD_TYPE := Unofficial
TARGET_DISABLE_EPPE := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_BUILD_APERTURE_CAMERA := false
TARGET_HAS_UDFPS := true

# Boot animation
TARGET_SCREEN_HEIGHT := 1520
TARGET_SCREEN_WIDTH := 720

# GMS
WITH_GMS ?= false
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
PRODUCT_DEVICE := a20e
PRODUCT_NAME := lineage_a20e
PRODUCT_MODEL := SM-A202K
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF

    echo "lineage_a20e.mk modified successfully."
fi

# Modify AndroidProducts.mk
if [ -f "device/samsung/a20e/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk..."

    cat > device/samsung/a20e/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a20e/lineage_a20e.mk

COMMON_LUNCH_CHOICES := \
    lineage_a20e-user \
    lineage_a20e-userdebug
EOF

    echo "AndroidProducts.mk modified successfully."
fi


# Attempt first lunch target
lunch lineage_a10-user && make installclean && m evolution && lunch lineage_a20-user && make installclean && m evolution && lunch lineage_a20e-user && make installclean && m evolution

echo "Build process completed."
