#!/bin/bash

# I prefer that people tripple check their mods with the following steps, to avoid issues:
# Enable mod per environment
# Enable auto update mod with UPDATE_MODS=yes
# Enable per mod update with their *_UPDATE

echo "[INFO] Updating/Installing mods"

if [ "${CPM,,}" == 'yes'  ] && [ "${CPM_UPDATE,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/cpm.sh
fi

# Install Alloc Fixes, always after CPM, because CPM requiere Alloc fixes

if [ "${ALLOC_FIXES,,}" == 'yes'  ] && [ "${ALLOC_FIXES_UPDATE,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/alloc_fixes.sh
fi

# Install Undead Legacy

if [ "${UNDEAD_LEGACY,,}" == 'yes'  ] && [ "${UNDEAD_LEGACY_UPDATE,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/undead_legacy.sh
    # To install fix for enZombies with Undead Legacy
    ENZOMBIES_UL_PATCH=yes
fi

# Install enZombies + addons always after Undead Legacy, because if installed with Undead Legacy need a patch
if [ "${ENZOMBIES,,}" == 'yes'  ] && [ "${ENZOMBIES_UPDATE,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/enZombies.sh
fi
