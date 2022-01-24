#!/bin/sh

MODS_FOLDER=/home/sdtdserver/serverfiles/Mods

DL_LINK="https://docs.google.com/uc?export=download&id=1rnEwPPPWWAEBzJijUSpwa40aZmvp5vp0"

downloadRelease() {
    wget --no-check-certificate ${DL_LINK} -O enZombies.zip
}

echo "[enZombies] Downloading release from ${DL_LINK}"

echo "[enZombies] Downloading files"

downloadRelease

echo "[enZombies] Extracting files"

mkdir -p enZombies-temp
unzip -q enZombies.zip -d enZombies-temp

echo "[enZombies] Removing older enZombies version"

rm -rf $MODS_FOLDER/enZombies

echo "[enZombies] Installing components"

mv enZombies-temp/* $MODS_FOLDER

echo "[enZombies] Cleanup"

rm enZombies.zip
rm -rf enZombies-temp

echo "[enZombies] Finished! ヽ(´▽\`)/"
