# [vinanrra/7days-server](https://github.com/vinanrra/Docker-7DaysToDie)

# 7 days to die server using LinuxGSM script in Docker

[![Docker Pulls](https://img.shields.io/badge/dynamic/json?color=red&label=pulls&query=pull_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Stars](https://img.shields.io/badge/dynamic/json?color=red&label=stars&query=star_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Last Updated](https://img.shields.io/badge/dynamic/json?color=red&label=Last%20Update&query=last_updated&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)

![Image of 7 Days To Die](https://raw.githubusercontent.com/vinanrra/Docker-7DaysToDie/master/7dtd.png)

## Information

* This container works with mods, if you have any problems open a [github ticket](https://github.com/vinanrra/Docker-7DaysToDie/issues).
* Also this container have: Automatic backups and auto-restart if crash.
* The first time you start the container it will be auto-installed stable version.
* If you want to change any server settings, edit *sdtdserver.xml* in */path/to/ServerFiles/sdtdserver.xml*
* If you want to recieve alerts check [ALERTS](https://github.com/vinanrra/Docker-7DaysToDie#alerts).
* Read everything to avoid any errors.

## Usage

### Docker

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
  -e ALLOC_FIXES=YES \
  -e BACKUP=YES \
  -e MONITOR=NO \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TimeZone=Europe/Madrid \
  vinanrra/7dtd-server
```

### docker-compose

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
      - ALLOC_FIXES=YES #Optional - Install ALLOC FIXES
      - BACKUP=YES # Backup server every 7 days
      - MONITOR=NO # Keeps server up if crash, if first boot give error read https://github.com/vinanrra/Docker-7DaysToDie/issues/47
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

## Parameters

| Parameter | Function |
| :----: | --- |
| `/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/` | 7DaysToDie saves, where maps are store. |
| `/path/to/ServerFiles:/home/sdtdserver/serverfiles/` | 7DaysToDie server config files. |
| `/path/to/Logs:/home/sdtdserver/log/` | 7DaysToDie server log files. |
| `/path/to/BackupFolder:/home/sdtdserver/lgsm/backup/` | 7DaysToDie server backups files. |
| `/path/to/LGSM-Config:/home/sdtdserver/lgsm/config-lgsm/sdtdserver/` | LGSM config files. [More info](https://docs.linuxgsm.com/commands/monitor) |
| `26900:26900/tcp` | Default 7DaysToDie port **required** |
| `26900:26900/udp` | Default 7DaysToDie port **required** |
| `26901:26901/udp` | Default 7DaysToDie port **required** |
| `26902:26902/udp` | Default 7DaysToDie port **required** |
| `8080:8080/tcp` | Default 7DaysToDie webadmin port **optional**, if you use webadmin remember to change password in */path/to/ServerFiles/sdtdserver.xml* |
| `8081:8081/tcp` | Default 7DaysToDie telnet port **optional** |
| `8082:8082/tcp` | Default [Alloc Fixes Map GUI](https://7dtd.illy.bz/wiki/Server%20fixes) webserver port **optional** |
| `START_MODE=1` | Start mode of the container - see below for explanation **required** |
| `VERSION=stable` | Change between 7 days to die versions [more info](https://steamcommunity.com/app/251570/discussions/0/2570942124844173383/) **optional** |
| `TEST_ALERT=YES` | Test alerts at start of server **optional** |
| `ALLOC_FIXES=YES` | Install/Update [Alloc Fixes](https://7dtd.illy.bz/wiki/Server%20fixes), ONLY USE WITH LATEST STABLE BUILD **optional** |
| `BACKUP=YES` | Backup server at 5 AM (Only the latest 5 backups will be keep, maximum 30 days) [More info](https://docs.linuxgsm.com/commands/backup) **optional** |
| `MONITOR=NO` | Monitor server status, if server crash this will restart it [More info](https://docs.linuxgsm.com/commands/monitor), if map is not alread generate will give error read [#47](https://github.com/vinanrra/Docker-7DaysToDie/issues/47) **optional** |
| `PUID=1000` | for UserID - see below for explanation |
| `PGID=1000` | for GroupID - see below for explanation |
| `TimeZone=Europe/Madrid` | for TimeZone - see [TZ Database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for time zones **recomendable**|
| `--restart unless-stopped` | Restart container always unlesss stopped manually **NEVER USE WITH START_MODE=4** |

### START MODES

| START_MODE | Information |
| :----: | ---- |
| 0 | Install server |
| 1 | Start server |
| 2 | Update server |
| 3 | Update server and start, useful if you have already a 7 Days To Die server installed |
| 4 | Backup server and STOP the container|

#### WARNING

IF YOU UPDATE FROM STABLE TO EXPERIMENTAL OR VICE VERSA, REMEMBER TO BACKUP FIRST YOUR SERVER TO AVOID ANY ERRORS, and if you do not care about files atleast backup your */path/to/ServerFiles/sdtdserver.xml* yo save your server settings.

## Backups

The backup command allows the creation of .tar.gz archives of a game server, alter these three settings by editing LinuxGSM Config

* maxbackups
* maxbackupdays
* stoponbackup

Backups settings can be changed in */path/to/LGSM-Config/common.cfg*

If you wants to force a backup run this command:

```bash
  docker-compose exec 7dtdserver ./sdtdserver backup
```

## Alerts

LinuxGSM allows alerts to be received using various methods, multiple alerts can be enable at same time:

* Discord
* Email
* IFTTT
* Mailgun
* Pushbullet
* Pushover
* Telegram
* Slack

Alerts settings can be changed in */path/to/LGSM-Config/common.cfg*

You recieve alerts only if the server crashes or updates itself.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Support Info

* Shell access whilst the container is running: `docker exec -it 7dtdserver /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f 7dtdserver`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' 7dtdserver`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' vinanrra/7dtd-server`

## Updating Info

### Via Docker Run/Create

* Update the image: `docker pull vinanrra/7dtd-server`
* Stop the running container: `docker stop 7dtdserver`
* Delete the container: `docker rm 7dtdserver`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your folders and settings will be preserved)
* Start the new container: `docker start 7dtdserver`
* You can also remove the old dangling images: `docker image 7dtdserver`

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull 7dtdserver`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d 7dtdserver`
* You can also remove the old dangling images: `docker image prune`

## Thanks

* **[LinuxGSM](https://linuxgsm.com/)** - For the awesome script
* **[Linuxserver](https://www.linuxserver.io/)** - For readme structure and all the info.
* **[Linuxserver Base Image](https://github.com/linuxserver/docker-baseimage-ubuntu/blob/bionic/root/etc/cont-init.d/10-adduser)** - For the user script.
* **[Codestation Reddit User](https://www.reddit.com/r/docker/comments/evn3st/permission_problems_with_volumes/fg16w87/)** - Permission problems with volumes

## Donations

   If you want to buy me a beer here you can

   <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=25XWMUHD8NZHG&source=url" rel="PayPal">![PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)
