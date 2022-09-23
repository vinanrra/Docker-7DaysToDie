#!/bin/bash
./sdtdserver update

BASEPATH=/home/sdtdserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

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

./sdtdserver update

#update_code=$?

#if update_code -eq 0
#then
#    echo "[INFO] The server have been updated to ${VERSION,,}"
#else
#	echo "[INFO] There was a problem updating the server to ${VERSION,,}"
#fi

source $scriptsDir/Mods/mods_install.sh

echo "[INFO] The server mods have been updated to latest version, if the server crash, check mod compatibilites"
