# Mods

## IMPORTANT

Before activating or auto-updating any mods, check version compatibily, some mods will check your 7 days to die server version to install the proper version:

- [Alloc Fixes](https://7dtd.illy.bz/wiki/Server%20fixes)
- [CSMM Patron's Mod (CPM)](https://docs.csmm.app/en/cpm/)
- [Undead Legacy](https://ul.subquake.com/), only works with `stable` version of 7 days to die, but SOMETIMES will work with penultimate version, [check builds compatibily](https://ul.subquake.com/download)

Remember that some mods can't be installed with others, if you have problems with two mods installed create a [GitHub ticket](https://github.com/vinanrra/Docker-7DaysToDie/issues) and I will add a check so they can't be installed at same time.

## Auto-installable

- [Alloc Fixes](https://7dtd.illy.bz/wiki/Server%20fixes)
  - Environments:
    - ALLOC_FIXES
    - ALLOC_FIXES_UPDATE
- [Undead Legacy](https://ul.subquake.com/)
  - Environments:
    - UNDEAD_LEGACY
    - UNDEAD_LEGACY_VERSION
    - UNDEAD_LEGACY_UPDATE
      - If you enable this environment, the mod will be update every time you start the server and will take sometime.
- [enZombies](https://community.7daystodie.com/topic/24594-enzombies-more-zombie-variations/)
  - Environments:
    - ENZOMBIES
      - If you enable this environment the UndeadLegacy addon pathc will be auto-installed
    - ENZOMBIES_ADDON_SNUFKIN
    - ENZOMBIES_ADDON_ROBELOTO
    - ENZOMBIES_ADDON_NONUDES
    - ENZOMBIES_UPDATE
- [CSMM Patron's Mod (CPM)](https://docs.csmm.app/en/cpm/)
  - Environments:
    - CPM
    - CPM_UPDATE
- [BepInEz](https://github.com/BepInEx/BepInEx)
  - Environments:
    - BEPINEX
    - BEPINEX_UPDATE
- [Darkness Falls](https://community.7daystodie.com/topic/4941-darkness-falls-they-mostly-come-out-at-night/)
  - Environments:
    - DARKNESS_FALLS
    - DARKNESS_FALLS_UPDATE
    - DARKNESS_FALLS_URL
- [Ravenheartst](https://community.7daystodie.com/topic/4508-ravenhearst-mod/) (Planned)
- [War of the Walkers Mod](https://community.7daystodie.com/topic/4098-war-of-the-walkers-mod/) (Planned)
- [Age of Oblivion](https://community.7daystodie.com/topic/23943-age-of-oblivion-alpha-401-a20/) (Planned)

## Manual Mods

Just drop the mods inside the Mods folder in `/path/to/ServerFiles/Mods`, restart the container and the server will automatically load them.
