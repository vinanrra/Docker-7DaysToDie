#!/bin/bash

MODS_FOLDER=/home/sdtdserver/serverfiles/Mods
VERSION=${VERSION,,}


# Change DL_LINK depending on 7 days to die branch version
if [ "${DARKNESS_FALL_URL,,}" == "False"  ]; then
    echo "[Darkness Fall] Using custom provided url $DARKNESS_FALL_URL , if this fails check if you can git clone the URL"
else
  # Change DL_LINK depending on 7 days to die branch version
  if [ "${VERSION,,}" == 'stable' ] || [ "${VERSION,,}" == 'public' ]; then
      DL_LINK="https://dev.azure.com/KhaineUK/_git/DarknessFallsA20"
  elif [ "${VERSION::7}" == 'alpha20' ]; then
      DL_LINK="https://dev.azure.com/KhaineUK/_git/DarknessFallsA20"
  else
      echo "[Darkness Fall] No version found compatible with version ${VERSION}"
      echo "[Darkness Fall] If there is a compatible version check -> https://community.7daystodie.com/topic/4941-darkness-falls-they-mostly-come-out-at-night/ and install it manually"
      echo "[Darkness Fall] Omitting installation"
  fi
fi

downloadRelease() {
    git clone $DARKNESS_FALL_URL darknessFall-temp/

echo "[Darkness Fall] Downloading release from $DARKNESS_FALL_URL"

# TODO - Catch if fails and print msg
downloadRelease

echo "[Darkness Fall] Installing"

cp -a darknessFall-temp/Mods/. serverfiles/Mods

echo "[Darkness Fall] Copying Darkness Fall worlds"

cp -r darknessFall-temp/Mods/0-DarknessFallsCore/Worlds/* serverfiles/Data/Worlds/

echo "[Darkness Fall] Copying Darkness Fall server settings"

cp darknessFall-temp/DarknessFallsConfig.xml serverfiles/sdtdserver.xml

echo "[Darkness Fall] Cleanup"

rm -rf darknessFall-temp

echo "[Darkness Fall] Finished! ヽ(´▽\`)/"
