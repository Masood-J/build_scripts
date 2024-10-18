#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b udc --git-lfs
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
export TARGET_USES_PICO_GAPPS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
if [ -f "device/samsung/a30/pixel-style_a30.mk" ]; then
    echo "Renaming pixel-style_a30.mk to lineage_a30.mk..."
    mv device/samsung/a30/pixel-style_a30.mk device/samsung/a30/lineage_a30.mk
    mv device/samsung/a20/pixel-style_a20.mk device/samsung/a20/lineage_a20.mk
    echo "Rename successful."
else
    echo "pixel-style_a10.mk not found. Skipping rename."
fi
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
# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# ROM Flags
EVO_BUILD_TYPE := Unofficial
TARGET_DISABLE_EPPE := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_BUILD_APERTURE_CAMERA := false
TARGET_HAS_UDFPS := false

# Boot animation
TARGET_SCREEN_HEIGHT := 1520
TARGET_SCREEN_WIDTH := 720

TARGET_USES_PICO_GAPPS := true

# Device identifier
PRODUCT_DEVICE := a30
PRODUCT_NAME := lineage_a30
PRODUCT_MODEL := SM-A305F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a30/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a30/lineage_a30.mk
COMMON_LUNCH_CHOICES := \
    lineage_a30-eng \
    lineage_a30-user \
    lineage_a30-userdebug
EOF

cat > device/samsung/a20/lineage_a20.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# Inherit device configuration
$(call inherit-product, device/samsung/a20/device.mk)
# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# ROM Flags
EVO_BUILD_TYPE := Unofficial
TARGET_DISABLE_EPPE := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_BUILD_APERTURE_CAMERA := false
TARGET_HAS_UDFPS := false

# Boot animation
TARGET_SCREEN_HEIGHT := 1520
TARGET_SCREEN_WIDTH := 720

TARGET_USES_PICO_GAPPS := true

# Device identifier
PRODUCT_DEVICE := a20
PRODUCT_NAME := lineage_a20
PRODUCT_MODEL := SM-A205F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a20/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a20/lineage_a20.mk
COMMON_LUNCH_CHOICES := \
    lineage_a20-eng \
    lineage_a20-user \
    lineage_a20-userdebug
EOF

# Build for A10
lunch lineage_a30-user && make installclean && m evolution && lunch lineage_a20-user && make installclean && m evolution

