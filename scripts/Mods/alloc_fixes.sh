#!/bin/sh

MODS_FOLDER=/home/sdtdserver/serverfiles/Mods
DL_LINK="http://illy.bz/fi/7dtd/server_fixes.tar.gz"

downloadRelease() {
    curl $DL_LINK -SsL -o allocs.tar.gz
}

clear

echo "[Alloc Fixes] Downloading release from $DL_LINK"

echo "[Alloc Fixes] Downloading files"

downloadRelease

echo "[Alloc Fixes] Extracting files"

mkdir -p allocs-temp
tar --strip-components=1 -xf allocs.tar.gz -C allocs-temp 

echo "[Alloc Fixes] Installing components"

rm -rf $MODS_FOLDER/Allocs*
mv allocs-temp/* $MODS_FOLDER

echo "[Alloc Fixes] Cleanup"

rm allocs.tar.gz
rm -rf allocs-temp

echo "[Alloc Fixes] Finished! ヽ(´▽\`)/"
