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
- [CSMM Patron's Mod (CPM)](https://docs.csmm.app/en/cpm/)
  - Environments:
    - CPM
    - CPM_UPDATE
- [BepInEx](https://github.com/BepInEx/BepInEx)
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

## Automatic user mods

⚠️ **This only support zip and rar files**
⚠️ **If you remove an URL, you will need to MANUALLY remove the folder at the mods folder**

You can use the following docker variable `MODS_URLS`, where you can place the URLs of the mods and the script will automatically download, uncompress, install and remove leftovers, here it's an example:
Place the URLs and separate each one with `,`.

**Example:**
`MODS_URLS="URL1,URL2"`

**Real world usage:**
`MODS_URLS="https://github.com/ErrorNull0/enZombies/archive/refs/heads/main.zip,https://github.com/ErrorNull0/enZombiesSnufkinAddon/archive/refs/heads/main.zip"`

If something fails you will see a message at the logs, open a [github ticket](https://github.com/vinanrra/Docker-7DaysToDie/issues) if a mod isn't automatically installing and I will check it.

## Manual Mods

Just drop the mods inside the Mods folder in `/path/to/ServerFiles/Mods`, restart the container and the server will automatically load them.
