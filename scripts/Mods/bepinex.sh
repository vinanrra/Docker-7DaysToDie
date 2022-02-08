#!/bin/bash

BASEPATH="/home/sdtdserver"
SERVERFILES_FOLDER="${BASEPATH}/serverfiles"
BEPINEX_SH="${SERVERFILES_FOLDER}/run_bepinex.sh"
LSGMSDTDSERVERCFG="${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg"

# Get latest version
DL_LINK=$(curl -L -s https://api.github.com/repos/BepInEx/BepInEx/releases/latest | grep -o -E "https://github.com/BepInEx/BepInEx/releases/download/(.*)/BepInEx_unix_(.*).zip")

downloadRelease() {
    curl "$DL_LINK" -SsL -o BepInEx.zip
}

echo "[BepInEx] Downloading release from ${DL_LINK}"

echo "[BepInEx] Downloading files"

downloadRelease

echo "[BepInEx] Extracting files"

mkdir -p BepInEx-temp
unzip -q BepInEx.zip -d BepInEx-temp

echo "[BepInEx] Removing older version"

rm -rf $SERVERFILES_FOLDER/BepInEx
rm -rf $SERVERFILES_FOLDER/doorstop_libs

echo "[BepInEx] Installing components"

cp -a BepInEx-temp/. $SERVERFILES_FOLDER

echo "[BepInEx] Editing run_bepinex.sh"

echo "[BepInEx] Editing executable_name"

if grep -q "7DaysToDieServer.x86_64" $BEPINEX_SH
    then
        echo "[BepInEx] Skiping executable_name changes, already replaced"
    else
        sed -i '/.*executable_name="".*/ s/""/"7DaysToDieServer.x86_64"/' $BEPINEX_SH
fi

echo "[BepInEx] Editing command last execution"

if grep -q "sdtdserver.xml" $BEPINEX_SH
    then
        sed -i '/.*config_file=""/ s/""/sdtdserver.xml/' $BEPINEX_SH
    else
        sed -i '/^.*NEEDED.*/a config_file="sdtdserver.xml"' $BEPINEX_SH
        sed -i '/"${executable_path}"/ s/"${executable_path}"/"${executable_path}" -configfile=$config_file/' $BEPINEX_SH
fi

echo "[BepInEx] Fixing executable_type"

sed -i 's/executable_type=.*/executable_type=$(LD_PRELOAD="" file -b "${executable_path}")/' $BEPINEX_SH

echo "[BepInEx] Replacing start parameters for LinuxGSM"

if grep -q "startparameters" $LSGMSDTDSERVERCFG
    then
        sed -i 's/startparameters=.*/startparameters=""/' $LSGMSDTDSERVERCFG
    else
        echo startparameters='""' >> $LSGMSDTDSERVERCFG
fi

echo "[BepInEx] Replacing executable for LinuxGSM"

if grep -q "executable" $LSGMSDTDSERVERCFG
    then
        sed -i 's/executable=.*/executable=".\/run_bepinex.sh"/' $LSGMSDTDSERVERCFG
    else
        echo executable='"./run_bepinex.sh"' >> $LSGMSDTDSERVERCFG
fi

echo "[BepInEx] Applying executable permssions"

chmod u+x $BEPINEX_SH

echo "[BepInEx] Cleanup"

rm BepInEx.zip
rm -rf BepInEx-temp

echo "[BepInEx] Finished! ヽ(´▽\`)/"
