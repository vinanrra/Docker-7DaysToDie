#!/bin/bash
set -e

BASEPATH=/home/sdtdserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

source "$scriptsDir/check_space.sh"

if [ "${space,,}" == 'no'  ]; then
    echo "[ERROR] Not enough space, needed: 12 GB, available: $freeGB GB"
    exit 1
fi

echo "[INFO] Executing LinuxGSM script to get default files"

# Start to create default files
./sdtdserver || true # It might exit with non-zero if just showing help or initializing

echo "[INFO] Changing 7 days to die server version to install"

# If missing file create
if [ ! -f "$LSGMSDTDSERVERCFG" ]
then
    mkdir -p "${BASEPATH}/lgsm/config-lgsm/sdtdserver/"
    touch "$LSGMSDTDSERVERCFG"
fi

# Check version
source "$scriptsDir/utils/set_version.sh"

echo "[INFO] Installing 7 days to die ${VERSION,,} version"

# Install 7 Days To Die Server
./sdtdserver auto-install

echo "[INFO] The server have been installed."

echo "If this file is missing, server will be re-installed" > serverfiles/DONT_REMOVE.txt
echo "To prevent double mod install at first start" > serverfiles/MOD_BLOCK.txt

# Creating 7 Days to Die mod folder
mkdir -p /home/sdtdserver/serverfiles/Mods

source "$scriptsDir/Mods/mods_install.sh"
