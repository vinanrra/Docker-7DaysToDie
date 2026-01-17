#!/bin/bash
set -e

BASEPATH=/home/sdtdserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

source "$scriptsDir/utils/set_version.sh"

./sdtdserver update

source "$scriptsDir/Mods/mods_install.sh"

echo "[INFO] The server mods have been updated to latest version; if the server crashes, check mod compatibilities."
