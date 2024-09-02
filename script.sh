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
export TARGET_PRODUCT_MK=$(pwd)/device/samsung/a10/lineage_a10.mk
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Attempt first lunch target
lunch lineage_a10-user
make installclean
m evolution

echo "Build process completed."
