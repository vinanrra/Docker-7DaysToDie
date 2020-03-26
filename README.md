# [vinanrra/7days-server](https://github.com/vinanrra/Docker-7DaysToDie)

# 7 days to die server using LinuxGSM script in Docker
[![Docker Pulls](https://img.shields.io/badge/dynamic/json?color=red&label=pulls&query=pull_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Stars](https://img.shields.io/badge/dynamic/json?color=red&label=stars&query=star_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Last Updated](https://img.shields.io/badge/dynamic/json?color=red&label=Last%20Update&query=last_updated&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)

![Image of 7 Days To Die](https://raw.githubusercontent.com/vinanrra/Docker-7DaysToDie/master/7dtd.png)

## USAGE
If you use WebAdmin remember to change password at: http://YOUR.IP:8080 (8080 if you use default port) in *sdtdserver.xml*
If you want to change any server settings, edit *sdtdserver.xml* in /path/to/ServerFiles/sdtdserver.xml

### Docker
```bash
docker run \
  --name 7dtdserver \
  --restart unless-stopped \
  -v "/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/" \
  -v "/path/to/ServerFiles:/home/sdtdserver/serverfiles/" \
  -v "/path/to/LogFolder:/home/sdtdserver/log/" \
  -v "/path/to/BackupFolder:/home/sdtdserver/lgsm/backup/" \
  -p 26900:26900/tcp \
  -p 26900:26900/udp \
  -p 26901:26901/udp \
  -p 26902:26902/udp \
  -p 8080:8080/udp \
  -p 8081:8081/tcp \
  -p 8082:8082/tcp \
  -e START_MODE=1 \
  -e PUID=1000 \
  -e PUID=1000 \
  vinanrra/7dtd-server
```

### docker-compose
```
version: '2'
services:
  7dtdserver:
    image: vinanrra/7dtd-server
    container_name: 7dtdserver
    environment:
      - START_MODE=1 #Change between START MODES
      - PUID=1000 # Remember to use same as your user
      - PGID=1000 # Remember to use same as your user
    volumes:
      - ./ServerFiles:/home/sdtdserver/serverfiles/ #Optional if you dont care about serverfiles
      - ./7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/ #Optional if you dont care about maps files
      - ./log:/home/sdtdserver/log/ #Optional if you dont care about logs
      - ./backups:/home/sdtdserver/lgsm/backup/ #Optional if you dont care about backups
    ports:
      - 26900:26900/tcp
      - 26900:26900/udp
      - 26901:26901/udp
      - 26902:26902/udp
      - 8080:8080/tcp #OPTIONAL WEBADMIN
      - 8081:8081/tcp #OPTIONAL TELNET
      - 8082:8082/tcp #OPTIONAL WEBSERVER https://7dtd.illy.bz/wiki/Server%20fixes
    restart: unless-stopped #NEVER USE WITH START_MODE= 2 or 4 
```

## Parameters
| Parameter | Function |
| :----: | --- |
| `/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/` | 7DaysToDie saves, where maps are store. |
| `/path/to/ServerFiles:/home/sdtdserver/serverfiles/` | 7DaysToDie server config files. |
| `/path/to/Logs:/home/sdtdserver/log/` | 7DaysToDie server log files. |
| `/path/to/BackupFolder:/home/sdtdserver/lgsm/backup/` | 7DaysToDie server backups files. |
| `26900:26900/tcp` | Default 7DaysToDie port **required** |
| `26900:26900/udp` | Default 7DaysToDie port **required** |
| `26901:26901/udp` | Default 7DaysToDie port **required** |
| `26902:26902/udp` | Default 7DaysToDie port **required** |
| `8080:8080/tcp` | Default 7DaysToDie port, webadmin **optional** |
| `8081:8081/tcp` | Default 7DaysToDie port, telnet **optional** |
| `8082:8082/tcp` | Default 7DaysToDie port, webserver (https://7dtd.illy.bz/wiki/Server%20fixes) **optional** |
| `START_MODE=1` | Start mode of the container - see below for explanation  **required** |
| `PUID=1000` | for UserID - see below for explanation |
| `PGID=1000` | for GroupID - see below for explanation |
| `--restart unless-stopped` | Restart container always unlesss stopped manually **NEVER USE WITH START_MODE= 2 or 4** |

### START MODES:
| START_MODE | Information |
| :----: | ---- |
| 1 | Start server |
| 2 | Update server TO STABLE |
| 3 | Update server TO STABLE and start |
| 4 | Update server TO LATEST_EXPERIMENTAL |
| 5 | Update server TO LATEST_EXPERIMENTAL and start |
| 6 | Backup server and STOP the container|

ATTENTION:

IF YOU UPDATE FROM STABLE TO EXPERIMENTAL OR VICE VERSA, REMEMBER TO BACKUP FIRST YOUR SERVER TO AVOID ANY ERRORS, and if you do not care about files atleast backup your */path/to/ServerFiles/sdtdserver.xml* yo save your server settings.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

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

## Versions
* **24/03/2020**
    * Improved install script
    * Added new START_MODE (Backup)
    * Added log folder

* **18.03.2020:**
    * Improved install method
    * Change base image to SteamCMD
    * Fixed dependencies

* **08.02.2020:**
    * Improved messages they are now more precise and give better info.

* **01.02.2020:**
    * Fixed script path
    * Improved messages they are now more visual
    * Improved install script, now the server will detect if its installed or not
    * Cleanup Readme
    * Added WebAdmin port

* **31.01.2020:**
    * Cleaned and improved Dockerfile
    * Added notification for each stage
    * Fixed user creation and folder permissions

* **30.01.2020:**
    * Improved user creation with custom UID and GID
    * Updated readme (PGID and PUID, docker-compose and docker ENVs)
* **25.10.2019:**
    * Added ENV START_MODE
    * Fixed version config files path
* **24.10.2019:**
    * Initial Release.

## Thanks
* **[LinuxGSM](https://linuxgsm.com/)** - For the awesome script
* **[Linuxserver](https://www.linuxserver.io/)** - For readme structure and all the info.
* **[Linuxserver Base Image](https://github.com/linuxserver/docker-baseimage-ubuntu/blob/bionic/root/etc/cont-init.d/10-adduser)** - For the user script.
* **[Codestation Reddit User](https://www.reddit.com/r/docker/comments/evn3st/permission_problems_with_volumes/fg16w87/)** - Permission problems with volumes

## Donations
   If you want to pay me a beer here you can

   <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=25XWMUHD8NZHG&source=url" rel="PayPal">![PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)
