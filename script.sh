#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
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
export BUILD_USERNAME=Masood
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
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
# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
# Device identifier
PRODUCT_DEVICE := a20e
PRODUCT_NAME := lineage_a20e
PRODUCT_MODEL := SM-A202K
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a20e/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a20e/lineage_a20e.mk
COMMON_LUNCH_CHOICES := \
    lineage_a20e-eng \
    lineage_a20e-user \
    lineage_a20e-userdebug
EOF

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

cat > device/samsung/a30s/lineage_a30s.mk << 'EOF'
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
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
# Device identifier
PRODUCT_DEVICE := a30s
PRODUCT_NAME := lineage_a30s
PRODUCT_MODEL := SM-A307F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a30s/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a30s/lineage_a30s.mk
COMMON_LUNCH_CHOICES := \
    lineage_a30s-eng \
    lineage_a30s-user \
    lineage_a30s-userdebug
EOF

cat > device/samsung/a40/lineage_a40.mk << 'EOF'
# Copyright (C) 2018 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# Inherit device configuration
$(call inherit-product, device/samsung/a40/device.mk)
# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
# Device identifier
PRODUCT_DEVICE := a40
PRODUCT_NAME := lineage_a40
PRODUCT_MODEL := SM-A405F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_GMS_CLIENTID_BASE := android-samsung
EOF
# Modify AndroidProducts.mk for A10
cat > device/samsung/a40/AndroidProducts.mk << 'EOF'
PRODUCT_MAKEFILES := \
    device/samsung/a40/lineage_a40.mk
COMMON_LUNCH_CHOICES := \
    lineage_a40-eng \
    lineage_a40-user \
    lineage_a40-userdebug
EOF

# Build for A10
lunch lineage_a20-ap2a-user && make installclean && mka bacon && lunch lineage_a20e-ap2a-user && make installclean && mka bacon && lunch lineage_a30-ap2a-user && make installclean && mka bacon && lineage_a30s-ap2a-user && make installclean && mka bacon && lunch lineage_a40-ap2a-user && make installclean && mka bacon

