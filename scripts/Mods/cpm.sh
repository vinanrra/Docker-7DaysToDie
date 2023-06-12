#!/bin/bash

MODS_FOLDER=/home/sdtdserver/serverfiles/Mods
VERSION=

# Change DL_LINK depending on 7 days to die branch version
if [ "${VERSION}" == 'stable' ] || [ "${VERSION}" == 'public' ]; then
    DL_LINK=$(curl -L -s https://api.github.com/repos/Prisma501/CSMM-Patrons-Mod/releases/latest | grep -o -E "https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download(.*).zip")
elif [ "${VERSION}" == 'alpha20.6' ] || [ "${VERSION}" == 'alpha20.7' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A20.6-v22.4.1/CPM_22.4.1.zip"
elif [ "${VERSION}" == 'alpha20.5' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A20.5-v22.1/CPM_22.1.zip"
elif [ "${VERSION}" == 'alpha20.4' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A20.4-v21.8.1/CPM_21.8.1.zip"
elif [ "${VERSION}" == 'alpha20.3' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A20.3-v21.4/CPM_21.4.zip"
elif [ "${VERSION}" == 'alpha19.6' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A19.6-v19.8.1/CPM_19.8.1.zip"
elif [ "${VERSION}" == 'alpha19.5' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A19.5-v19.5/CPM_19.5.zip"
elif [ "${VERSION}" == 'alpha19.4' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A19.4-v19.0/CPM_19.0.zip"
elif [ "${VERSION}" == 'alpha19.3' ]; then
    DL_LINK="https://github.com/Prisma501/CSMM-Patrons-Mod/releases/download/A19.3-v18.6/CPM_18.6.zip"
else
    echo "[CSMM - CPM] No version found compatible with version ${VERSION}"
    echo "[CSMM - CPM] If there is a compatible version check -> https://github.com/Prisma501/CSMM-Patrons-Mod/releases and install it manually"
    echo "[CSMM - CPM] Omitting installation"
    exit
fi

downloadRelease() {
    curl "$DL_LINK" -SsL -o CPM.zip
}

echo "[CSMM - CPM] Downloading release from ${DL_LINK}"

echo "[CSMM - CPM] Downloading files"

downloadRelease

echo "[CSMM - CPM] Extracting files"

mkdir -p CPM-temp
unzip -q CPM.zip -d CPM-temp

echo "[CSMM - CPM] Removing older version"

rm -rf $MODS_FOLDER/1CSMM_Patrons

echo "[CSMM - CPM] Installing components"

mv CPM-temp/* $MODS_FOLDER

echo "[CSMM - CPM] Cleanup"

rm CPM.zip
rm -rf CPM-temp

echo "[CSMM - CPM] Finished! ヽ(´▽\`)/"
