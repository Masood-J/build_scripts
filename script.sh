#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/sigmadroid-project/manifest.git -b sigma-14.3 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/MA3OOD/local_manifests.git -b SigmaDroid-14 .repo/local_manifests
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

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
if lunch sigma_a10-ap2a-userdebug; then
    echo "Lunch sigma_a10-ap2a-userdebug success"
else
    echo "Lunch sigma_a10-ap2a-userdebug failed, trying lineage_a10-ap2a-user"
    lunch lineage_a10-ap2a-user
fi
make installclean
echo "============="

# Build ROM
make bacon
