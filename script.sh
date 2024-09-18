#!/bin/bash

# Remove old local manifests
rm -rf .repo/local_manifests/

# Initialize the repo
repo init -u https://github.com/Miku-UI/manifesto -b Udon_v2
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
export MIKU_MASTER=Masood
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export MIKU_GAPPS=false
export TARGET_WITH_KERNEL_SU=true
export TARGET_RELEASE=ap2a
echo "======= Export Done ======"

# Set up the build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
# Modify release.mk to update TARGET_RELEASE if needed
RELEASE_MK_PATH="build/make/core/release_config.mk"

# Backup the original file before making changes
cp "$RELEASE_MK_PATH" "$RELEASE_MK_PATH.bak"

# Check if the file contains the default TARGET_RELEASE setting
if grep -q 'TARGET_RELEASE = trunk_staging' "$RELEASE_MK_PATH"; then
    echo "Updating TARGET_RELEASE default value to 'ap2a'"

    # Use sed to replace 'trunk_staging' with 'ap2a'
    sed -i 's/TARGET_RELEASE = trunk_staging/TARGET_RELEASE = ap2a/' "$RELEASE_MK_PATH"
else
    echo "TARGET_RELEASE default value is already set to something other than 'trunk_staging' or not found."
fi

# Build for A10
lunch miku_a10-ap2a-user
make installclean
make diva
