#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Miku-UI/manifesto -b Udon_v2
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
export MIKU_MASTER=Masood
export MIKU_GAPPS=false
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Step 3: Modify and rename files after creation

# List all files in a10 directory


# Check if lineage_a10.mk exists and rename it
# Create or overwrite miku_a10.mk with the desired content
echo "Creating or overwriting miku_a10.mk..."
cat > device/samsung/a10/miku_a10.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a10/device.mk)

# Inherit some common rom stuff
$(call inherit-product, vendor/miku/build/product/miku_product.mk)

# Boot animation
TARGET_BOOT_ANIMATION_RES := 1080

# Rom Specific Flags
MIKU_GAPPS := false

MIKU_MASTER := Masood

# Device identifier
PRODUCT_DEVICE := a10
PRODUCT_NAME := miku_a10
PRODUCT_MODEL := SM-A105F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF

# Modify AndroidProducts.mk for A10
if [ -f "device/samsung/a10/AndroidProducts.mk" ]; then
    echo "Modifying AndroidProducts.mk for A10..."
    
    # Overwrite AndroidProducts.mk with the desired contents
    cat > device/samsung/a10/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a10/miku_a10.mk

COMMON_LUNCH_CHOICES := \
    miku_a10-eng \
    miku_a10-user \
    miku_a10-userdebug
EOF
fi

echo "Listing all files in the a10 directory:"
if [ -d "device/samsung/a10" ]; then
    find device/samsung/a10 -type f
fi

# Step 4: Continue with the build process

# Build for A10
lunch miku_a10-ap2a-user
make diva 


