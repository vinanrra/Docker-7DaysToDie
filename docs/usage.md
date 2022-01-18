# Usage

## Docker

```bash
docker run -d \
  --name 7dtdserver \
  --restart unless-stopped \
  -v "./7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/" \
  -v "./ServerFiles:/home/sdtdserver/serverfiles/" \
  -v "./LogFolder:/home/sdtdserver/log/" \
  -v "./BackupFolder:/home/sdtdserver/lgsm/backup/" \
  -v "./LGSM-Config:/home/sdtdserver/lgsm/config-lgsm/sdtdserver/" \
  -p 26900:26900/tcp \
  -p 26900:26900/udp \
  -p 26901:26901/udp \
  -p 26902:26902/udp \
  -p 8080:8080/udp \
  -p 8081:8081/tcp \
  -p 8082:8082/tcp \
  -e START_MODE=1 \
  -e VERSION=stable \
  -e TEST_ALERT=NO \
  -e ALLOC_FIXES=NO \
  -e UNDEAD_LEGACY=NO \
  -e UNDEAD_LEGACY_VERSION=stable \
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
      - TimeZone=Europe/Madrid
      - TEST_ALERT=NO
      - ALLOC_FIXES=NO #Optional - Install ALLOC FIXES
      - UNDEAD_LEGACY=NO #Optional - Install Undead Legacy mod
      - UNDEAD_LEGACY_VERSION=stable #Optional - Undead Legacy version
      - BACKUP=NO # Backup server at 5 AM
      - MONITOR=NO # Keeps server up if crash
    volumes:
      - ./ServerFiles:/home/sdtdserver/serverfiles/ #Optional, serverfiles
      - ./7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/ #Optional, maps files
      - ./log:/home/sdtdserver/log/ #Optional, logs
      - ./backups:/home/sdtdserver/lgsm/backup/ #Optional, backups
      - ./LGSM-Config:/home/sdtdserver/lgsm/config-lgsm/sdtdserver # Optional, LGSM-Config
    ports:
      - 26900:26900/tcp
      - 26900:26900/udp
      - 26901:26901/udp
      - 26902:26902/udp
      - 8080:8080/tcp #OPTIONAL WEBADMIN
      - 8081:8081/tcp #OPTIONAL TELNET
      - 8082:8082/tcp #OPTIONAL WEBSERVER https://7dtd.illy.bz/wiki/Server%20fixes
    restart: unless-stopped #NEVER USE WITH START_MODE=4 or START_MODE=0
```
