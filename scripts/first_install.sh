#!/bin/bash

BASEPATH=/home/sdtdserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

source $scriptsDir/check_space.sh

if [ "${space,,}" == 'no'  ]; then
    echo "
        =======================================================================
        ERROR:

        Not enough space.

        Needed: 12 GB
        Available: $freeGB GB

        =======================================================================
    "
    exit
fi

echo "
    =======================================================================
    IMPORTANT:

    It seems to be the first installation, making preparations...
    =======================================================================
"

# Start to create default files
./sdtdserver

echo "
    =======================================================================
    IMPORTANT:

    PREPARATIONS COMPLETED

    Making first server installation.
    =======================================================================
"

if [ ! -f $LSGMSDTDSERVERCFG ]
then
    mkdir -p ${BASEPATH}/lgsm/config-lgsm/sdtdserver/
    touch $LSGMSDTDSERVERCFG
fi

# Check version

if [ "${VERSION,,}" == 'stable'  ]
    then
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i "s/branch=.*/branch=\"\"/" $LSGMSDTDSERVERCFG
                echo "[INFO] Version changed to ${VERSION,,}"
            else
                echo "[INFO] Already on ${VERSION,,}"
        fi
    else
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i 's/branch=.*/branch="$VERSION"/' $LSGMSDTDSERVERCFG
            else
                echo branch='"-beta $VERSION"' >> $LSGMSDTDSERVERCFG
                echo "[INFO] Version changed to ${VERSION,,}"
        fi
fi

echo "
    =======================================================================
    IMPORTANT:

    INSTALLING: ${VERSION,,}
    =======================================================================
"

# Install 7 Days To Die Server

./sdtdserver auto-install

echo "
    =======================================================================
    IMPORTANT:
    
    The server have been installed.
    More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
    =======================================================================
"

echo "If this file is missing, server will be re-installed" > serverfiles/DONT_REMOVE.txt

# Creating 7 Days to Die mod folder
mkdir /home/sdtdserver/serverfiles/Mods

source $scriptsDir/Mods/mods_install.sh
