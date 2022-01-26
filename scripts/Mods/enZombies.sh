#!/bin/bash

MODS_FOLDER=/home/sdtdserver/serverfiles/Mods

DL_LINK="https://docs.google.com/uc?export=download&id=1rnEwPPPWWAEBzJijUSpwa40aZmvp5vp0"
DL_LINK_SNUFKIN_ADDON="https://docs.google.com/uc?export=download&id=1_WIy-M_4uJWXCrwCFVxlsyoYlPhqfpWz"
DL_LINK_ROBELOTO_ADDON="https://docs.google.com/uc?export=download&id=1vgk31jxL6Xamw2Oxoc6qTgZQfInF3csF"
DL_LINK_NONUDES_ADDON="https://docs.google.com/uc?export=download&id=1W8ZyFOE7BXfz3xXRPrZzRP9ZEPc5wchf"

downloadRelease() {
    wget --quiet --no-check-certificate "${DL_LINK}" -O enZombies.zip
}

downloadRelease_Snufkin() {
    wget --quiet --no-check-certificate "${DL_LINK_SNUFKIN_ADDON}" -O enZombiesSnufkinAddon.zip
}

downloadRelease_Robeloto() {
    wget --quiet --no-check-certificate "${DL_LINK_ROBELOTO_ADDON}" -O enZombiesRobelotoAddon.zip
}

downloadRelease_NoNudes() {
    wget --quiet --no-check-certificate "${DL_LINK_NONUDES_ADDON}" -O enZombiesNoNudesAddon.zip
}

echo "[enZombies] Downloading release from ${DL_LINK}"

echo "[enZombies] Downloading files"

downloadRelease

echo "[enZombies] Extracting files"

mkdir -p enZombies-temp
unzip -q enZombies.zip -d enZombies-temp

echo "[enZombies] Removing older version"

rm -rf $MODS_FOLDER/enZombies

echo "[enZombies] Installing components"

mv enZombies-temp/* $MODS_FOLDER

echo "[enZombies] Cleanup"

rm enZombies.zip
rm -rf enZombies-temp

if [ "${ENZOMBIES_ADDON_SNUFKIN,,}" == 'yes' ]; then
    echo "[enZombies] Downloading Snufkin Zombies Add-on from ${DL_LINK_SNUFKIN_ADDON}"

    echo "[enZombies] Downloading Snufkin Zombies Add-on files"

    downloadRelease_Snufkin

    echo "[enZombies] Extracting files"

    mkdir -p enZombiesSnufkinAddon-temp
    unzip -q enZombiesSnufkinAddon.zip -d enZombiesSnufkinAddon-temp

    echo "[enZombies] Removing older enZombies Snufkin Addon version"

    rm -rf $MODS_FOLDER/enZombiesAddon1Snufkin

    echo "[enZombies] Installing components"

    mv enZombiesSnufkinAddon-temp/* $MODS_FOLDER

    echo "[enZombies] Snufkin Addon Cleanup"

    rm enZombiesSnufkinAddon.zip
    rm -rf enZombiesSnufkinAddon-temp
fi

if [ "${ENZOMBIES_ADDON_ROBELOTO,,}" == 'yes' ]; then
    echo "[enZombies] Downloading Robeloto Zombies Add-on from ${DL_LINK_ROBELOTO_ADDON}"

    echo "[enZombies] Downloading Robeloto Zombies Add-on files"

    downloadRelease_Robeloto

    echo "[enZombies] Extracting files"

    mkdir -p enZombiesRobelotoAddon-temp
    unzip -q enZombiesRobelotoAddon.zip -d enZombiesRobelotoAddon-temp

    echo "[enZombies] Removing older enZombies Robeloto Addon version"

    rm -rf $MODS_FOLDER/enZombiesAddon2Robeloto

    echo "[enZombies] Installing components"

    mv enZombiesRobelotoAddon-temp/* $MODS_FOLDER

    echo "[enZombies] Robeloto Addon Cleanup"

    rm enZombiesRobelotoAddon.zip
    rm -rf enZombiesRobelotoAddon-temp
fi

if [ "${ENZOMBIES_ADDON_NONUDES,,}" == 'yes' ]; then
    echo "[enZombies] Downloading No Nudes Zombies Add-on from ${DL_LINK_NONUDES_ADDON}"

    echo "[enZombies] Downloading No Nudes Zombies Add-on files"

    downloadRelease_NoNudes

    echo "[enZombies] Extracting files"

    mkdir -p enZombiesNoNudesAddon-temp
    unzip -q enZombiesNoNudesAddon.zip -d enZombiesNoNudesAddon-temp

    echo "[enZombies] Removing older enZombies No Nudes Addon version"

    rm -rf $MODS_FOLDER/enZombiesNoNudes

    echo "[enZombies] Installing components"

    mv enZombiesNoNudesAddon-temp/* $MODS_FOLDER

    echo "[enZombies] No Nudes Addon Cleanup"

    rm enZombiesNoNudesAddon.zip
    rm -rf enZombiesNoNudesAddon-temp
fi

echo "[enZombies] Finished! ヽ(´▽\`)/"
