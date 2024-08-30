#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/sigmadroid-project/manifest.git -b sigma-14.3 --git-lfs --depth=1
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
export BUILD_USERNAME=Masood•BecomingTooSigma
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"
export TARGET_RELEASE=ap2a
export TARGET_PRODUCT=sigma_a10
export TARGET_BUILD_VARIANT=user
# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch sigma_a10-ap2a-user || lunch lineage_a10-ap2a-user || lunch sigma_a10 || brunch a10
make installclean
echo "============="

# Build ROM
make bacon 
