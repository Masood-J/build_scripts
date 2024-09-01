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
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Attempt first lunch target
if lunch lineage_a10-ap2a-user && m evolution; then
    echo "Build succeeded with lineage_a10-ap2a-user"
else
    echo "First build failed, trying lineage_a10-user"
    if lunch lineage_a10-user && m evolution; then
        echo "Build succeeded with lineage_a10-user"
    else
        echo "Both builds failed."
        exit 1
    fi
fi

echo "Build process completed."
