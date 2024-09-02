#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Masood-J/local_manifests.git -b Android-14 .repo/local_manifests
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
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Attempt first lunch target
lunch lineage_a10-ap2a-user
make installclean
mka bacon

echo "Build process completed."
