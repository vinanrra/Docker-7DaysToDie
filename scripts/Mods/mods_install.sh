# Install Alloc Fixes

if [ "${ALLOC_FIXES,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/alloc_fixes.sh

    echo "
      =======================================================================
      IMPORTANT:

      Alloc Fixes updated.
      =======================================================================
    "
  else
    echo "
      =======================================================================
      IMPORTANT:

      Not installing Alloc Fixes.
      =======================================================================
    "
fi

# Install Alloc Fixes

if [ "${UNDEAD_LEGACY,,}" == 'yes'  ]
  then
    source $scriptsDir/Mods/undead_legacy.sh

    echo "
      =======================================================================
      IMPORTANT:

      Undead Legacy installed.
      =======================================================================
    "
  else
    echo "
      =======================================================================
      IMPORTANT:

      Not installing Undead Legacy.
      =======================================================================
    "
fi