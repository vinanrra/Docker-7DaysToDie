# Usage

Example with all parameters supported

## docker-compose

```yaml
version: '2'
services:
  7dtdserver:
    image: vinanrra/7dtd-server
    container_name: 7dtdserver
    environment:
      - LINUXGSM_VERSION=v24.3.4      # Change to use another version of LinuxGSM
      - START_MODE=1                 # Change between START MODES
      - VERSION=stable               # Change between 7 days to die versions
      - PUID=1000                    # Remember to use same as your user
      - PGID=1000                    # Remember to use same as your user
      - TimeZone=Europe/Madrid       # Optional - Change Timezone
      - TEST_ALERT=NO                # Optional - Send a test alert
      - UPDATE_MODS=NO               # Optional - This will allow mods to be update on start, each mod also need to have XXXX_UPDATE=YES to update on start
      - MODS_URLS=""                 # Optional - Mods urls to install, must be ZIP or RAR.
      - ALLOC_FIXES=NO               # Optional - Install ALLOC FIXES
      - ALLOC_FIXES_UPDATE=NO        # Optional - Update Allocs Fixes before server start
      - UNDEAD_LEGACY=NO             # Optional - Install Undead Legacy mod, if DARKNESS_FALLS it's enable will not install anything
      - UNDEAD_LEGACY_VERSION=stable # Optional - Undead Legacy version
      - UNDEAD_LEGACY_UPDATE=NO      # Optional - Update Undead Legacy mod before server start
      - DARKNESS_FALLS=NO            # Optional - Install Darkness Falls mod, if UNDEAD_LEGACY it's enable will not install anything
      - DARKNESS_FALLS_UPDATE=NO     # Optional - Update Darkness Falls mod before server start
      - DARKNESS_FALLS_URL=False     # Optional - Install the provided Darkness Falls url
      - CPM=NO                       # Optional - CSMM Patron's Mod (CPM)
      - CPM_UPDATE=NO                # Optional - Update CPM before server start
      - BEPINEX=NO                   # Optional - BepInEx
      - BEPINEX_UPDATE=NO            # Optional - Update BepInEx before server start
      - BACKUP=NO                    # Optional - Backup server
      - BACKUP_HOUR=5                # Optional - Backup hour 0-23
      - BACKUP_MAX=7                 # Optional - Max backups to keep
      - MONITOR=NO                   # Optional - Keeps server up if crash
    volumes:
      - /path/to/folder/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/     # 7 Days To Die world saves
      - /path/to/folder/LGSM-Config:/home/sdtdserver/lgsm/config-lgsm/sdtdserver # LGSM config folder
      - /path/to/folder/ServerFiles:/home/sdtdserver/serverfiles/                # Optional - serverfiles folder
      - /path/to/folder/log:/home/sdtdserver/log/                                # Optional - Logs folder
      - /path/to/folder/backups:/home/sdtdserver/lgsm/backup/                    # Optional - If BACKUP=YES, backups folder
    ports:
      - 26900:26900/tcp # Default game ports
      - 26900:26900/udp # Default game ports
      - 26901:26901/udp # Default game ports
      - 26902:26902/udp # Default game ports
      - 8080:8080/tcp   # OPTIONAL - WEBADMIN
      - 8081:8081/tcp   # OPTIONAL - TELNET
      - 8082:8082/tcp   # OPTIONAL - WEBSERVER https://7dtd.illy.bz/wiki/Server%20fixes
    ulimits:
      nofile:
        soft: "10240"
        hard: "10240"

    restart: unless-stopped # INFO - NEVER USE WITH START_MODE=4 or START_MODE=0
```
