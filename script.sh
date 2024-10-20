#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 13 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Masood-J/local_manifests.git -b A13-EF .repo/local_manifests
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
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch derp_a10-user
make installclean
echo "============="
# Build ROM
mka derp
