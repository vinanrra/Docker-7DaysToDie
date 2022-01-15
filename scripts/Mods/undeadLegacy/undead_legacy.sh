#!/bin/sh

SERVERFILES_FOLDER=/home/sdtdserver/serverfiles
CONFIG_FILE=/home/sdtdserver/serverfiles/7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config
DL_LINK="https://ul.subquake.com/dl/dl.php?v=exp"

downloadRelease() {
    curl $DL_LINK -SsL -o undeadlegacy.zip
}

echo "[Undead Legacy] Downloading release from $DL_LINK"

echo "[Undead Legacy] Downloading files"

downloadRelease

echo "[Undead Legacy] Extracting files"

mkdir -p undeadlegacy-temp
unzip undeadlegacy.zip -d undeadlegacy-temp

echo "[Undead Legacy] Installing components"

mv undeadlegacy-temp/UndeadLegacyExperimental-main/* $SERVERFILES_FOLDER

echo "[Undead Legacy] Cleanup"

rm undeadlegacy.zip
rm -rf undeadlegacy-temp

echo "[Undead Legacy] Replacing 7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config"

cp -f /home/sdtdserver/scripts/Mods/undeadLegacy/files/config $CONFIG_FILE

echo "[Undead Legacy] Fixing permissions"

chmod +x $SERVERFILES_FOLDER/run_bepinex_server.sh

echo "[Undead Legacy] Finished! ヽ(´▽\`)/"