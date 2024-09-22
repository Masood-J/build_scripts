#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
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
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Step 3: Modify and rename files after creation

# List all files in a10 directory



# Step 4: Continue with the build process

# Build for A10
lunch lineage_a10-ap2a-user
make installclean 
mka bacon
