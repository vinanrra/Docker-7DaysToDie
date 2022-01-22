#!/bin/bash
./sdtdserver update

if [ "${VERSION,,}" == 'stable'  ]
    then
        sed -i 's/branch=".*"/branch=""/' /home/sdtdserver/lgsm/config-lgsm/sdtdserver/common.cfg
    else
        sed -i "s/branch=".*"/branch="\"${VERSION,,}"\"/" /home/sdtdserver/lgsm/config-lgsm/sdtdserver/common.cfg
        echo "
            =======================================================================
            IMPORTANT:
            
            Server version changed to: ${VERSION,,}
            
            =======================================================================
        "
fi

./sdtdserver update

echo "
    =======================================================================
    IMPORTANT:

    The server have been updated to ${VERSION,,}
    =======================================================================
"

source $scriptsDir/Mods/mods_install.sh

echo "
    =======================================================================
    IMPORTANT:

    The server mods have been updated to latest version
    If the server crash, check mod compatibilites
    =======================================================================
"
