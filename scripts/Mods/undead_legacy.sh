#!/bin/bash

# Uncomment if used outside of the Docker
#UNDEAD_LEGACY_VERSION=stable

# Edit paths if used outside of the Docker
BASEPATH=/home/sdtdserver
SERVERFILES_FOLDER=${BASEPATH}/serverfiles
CONFIG_FILE=${SERVERFILES_FOLDER}/7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
SERVER_CONFIG=${SERVERFILES_FOLDER}/sdtdserver.xml

# Dont edit nothing here unless you know what you are doing

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
    curl $DL_LINK -SsL -o undeadlegacy.zip
}

echo "[Undead Legacy] Downloading release from $DL_LINK"

echo "[Undead Legacy] Downloading files"

downloadRelease

echo "[Undead Legacy] Extracting files"

mkdir -p undeadlegacy-temp
unzip undeadlegacy.zip -d undeadlegacy-temp

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

# grep -R "string" "filepath"
if grep -R "Undead Legacy specific options" "$SERVER_CONFIG"
    then
        echo "[Undead Legacy] Skipping default options to server configuration, already added"
    else
        sed -i '$i\ '\\r\\t'<!-- Undead Legacy specific options -->'\\r\\t'<property name="RecipeFilter"\tvalue="0"/>'\\r\\t'<property name="StarterQuestEnabled"\tvalue="true"/>'\\r\\t'<property name="WanderingHordeFrequency"\tvalue="4"/>'\\r\\t'<property name="WanderingHordeRange"\tvalue="8"/>'\\r\\t'<property name="WanderingHordeEnemyCount"\tvalue="10"/>'\\r\\t'<property name="WanderingHordeEnemyRange"\tvalue="10"/>' $SERVER_CONFIG
fi

echo "[Undead Legacy] Disabling EAC"

sed -i 's/.*EACEnabled.*/\t<property name="EACEnabled"\t\t\t\tvalue="false"\/>\t\t\t\t<!-- Enables\/Disables EasyAntiCheat -->/' $SERVER_CONFIG

echo "[Undead Legacy] Adding missing dll to 7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config"

if grep -R "libdl.so.2" "$SERVER_CONFIG"
    then
        echo "[Undead Legacy] Skipping missing dll, already added"
    else
        missingDLL=$(sed '$ i\\t<dllmap dll="dl" target="libdl.so.2"/>' $CONFIG_FILE)
        echo "$missingDLL" > $CONFIG_FILE
fi

echo "[Undead Legacy] Fixing permissions"

chmod +x $SERVERFILES_FOLDER/run_bepinex_server.sh

echo "[Undead Legacy] Replacing config file used in UndeadLegacy startup script"

if grep -R "sdtdserver" "$SERVER_CONFIG"
    then
        echo "[Undead Legacy] Skiping config file changes, already replaced"
    else
        sed -i 's/config_file.*/config_file="sdtdserver.xml"/' $SERVERFILES_FOLDER/run_bepinex_server.sh
fi

echo "[Undead Legacy] Replacing start parameters for LinuxGSM"

if grep -R "startparameters" "$SERVER_CONFIG"
    then
        sed -i 's/startparameters=.*/startparameters=""/' $LSGMSDTDSERVERCFG
    else
        echo startparameters='""' >> $LSGMSDTDSERVERCFG
fi

echo "[Undead Legacy] Replacing executable for LinuxGSM"

if grep -R "startparameters" "$SERVER_CONFIG"
    then
        sed -i 's/executable=.*/executable=".\/run_bepinex_server.sh"/' $LSGMSDTDSERVERCFG
    else
        echo executable='"./run_bepinex_server.sh"' >> $LSGMSDTDSERVERCFG
fi

echo "[Undead Legacy] Installed ヽ(´▽\`)/"
