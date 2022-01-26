#!/bin/bash



if [ "${CPM,,}" == 'yes'  ] || [ "${CPM_UPDATE,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/cpm.sh
    # To force install of Alloc Fixes
    ALLOC_FIXES=yes
fi

# Install Alloc Fixes, always after CPM, because CPM requiere Alloc fixes

if [ "${ALLOC_FIXES,,}" == 'yes'  ] || [ "${ALLOC_FIXES,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/alloc_fixes.sh
fi

# Install Undead Legacy

if [ "${UNDEAD_LEGACY,,}" == 'yes'  ] || [ "${UNDEAD_LEGACY_UPDATE,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/undead_legacy.sh
    # To install fix for enZombies with Undead Legacy
    ENZOMBIES_UL_PATCH=yes
fi

# Install enZombies + addons always after Undead Legacy, because if installed with Undead Legacy need a patch
if [ "${ENZOMBIES,,}" == 'yes'  ] || [ "${ENZOMBIES_UPDATE,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/enZombies.sh
fi
