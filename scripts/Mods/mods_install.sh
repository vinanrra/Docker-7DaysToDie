#!/bin/bash
set -e

echo "[INFO] Installing mods after first start"

# Install Alloc Fixes

if [ "${ALLOC_FIXES,,}" == 'yes'  ]
  then
    source "$scriptsDir/Mods/alloc_fixes.sh"
fi

if [ "${UNDEAD_LEGACY,,}" == 'yes' ] && [ "${DARKNESS_FALLS,,}" == 'yes' ]
  then
    echo "[ERROR] Aborting overhaul mods installation, you can't install two overhaul mods at same time enable Undead Legacy or Darkness falls, not both"
else
  # Install Undead Legacy

  if [ "${UNDEAD_LEGACY,,}" == 'yes'  ]
    then
      source "$scriptsDir/Mods/undead_legacy.sh"
  fi

  if [ "${DARKNESS_FALLS,,}" == 'yes'  ]
    then
      source "$scriptsDir/Mods/darkness_falls.sh"
  fi
fi

if [ "${BEPINEX,,}" == 'yes'  ] && [ "${UNDEAD_LEGACY,,}" == 'no'  ]
  then
    source "$scriptsDir/Mods/bepinex.sh"
fi

if [ "$MODS_URLS" != "" ]; then
    source "$scriptsDir/Mods/mods_downloader.sh"
fi
