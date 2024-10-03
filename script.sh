#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14 --git-lfs --depth=1
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
export BUILD_USERNAME=Masood•JoiningTheDerpFest
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
# List all files in a10 directory
echo "Listing all files in the a10 directory:"
if [ -d "device/samsung/a10" ]; then
    find device/samsung/a10 -type f
fi
# Lunch
lunch derp_a10-user
make installclean
echo "============="
# Build ROM
mka derp
