# Usage

Examples with all parameters supported

## Docker

```bash
docker run -d \
  --name 7dtdserver \
  --restart unless-stopped \
  -v "/path/to/folder/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/" \
  -v "/path/to/folder/ServerFiles:/home/sdtdserver/serverfiles/" \
  -v "/path/to/folder/LogFolder:/home/sdtdserver/log/" \
  -v "/path/to/folder/BackupFolder:/home/sdtdserver/lgsm/backup/" \
  -v "/path/to/folder/LGSM-Config:/home/sdtdserver/lgsm/config-lgsm/sdtdserver/" \
  -p 26900:26900/tcp \
  -p 26900:26900/udp \
  -p 26901:26901/udp \
  -p 26902:26902/udp \
  -p 8080:8080/tcp \
  -p 8081:8081/tcp \
  -p 8082:8082/tcp \
  -e START_MODE=1 \
  -e VERSION=stable \
  -e TEST_ALERT=NO \
  -e UPDATE_MODS=NO \
  -e ALLOC_FIXES=NO \
  -e ALLOC_FIXES_UPDATE=NO \
  -e UNDEAD_LEGACY=NO \
  -e UNDEAD_LEGACY_VERSION=stable \
  -e DARKNESS_FALLS=NO \
  -e DARKNESS_FALLS_UPDATE=NO \
  -e DARKNESS_FALLS_URL=False \
  -e UNDEAD_LEGACY_UPDATE=NO \
  -e ENZOMBIES=NO \
  -e ENZOMBIES_ADDON_SNUFKIN=NO \
  -e ENZOMBIES_ADDON_ROBELOTO=NO \
  -e ENZOMBIES_ADDON_NONUDES=NO \
  -e ENZOMBIES_UPDATE=NO \
  -e CPM=NO \
  -e CPM_UPDATE=NO \
  -e BEPINEX=NO \
  -e BEPINEX_UPDATE=NO \
  -e BACKUP=NO \
  -e MONITOR=NO \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TimeZone=Europe/Madrid \
  vinanrra/7dtd-server
```

## docker-compose

```yaml
version: '2'
services:
  7dtdserver:
    image: vinanrra/7dtd-server
    container_name: 7dtdserver
    environment:
      - START_MODE=1 #Change between START MODES
      - VERSION=stable # Change between 7 days to die versions
      - PUID=1000 # Remember to use same as your user
      - PGID=1000 # Remember to use same as your user
      - TimeZone=Europe/Madrid # Optional - Change Timezone
      - TEST_ALERT=NO # Optional - Send a test alert
      - UPDATE_MODS=NO # Optional - This will allow mods to be update on start, each mod also need to have XXXX_UPDATE=YES to update on start
      - ALLOC_FIXES=NO # Optional - Install ALLOC FIXES
      - ALLOC_FIXES_UPDATE # Optional - Update Allocs Fixes before server start
      - UNDEAD_LEGACY=NO # Optional - Install Undead Legacy mod, if DARKNESS_FALLS it's enable will not install anything
      - UNDEAD_LEGACY_VERSION=stable # Optional - Undead Legacy version
      - UNDEAD_LEGACY_UPDATE=NO # Optional - Update Undead Legacy mod before server start
      - DARKNESS_FALLS=NO # Optional - Install Darkness Falls mod, if UNDEAD_LEGACY it's enable will not install anything
      - DARKNESS_FALLS_UPDATE=NO  # Optional - Update Darkness Falls mod before server start
      - DARKNESS_FALLS_URL=False # Optional - Install the provided Darkness Falls url
      - ENZOMBIES=NO # Optional - Install EnZombies mod
      - ENZOMBIES_ADDON_SNUFKIN=NO # Optional - Install EnZombies addon mod
      - ENZOMBIES_ADDON_ROBELOTO=NO # Optional - Install EnZombies addon mod
      - ENZOMBIES_ADDON_NONUDES=NO # Optional - Install EnZombies addon mod
      - ENZOMBIES_UPDATE=NO # Optional - Update EnZombies mod and addons before server start
      - CPM=NO # Optional - CSMM Patron's Mod (CPM)
      - CPM_UPDATE=NO # Optional - Update CPM before server start
      - BEPINEX=NO # Optional - BepInEx
      - BEPINEX_UPDATE=NO # Optional - Update BepInEx before server start
      - BACKUP=NO # Optional - Backup server at 5 AM
      - MONITOR=NO # Optional - Keeps server up if crash
    volumes:
      - /path/to/folder/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/
      - /path/to/folder/LGSM-Config:/home/sdtdserver/lgsm/config-lgsm/sdtdserver
      - /path/to/folder/ServerFiles:/home/sdtdserver/serverfiles/ # Optional - serverfiles folder
      - /path/to/folder/log:/home/sdtdserver/log/ # Optional - Logs folder
      - /path/to/folder/backups:/home/sdtdserver/lgsm/backup/ # Optional - If BAKCUP=NO, backups folder
    ports:
      - 26900:26900/tcp # Default game ports
      - 26900:26900/udp # Default game ports
      - 26901:26901/udp # Default game ports
      - 26902:26902/udp # Default game ports
      - 8080:8080/tcp # OPTIONAL - WEBADMIN
      - 8081:8081/tcp # OPTIONAL - TELNET
      - 8082:8082/tcp # OPTIONAL - WEBSERVER https://7dtd.illy.bz/wiki/Server%20fixes
    restart: unless-stopped # INFO - NEVER USE WITH START_MODE=4 or START_MODE=0
```
