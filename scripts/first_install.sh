#!/bin/bash

BASEPATH=/home/sdtdserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

source $scriptsDir/check_space.sh

if [ "${space,,}" == 'no'  ]; then
    echo "[ERROR] Not enough space, needed: 12 GB, available: $freeGB GB"
    exit
fi

echo "[INFO] Executing LinuxGSM script to get default files"

# Start to create default files
./sdtdserver

echo "[INFO] Changing 7 days to die server version to install"

# If missing file create
if [ ! -f $LSGMSDTDSERVERCFG ]
then
    mkdir -p ${BASEPATH}/lgsm/config-lgsm/sdtdserver/
    touch $LSGMSDTDSERVERCFG
fi

# Check version

if [ "${VERSION,,}" == 'stable'  ] || [ "${VERSION,,}" == 'public'  ]
    then
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i "s/branch=.*/branch=\"\"/" $LSGMSDTDSERVERCFG
                echo "[INFO] Version changed to ${VERSION,,}"
            else
                echo "[INFO] Selecting 7 days to die ${VERSION,,} version"
        fi
    else
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i "s/branch=".*"/branch=\"-beta ${VERSION,,}"\"/ $LSGMSDTDSERVERCFG
            else
                echo branch=\"-beta "${VERSION}"\" >> $LSGMSDTDSERVERCFG
                echo "[INFO] Selecting 7 days to die ${VERSION,,} version"
        fi
fi

echo "[INFO] Installing 7 days to die ${VERSION,,} version"

# Install 7 Days To Die Server

./sdtdserver auto-install

echo "[INFO] The server have been installed."

echo "If this file is missing, server will be re-installed" > serverfiles/DONT_REMOVE.txt

echo "To prevent double mod install at first start" > serverfiles/MOD_BLOCK.txt

# Creating 7 Days to Die mod folder
mkdir /home/sdtdserver/serverfiles/Mods

source $scriptsDir/Mods/mods_install.sh
