#!/bin/bash
BASEPATH=/home/sdtdserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

source $scriptsDir/utils/set_version.sh

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
