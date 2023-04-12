#!/bin/bash

# I prefer that people tripple check their mods with the following steps, to avoid issues:
# Enable mod per environment
# Enable auto update mod with UPDATE_MODS=yes
# Enable per mod update with their *_UPDATE

BASEPATH=/home/sdtdserver
MODS_FOLDER=${BASEPATH}/Mods

echo "[INFO] Updating/Installing mods"

if [ "${CPM,,}" == 'yes' ] && [ "${CPM_UPDATE,,}" == 'yes' ]
  then
    source $scriptsDir/Mods/cpm.sh
    # Install Allocs Fixes if missing
    echo "[CSMM - CPM] Checking if Allocs Fixes it is installed"
    if [ ! -d "$MODS_FOLDER/Allocs_CommandExtensions" ] || [ ! -d "$MODS_FOLDER/Allocs_CommonFunc" ] || [ ! -d "$MODS_FOLDER/Allocs_WebAndMapRendering" ]; then
      # Take action if $DIR not exists
      echo "[CSMM - CPM] Allocs fixes missing, installing it"
      source $scriptsDir/Mods/alloc_fixes.sh

      else
      echo "[CSMM - CPM] Allocs Fixes it is already installed"
    fi
    
fi

# Install Alloc Fixes, always after CPM, because CPM requiere Alloc fixes

if [ "${ALLOC_FIXES,,}" == 'yes' ] && [ "${ALLOC_FIXES_UPDATE,,}" == 'yes' ]
  then
    source $scriptsDir/Mods/alloc_fixes.sh
fi

# Check if UL and Darkness Falls are both active and print error to only allow 

if [ "${UNDEAD_LEGACY,,}" == 'yes' ] && [ "${DARKNESS_FALLS,,}" == 'yes' ]
  then
    echo "[ERROR] Aborting overhaul mods installation, you can't install two overhaul mods at same time enable Undead Legacy or Darkness falls, not both"
else
  # Install Undead Legacy

  if [ "${UNDEAD_LEGACY,,}" == 'yes' ] && [ "${UNDEAD_LEGACY_UPDATE,,}" == 'yes' ]
    then
      source $scriptsDir/Mods/undead_legacy.sh
  fi

  # Install Darkness Falls

  if [ "${DARKNESS_FALLS,,}" == 'yes' ] && [ "${DARKNESS_FALLS_UPDATE,,}" == 'yes' ]
    then
      source $scriptsDir/Mods/darkness_falls.sh
  fi
fi

# Install enZombies + addons always after Undead Legacy, because if installed with Undead Legacy need a patch
if [ "${ENZOMBIES,,}" == 'yes' ] && [ "${ENZOMBIES_UPDATE,,}" == 'yes' ]
  then
    source $scriptsDir/Mods/enZombies.sh
fi

if [ "${BEPINEX,,}" == 'yes' ] && [ "${BEPINEX_UPDATE,,}" == 'yes' ] && [ "${UNDEAD_LEGACY,,}" == 'no' ]
  then
    source $scriptsDir/Mods/bepinex.sh
fi

echo "[INFO] Updating/Installing mods finished"
