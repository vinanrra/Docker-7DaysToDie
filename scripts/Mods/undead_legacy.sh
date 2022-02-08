#!/bin/bash

BASEPATH=/home/sdtdserver
SERVERFILES_FOLDER=${BASEPATH}/serverfiles
CONFIG_FILE=${SERVERFILES_FOLDER}/7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
SERVER_CONFIG=${SERVERFILES_FOLDER}/sdtdserver.xml

if [ "${UNDEAD_LEGACY_VERSION,,}" == 'exp'  ]; then
        echo "[Undead Legacy] Starting install of Undead Legacy ${UNDEAD_LEGACY_VERSION,,} version"
    elif  [ "${UNDEAD_LEGACY_VERSION,,}" == 'stable'  ]; then

        echo "[Undead Legacy] Starting install of Undead Legacy ${UNDEAD_LEGACY_VERSION,,} version"
    else
        echo "[Undead Legacy] Error wrong version selected -> ${UNDEAD_LEGACY_VERSION,,}, select exp or stable"
        echo "[Undead Legacy] Skipping installation"
        exit
fi

DL_LINK="https://ul.subquake.com/dl?v=${UNDEAD_LEGACY_VERSION,,}"

downloadRelease() {
    curl "$DL_LINK" -SsL -o undeadlegacy.zip
}

echo "[Undead Legacy] Downloading release from $DL_LINK"

echo "[Undead Legacy] Downloading files"

downloadRelease

echo "[Undead Legacy] Extracting files"

mkdir -p undeadlegacy-temp
unzip -q undeadlegacy.zip -d undeadlegacy-temp

if [ -d "$SERVERFILES_FOLDER/BepInEx" ]
then
    echo "[Undead Legacy] Removing existing BepInEx, because Undead Legacy already come with BepInEx"
    rm -rf $SERVERFILES_FOLDER/BepInEx
    rm -rf $SERVERFILES_FOLDER/doorstop_libs
fi

echo "[Undead Legacy] Installing mod"

if [ "${UNDEAD_LEGACY_VERSION,,}" == 'exp'  ]; then
        cp -a undeadlegacy-temp/UndeadLegacyExperimental-main/. $SERVERFILES_FOLDER
    elif  [ "${UNDEAD_LEGACY_VERSION,,}" == 'stable'  ]; then
        cp -a undeadlegacy-temp/UndeadLegacyStable-main/. $SERVERFILES_FOLDER
    else
        echo "[Undead Legacy] Error wrong version selected -> ${UNDEAD_LEGACY_VERSION,,}, select exp or stable"
        echo "[Undead Legacy] Skipping installation"
        exit
fi

echo "[Undead Legacy] Cleanup"

rm undeadlegacy.zip
rm -rf undeadlegacy-temp

echo "[Undead Legacy] Adding Undead Legacy default options to server configuration"

if grep -q "Undead Legacy specific options" $SERVER_CONFIG
    then
        echo "[Undead Legacy] Skipping default options to server configuration, already added"
    else
        sed -i '$i\ '\\r\\t'<!-- Undead Legacy specific options -->'\\r\\t'<property name="RecipeFilter"\tvalue="0"/>'\\r\\t'<property name="StarterQuestEnabled"\tvalue="true"/>'\\r\\t'<property name="WanderingHordeFrequency"\tvalue="4"/>'\\r\\t'<property name="WanderingHordeRange"\tvalue="8"/>'\\r\\t'<property name="WanderingHordeEnemyCount"\tvalue="5"/>'\\r\\t'<property name="WanderingHordeEnemyRange"\tvalue="10"/>' $SERVER_CONFIG
fi

echo "[Undead Legacy] Disabling EAC"

sed -i '/.*EACEnabled.*/ s/true/false/' $SERVER_CONFIG

echo "[Undead Legacy] Adding missing dll to 7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config"

if grep -q "libdl.so.2" $CONFIG_FILE
    then
        echo "[Undead Legacy] Skipping missing dll, already added"
    else
        sed -i '$i\ '\\t'<dllmap dll="dl" target="libdl.so.2"\/>' $CONFIG_FILE
fi

echo "[Undead Legacy] Fixing permissions"

chmod +x $SERVERFILES_FOLDER/run_bepinex_server.sh

echo "[Undead Legacy] Replacing config file used in UndeadLegacy startup script"

if grep -q "sdtdserver.xml" $SERVERFILES_FOLDER/run_bepinex_server.sh
    then
        echo "[Undead Legacy] Skiping config file changes, already replaced"
    else
        sed -i '/.*config_file="serverconfig.xml".*/ s/serverconfig.xml/sdtdserver.xml/' $SERVERFILES_FOLDER/run_bepinex_server.sh
fi

echo "[Undead Legacy] Replacing Monitoring start time for LinuxGSM"

if grep -q "querydelay" $LSGMSDTDSERVERCFG
    then
        sed -i 's/querydelay=.*/querydelay="10"/' $LSGMSDTDSERVERCFG
    else
        echo querydelay='"10"' >> $LSGMSDTDSERVERCFG
fi

echo "[Undead Legacy] Replacing start parameters for LinuxGSM"

if grep -q "startparameters" $LSGMSDTDSERVERCFG
    then
        sed -i 's/startparameters=.*/startparameters=""/' $LSGMSDTDSERVERCFG
    else
        echo startparameters='""' >> $LSGMSDTDSERVERCFG
fi

echo "[Undead Legacy] Replacing executable for LinuxGSM"

if grep -q "executable" $LSGMSDTDSERVERCFG
    then
        sed -i 's/executable=.*/executable=".\/run_bepinex_server.sh"/' $LSGMSDTDSERVERCFG
    else
        echo executable='"./run_bepinex_server.sh"' >> $LSGMSDTDSERVERCFG
fi

echo "[Undead Legacy] Installed ヽ(´▽\`)/"
