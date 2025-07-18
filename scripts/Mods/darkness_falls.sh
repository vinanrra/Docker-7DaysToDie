#!/bin/bash

SERVER_FOLDER=/home/sdtdserver/serverfiles
VERSION=${VERSION,,}
DF_CONFIG="DarknessFallsServerConfig.xml"

# Change DL_LINK depending on 7 days to die branch version
if [ "${DARKNESS_FALLS_URL}" != "False"  ]; then
    DL_LINK=$DARKNESS_FALLS_URL
    echo "[Darkness Falls] Using custom provided url $DARKNESS_FALLS_URL , if this fails check if you can git clone the URL"
else
    # Change DL_LINK depending on 7 days to die branch version
    if [ "${VERSION}" == 'stable' ] || [ "${VERSION}" == 'public' ]; then
        echo "[Darkness Falls] No version found compatible with version ${VERSION}, you need to choose a version. Example: alpha21"
        echo "[Darkness Falls] If there is a compatible version check -> https://community.7daystodie.com/topic/4941-darkness-falls-they-mostly-come-out-at-night/ and install it manually or using DARKNESS_FALLS_URL"
        echo "[Darkness Falls] Omitting installation"
        exit
    elif [ "${VERSION::7}" == 'v1.4' ]; then
        DL_LINK="https://dev.azure.com/KhaineUK/_git/Darkness%20Falls%20V6"
    elif [ "${VERSION::7}" == 'alpha21' ]; then
        DL_LINK="https://dev.azure.com/KhaineUK/_git/DarknessFallsA21"
    elif [ "${VERSION::7}" == 'alpha20' ]; then
        DL_LINK="https://dev.azure.com/KhaineUK/_git/DarknessFallsA20"
        DF_CONFIG="DarknessFallsConfig.xml"
    else
        echo "[Darkness Falls] No version found compatible with version ${VERSION}"
        echo "[Darkness Falls] If there is a compatible version check -> https://community.7daystodie.com/topic/4941-darkness-falls-they-mostly-come-out-at-night/ and install it manually or using DARKNESS_FALLS_URL"
        echo "[Darkness Falls] Omitting installation"
        exit
    fi
fi

downloadRelease() {
    git clone --progress "$DL_LINK" darknessFalls-temp/
}

echo "[Darkness Falls] Downloading release from $DL_LINK"

# TODO - Catch if fails and print msg
downloadRelease

echo "[Darkness Falls] Installing"

cp -a darknessFalls-temp/Mods/. $SERVER_FOLDER/Mods

echo "[Darkness Falls] Copying Darkness Falls worlds"

cp -r darknessFalls-temp/Mods/0-DarknessFallsCore/Worlds/* $SERVER_FOLDER/Data/Worlds/

echo "[Darkness Falls] Change Darkness Falls server settings"

if [ "${VERSION::7}" == 'alpha21' ]; then
    cp darknessFalls-temp/Mods/$DF_CONFIG $SERVER_FOLDER/sdtdserver.xml
elif [ "${VERSION::7}" == 'alpha20' ]; then
    cp darknessFalls-temp/$DF_CONFIG $SERVER_FOLDER/sdtdserver.xml
fi

echo "[Darkness Falls] Change default map"

sed -i '/.*GameWorld.*/ s/DFalls-Small1-NoCP/DFalls-Small1-NoPEP/' $SERVER_FOLDER/sdtdserver.xml

echo "[Darkness Falls] Remove folder and file localtions"

sed -i '/UserDataFolder/s/\(^.*$\)//' $SERVER_FOLDER/sdtdserver.xml
sed -i '/SaveGameFolder/s/\(^.*$\)//' $SERVER_FOLDER/sdtdserver.xml

echo "[Darkness Falls] Cleanup"

rm -rf darknessFalls-temp

echo "[Darkness Falls] Finished! ヽ(´▽\`)/"
