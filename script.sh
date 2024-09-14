#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/euclidTeam/manifest.git -b qpr3 --git-lfs
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
export EUCLID_MAINTAINER=Masood
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Step 3: Modify and rename files after creation

# List all files in a10 directory
echo "Listing all files in the a10 directory:"
if [ -d "device/samsung/a10" ]; then
    find device/samsung/a10 -type f
fi

# A10 modifications
if [ -f "device/samsung/a10/lineage_a10.mk" ]; then
    echo "Renaming and modifying lineage_a10.mk to euclid_a10.mk..."
    
    # Rename the file
    mv device/samsung/a10/lineage_a10.mk device/samsung/a10/euclid_a10.mk
    
    # Overwrite sigma_a10.mk with the desired contents
    cat > device/samsung/a10/euclid_a10.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a10/device.mk)

BUILD_BROKEN_MISSING_REQUIRED_MODULES := true


EUCLID_MAINTAINER := Masood
EUCLID_GAPPS := false
TARGET_SUPPORTS_GOOGLE_RECORDER := false
TARGET_INCLUDE_PIXEL_LAUNCHER := false
TARGET_SUPPORTS_TOUCHGESTURES := true

# Device identifier
PRODUCT_DEVICE := a10
PRODUCT_NAME := euclid_a10
PRODUCT_MODEL := SM-A105F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
fi

# Modify AndroidProducts.mk for A10
if [ -f "device/samsung/a10/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk for A10..."
    
    # Overwrite AndroidProducts.mk with the desired contents
    cat > device/samsung/a10/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a10/euclid_a10.mk

COMMON_LUNCH_CHOICES := \
    euclid_a10-eng \
    euclid_a10-user \
    euclid_a10-userdebug
EOF
fi
