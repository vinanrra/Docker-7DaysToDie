#!/bin/sh

# Uncomment if used outside of the Docker
#UndeadLegacyVersion=stable

# Edit paths if used outside of the Docker
BASEPATH=/home/sdtdserver
SERVERFILES_FOLDER=${BASEPATH}/serverfiles
CONFIG_FILE=${BASEPATH}/serverfiles/7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

if [ "${UndeadLegacyVersion,,}" == 'exp'  ]; then
    echo "[Undead Legacy] Starting install of Undead Legacy ${UndeadLegacyVersion,,} version"
elif  [ "${UndeadLegacyVersion,,}" == 'stable'  ]; then

    echo "[Undead Legacy] Starting install of Undead Legacy ${UndeadLegacyVersion,,} version"
else
    echo "[Undead Legacy] Error wrong version selected -> ${UndeadLegacyVersion,,}, select exp or stable"
    echo "[Undead Legacy] Skipping installation"
    exit
fi

DL_LINK="https://ul.subquake.com/dl/dl.php?v=${UndeadLegacyVersion,,}"

downloadRelease() {
    curl $DL_LINK -SsL -o undeadlegacy.zip
}

echo "[Undead Legacy] Downloading release from $DL_LINK"

echo "[Undead Legacy] Downloading files"

downloadRelease

echo "[Undead Legacy] Extracting files"

mkdir -p undeadlegacy-temp
unzip undeadlegacy.zip -d undeadlegacy-temp

echo "[Undead Legacy] Installing mod"

if [ "${UndeadLegacyVersion,,}" == 'exp'  ]; then
    mv undeadlegacy-temp/UndeadLegacyExperimental-main/* $SERVERFILES_FOLDER
elif  [ "${UndeadLegacyVersion,,}" == 'stable'  ]; then

    mv undeadlegacy-temp/UndeadLegacy-master/* $SERVERFILES_FOLDER
else
    echo "[Undead Legacy] Error wrong version selected -> ${UndeadLegacyVersion,,}, select exp or stable"
    echo "[Undead Legacy] Skipping installation"
    exit
fi

echo "[Undead Legacy] Cleanup"

rm undeadlegacy.zip
rm -rf undeadlegacy-temp

# Need to remove use of file and instead add it with sed command
echo "[Undead Legacy] Adding missing dll to 7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config"

cp -f ${BASEPATH}/scripts/Mods/undeadLegacy/files/config $CONFIG_FILE

echo "[Undead Legacy] Fixing permissions"

chmod +x $SERVERFILES_FOLDER/run_bepinex_server.sh

echo "[Undead Legacy] Replacing config file used in UndeadLegacy startup script"

sed -i 's/serverconfig.xml/sdtdserver.xml/' $SERVERFILES_FOLDER/run_bepinex_server.sh

# Comment if not using LinuxGSM script
echo "[Undead Legacy] Replacing executable and start parameters for LinuxGSM"

echo startparameters='""' >> $LSGMSDTDSERVERCFG
echo executable='"./run_bepinex_server.sh"' >> $LSGMSDTDSERVERCFG
# Comment if not using LinuxGSM script

echo "[Undead Legacy] Installed ヽ(´▽\`)/"

# Provisional, will be replaced if this work -> https://github.com/GameServerManagers/LinuxGSM/discussions/3755
# Uncomment if not using linuxGSM script
#echo "[Undead Legacy] Starting the server ヽ(´▽\`)/"

# cd $SERVERFILES_FOLDER

# bash run_bepinex_server.sh
