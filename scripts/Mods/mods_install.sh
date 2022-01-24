# Install Alloc Fixes

if [ "${ALLOC_FIXES,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/alloc_fixes.sh
fi

# Install Undead Legacy

if [ "${UNDEAD_LEGACY,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/undead_legacy.sh
fi

if [ "${ENZOMBIES,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/enZombies.sh
fi
