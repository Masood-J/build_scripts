#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/MA3OOD/local_manifests.git -b DerpFest-14 .repo/local_manifests
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
export TARGET_KERNEL_CLANG_VERSION=r487747c
export TARGET_KERNEL_SOURCE=/dev/null


# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch derp_a10-user
make installclean
echo "============="
# Build ROM
mka derp
