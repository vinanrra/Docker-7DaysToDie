#!/bin/bash

MODS_FOLDER=/home/sdtdserver/serverfiles/Mods

DL_LINK="https://github.com/ErrorNull0/enZombies/archive/refs/heads/main.zip"
DL_LINK_SNUFKIN_ADDON="https://github.com/ErrorNull0/enZombiesSnufkinAddon/archive/refs/heads/main.zip"
DL_LINK_ROBELOTO_ADDON="https://github.com/ErrorNull0/enZombiesRobelotoAddon/archive/refs/heads/main.zip"
DL_LINK_NONUDES_ADDON="https://github.com/ErrorNull0/enZombiesNoNudes/archive/refs/heads/main.zip"

downloadRelease() {
    curl "$DL_LINK" -SsL -o enZombies.zip
}

downloadRelease_Snufkin() {
    curl "$DL_LINK_SNUFKIN_ADDON" -SsL -o enZombiesSnufkinAddon.zip
}

downloadRelease_Robeloto() {
    curl "$DL_LINK_ROBELOTO_ADDON" -SsL -o enZombiesRobelotoAddon.zip
}

downloadRelease_NoNudes() {
    curl "$DL_LINK_NONUDES_ADDON" -SsL -o enZombiesNoNudesAddon.zip
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

    rm -rf $MODS_FOLDER/enZombiesAddon1Snufkin-main

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

    rm -rf $MODS_FOLDER/enZombiesAddon2Robeloto-main

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

    rm -rf $MODS_FOLDER/enZombiesNoNudes-main

    echo "[enZombies] Installing components"

    mv enZombiesNoNudesAddon-temp/* $MODS_FOLDER

    echo "[enZombies] No Nudes Addon Cleanup"

    rm enZombiesNoNudesAddon.zip
    rm -rf enZombiesNoNudesAddon-temp
fi

echo "[enZombies] Finished! ヽ(´▽\`)/"
