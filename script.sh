#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/GenesisOS/manifest.git -b utopia-3.0 --git-lfs
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
cat > device/samsung/a30/genesis_a30.mk << 'EOF'
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
$(call inherit-product, vendor/genesis/config/common_full_phone.mk)
# Set the maintainer property for the ROM
PRODUCT_PROPERTY_OVERRIDES := ro.genesis.maintainer=Masood
# Device identifier
PRODUCT_DEVICE := a30
PRODUCT_NAME := genesis_a30
PRODUCT_MODEL := SM-A305F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a30/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a30/genesis_a30.mk
COMMON_LUNCH_CHOICES := \
    genesis_a30-eng \
    genesis_a30-user \
    genesis_a30-userdebug
EOF

cat > device/samsung/a30s/genesis_a30s.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# Inherit device configuration
$(call inherit-product, device/samsung/a30s/device.mk)
# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/genesis/config/common_full_phone.mk)
# Set the maintainer property for the ROM
PRODUCT_PROPERTY_OVERRIDES := ro.genesis.maintainer=Masood
# Device identifier
PRODUCT_DEVICE := a30s
PRODUCT_NAME := genesis_a30s
PRODUCT_MODEL := SM-A307F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a30s/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a30s/genesis_a30s.mk
COMMON_LUNCH_CHOICES := \
    genesis_a30s-eng \
    genesis_a30s-user \
    genesis_a30s-userdebug
EOF

# Build for A10
lunch genesis_a30-user && make installclean && mka genesis && lunch genesis_a30s-user && make installclean && mka genesis
