#!/bin/bash

# Remove old local manifests
rm -rf .repo/local_manifests/

# Initialize the repo
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local manifests
git clone https://github.com/Masood-J/local_manifests.git -b Sigma-14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync the repo
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export environment variables
export BUILD_USERNAME=Masood
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up the build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
# Build for A10
lunch lineage_a10-ap2a-user
make installclean
mka bacon
