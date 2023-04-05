#!/bin/bash

MODS_FOLDER=/home/sdtdserver/serverfiles/Mods
VERSION=${VERSION,,}


# Change DL_LINK depending on 7 days to die branch version
if [ "${DARKNESS_FALLS_URL}" != "False"  ]; then
    DL_LINK=$DARKNESS_FALLS_URL
    echo "[Darkness Falls] Using custom provided url $DARKNESS_FALLS_URL , if this fails check if you can git clone the URL"
else
    # Change DL_LINK depending on 7 days to die branch version
    if [ "${VERSION,,}" == 'stable' ] || [ "${VERSION,,}" == 'public' ]; then
        DL_LINK="https://dev.azure.com/KhaineUK/_git/DarknessFallsA20"
    elif [ "${VERSION::7}" == 'alpha20' ]; then
        DL_LINK="https://dev.azure.com/KhaineUK/_git/DarknessFallsA20"
    else
        echo "[Darkness Falls] No version found compatible with version ${VERSION}"
        echo "[Darkness Falls] If there is a compatible version check -> https://community.7daystodie.com/topic/4941-darkness-falls-they-mostly-come-out-at-night/ and install it manually"
        echo "[Darkness Falls] Omitting installation"
    fi
fi

downloadRelease() {
    git clone $DL_LINK darknessFalls-temp/
}

echo "[Darkness Falls] Downloading release from $DARKNESS_FALL_URL"

# TODO - Catch if fails and print msg
downloadRelease

echo "[Darkness Falls] Installing"

cp -a darknessFalls-temp/Mods/. serverfiles/Mods

echo "[Darkness Falls] Copying Darkness Falls worlds"

cp -r darknessFalls-temp/Mods/0-DarknessFallsCore/Worlds/* serverfiles/Data/Worlds/

echo "[Darkness Falls] Copying Darkness Falls server settings"

cp darknessFalls-temp/DarknessFallsConfig.xml serverfiles/sdtdserver.xml

echo "[Darkness Falls] Cleanup"

rm -rf darknessFalls-temp

echo "[Darkness Falls] Finished! ヽ(´▽\`)/"
