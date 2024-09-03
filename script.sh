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
export TARGET_USES_MINI_GAPPS=true
export TARGET_USES_PICO_GAPPS=false
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export PRODUCT_MAKEFILES_PATH="device/samsung/a10/AndroidProducts.mk"
export PRODUCT_DEVICE="a10"
export PRODUCT_NAME="lineage_a10"
export PRODUCT_MODEL="SM-A105F"
export PRODUCT_BRAND="samsung"
export PRODUCT_MANUFACTURER="samsung"

. build/envsetup.sh

add_lunch_combo lineage_a10-user
echo "====== Envsetup Done ======="

# Attempt first lunch target
lunch lineage_a10-user
make installclean
m evolution

echo "Build process completed."
