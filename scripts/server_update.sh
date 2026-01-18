#!/bin/bash
set -e

BASEPATH=/home/sdtdserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

source "$scriptsDir/utils/set_version.sh"

if ./sdtdserver update; then
    echo "[INFO] The server has been updated successfully to ${VERSION,,}"
else
    echo "[ERROR] There was a problem updating the server to ${VERSION,,}"
    exit 1
fi

source "$scriptsDir/Mods/mods_install.sh"

echo "[INFO] The server mods have been updated to latest version; if the server crashes, check mod compatibilities."
