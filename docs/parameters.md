# Parameters

## Volumes

| Parameter | Function |
| --- | --- |
| `/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/` | 7DaysToDie saves, where maps are store. |
| `/path/to/ServerFiles:/home/sdtdserver/serverfiles/` | 7DaysToDie server config files. |
| `/path/to/Logs:/home/sdtdserver/log/` | 7DaysToDie server log files. |
| `/path/to/BackupFolder:/home/sdtdserver/lgsm/backup/` | 7DaysToDie server backups files. |
| `/path/to/LGSM-Config:/home/sdtdserver/lgsm/config-lgsm/sdtdserver/` | LGSM config files. [More info](https://docs.linuxgsm.com/commands/monitor) |

## Ports

| Parameter | Function |
| --- | --- |
| `26900:26900/tcp` | Default 7DaysToDie port **required** |
| `26900:26900/udp` | Default 7DaysToDie port **required** |
| `26901:26901/udp` | Default 7DaysToDie port **required** |
| `26902:26902/udp` | Default 7DaysToDie port **required** |
| `8080:8080/tcp` | Default 7DaysToDie webadmin port **optional**, if you use webadmin remember to change password in `/path/to/ServerFiles/sdtdserver.xml` |
| `8081:8081/tcp` | Default 7DaysToDie telnet port **optional** |
| `8082:8082/tcp` | Default [Alloc Fixes Map GUI](https://7dtd.illy.bz/wiki/Server%20fixes) webserver port **optional** |

## General

| Parameter | Function | Values |
| --- | --- | :---: |
| `START_MODE=1` | Start mode of the container **required** | [Start Modes](parameters.md#start-modes) |
| `TimeZone=Europe/Madrid` | for TimeZone **recomendable**| [TZ Database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) |
| `PUID=1000` | for UserID | [More info](user_groups_identifiers.md) |
| `PGID=1000` | for GroupID | [More info](user_groups_identifiers.md) |
| `--restart unless-stopped` | Restart container always unlesss stopped manually **NEVER USE WITH START_MODE=0, 2 or 4** | [Restart Policy](https://docs.docker.com/config/containers/start-containers-automatically/#use-a-restart-policy) |

## 7 Days to Die

| Parameter | Function | Values |
| --- | --- | :---: |
| `VERSION=stable` | Change between 7 days to die versions/branches **optional** | [Branches](https://steamdb.info/app/251570/depots/) |

## LinuxGSM

| Parameter | Function | Values |
| --- | --- | :---: |
| `BACKUP=NO` | Backup server at 5 AM (Only the latest 5 backups will be keep, maximum 30 days) [More info](https://docs.linuxgsm.com/commands/backup) **optional** | YES, NO |
| `MONITOR=NO` | Monitor server status, if server crash this will restart it [More info](https://docs.linuxgsm.com/commands/monitor) **optional** | YES, NO |
| `TEST_ALERT=NO` | Test alerts at start of server **optional** | YES, NO |

## Mods

### Alloc Fixes

| Parameter | Function | Values |
| :---: | --- | :---: |
| `ALLOC_FIXES=NO` | Install [Allocs Fixes](https://7dtd.illy.bz/wiki/Server%20fixes), Alloc Fixes version will be installed according to 7 days to die branch version  **optional** | YES, NO |
| `ALLOC_FIXES_UPDATE=NO` | Update [Allocs Fixes](https://7dtd.illy.bz/wiki/Server%20fixes), depending of your 7 days to die version, on server install, requiere UPDATE_MODS=YES **optional** | YES, NO |YES, NO |

### Undead Legacy

| Parameter | Function | Values |
| --- | --- | :---: |
| `UNDEAD_LEGACY=NO` | Install [Undead Legacy](https://ul.subquake.com/) **optional** | YES, NO |
| `UNDEAD_LEGACY_VERSION=stable` | Install [Undead Legacy Versions](https://ul.subquake.com), [CHECK BUILDS COMPATIBILITY](https://ul.subquake.com/download) **optional** | EXP, STABLE |
| `UNDEAD_LEGACY_UPDATE=NO` | Update [Undead Legacy](https://ul.subquake.com/patch-notes), on server install, requiere UPDATE_MODS=YES **optional** | YES, NO |

### enZombies

| Parameter | Function | Values |
| --- | --- | :---: |
| `ENZOMBIES=NO` | Install [enZombies](https://community.7daystodie.com/topic/24594-enzombies-more-zombie-variations/) **optional** | YES, NO |
| `ENZOMBIES_ADDON_SNUFKIN=NO` | Install [enZombies - Snufkin Zombies Add-on](https://community.7daystodie.com/topic/24594-enzombies-more-zombie-variations/) **optional** | YES, NO |
| `ENZOMBIES_ADDON_ROBELOTO=NO` | Install [enZombies - Robeloto Zombies Add-on](https://community.7daystodie.com/topic/24594-enzombies-more-zombie-variations/) **optional** | YES, NO |
| `ENZOMBIES_ADDON_NONUDES=NO` | Install [enZombies - No Nudes Add-on](https://community.7daystodie.com/topic/24594-enzombies-more-zombie-variations/) **optional** | YES, NO |
| `ENZOMBIES_UPDATE=NO` | Update [enZombies](https://community.7daystodie.com/topic/24594-enzombies-more-zombie-variations/), enZombies + Addons on server install, requiere UPDATE_MODS=YES **optional** | YES, NO |

### CSMM Patron's Mod (CPM)

| Parameter | Function | Values |
| --- | --- | :---: |
| `CPM=NO` | Install [CPM](https://docs.csmm.app/en/cpm/), CPM version will be installed according to 7 days to die branch version, this will also install Allocs Fixes **optional** | YES, NO |
| `CPM_UPDATE=NO` | Update [CPM](https://docs.csmm.app/en/cpm/), CPM on every server start, depending of your 7 days to die version, requiere UPDATE_MODS=YES **optional** | YES, NO |

### START MODES

| START_MODE | Information |
| :----: | ---- |
| 0 | Install server and STOP the container |
| 1 | Start server |
| 2 | Update server and STOP the container |
| 3 | Update and start start |
| 4 | Backup server and STOP the container |

#### WARNING

IF YOU UPDATE FROM STABLE TO EXPERIMENTAL OR VICE VERSA, REMEMBER TO BACKUP FIRST YOUR SERVER TO AVOID ANY ERRORS.
