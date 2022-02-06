#!/bin/bash

BASEPATH=/home/sdtdserver
SERVERFILES_FOLDER=${BASEPATH}/serverfiles

# Get latest version
DL_LINK=$(curl -L -s https://api.github.com/repos/BepInEx/BepInEx/releases/latest | grep -o -E "https://github.com/BepInEx/BepInEx/releases/download/(.*)/BepInEx_unix_(.*).zip")

downloadRelease() {
    curl "$DL_LINK" -SsL -o BepInEx.zip
}

echo "[BepInEx] Downloading release from ${DL_LINK}"

echo "[BepInEx] Downloading files"

downloadRelease

echo "[BepInEx] Extracting files"

mkdir -p BepInEx-temp
unzip -q BepInEx.zip -d BepInEx-temp

echo "[BepInEx] Removing older version"

rm -rf $SERVERFILES_FOLDER/BepInEx
rm -rf $SERVERFILES_FOLDER/doorstop_libs
rm 

echo "[BepInEx] Installing components"

cp -a BepInEx-temp/. $SERVERFILES_FOLDER

echo "[BepInEx] Cleanup"

rm BepInEx.zip
rm -rf BepInEx-temp

echo "[BepInEx] Finished! ヽ(´▽\`)/"
