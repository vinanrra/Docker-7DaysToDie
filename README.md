# [vinanrra/7days-server](https://github.com/vinanrra/Docker-7DaysToDie)

# 7 days to die server using LinuixGSM script in Docker

![Image of 7 Days To Die](https://raw.githubusercontent.com/vinanrra/Docker-7DaysToDie/master/7dtd.png)

## Supported Architectures

The architectures supported by this image are:

| Architecture |
| :----: |
| x86-64 |
| x86 |

## USAGE

### Docker

### FIRST Start, to install server
```bash
mkdir -p /path/to/7DaysToDie && mkdir -p /path/to/ServerFiles
```

```bash
docker run \
  --name 7dtdserver \
  -v "/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/" \
  -v "/path/to/ServerFiles:/home/sdtdserver/serverfiles/" \
  -p 26900:26900/tcp \
  -p 26900:26900/udp \
  -p 26901:26901/udp \
  -p 26902:26902/udp \
  -p 8081:8081/tcp \
  -p 8082:8082/tcp \
  -e START_MODE=0 \
  -e PUID=1000 \
  -e PUID=1000 \
  vinanrra/7dtd-server
```

### SECOND start to start/update server

```bash
docker run \
  --name 7dtdserver \
  --restart unless-stopped \
  -v "/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/" \
  -v "/path/to/ServerFiles:/home/sdtdserver/serverfiles/" \
  -p 26900:26900/tcp \
  -p 26900:26900/udp \
  -p 26901:26901/udp \
  -p 26902:26902/udp \
  -p 8081:8081/tcp \
  -p 8082:8082/tcp \
  -e START_MODE=CHANGE_ME \
  -e PUID=1000 \
  -e PUID=1000 \
  vinanrra/7dtd-server
```

Ports 8081 and 8082 are OPTIONAL

### docker-compose

```bash
mkdir -p /path/to/7DaysToDie && mkdir -p /path/to/ServerFiles
```
Remember to start first with START_MODE=0 to install the server, them you can change the mode when you want.

```
version: '2'
services:
  7dtdserver:
    image: vinanrra/7dtd-server
    container_name: 7dtdserver
    environment:
      - START_MODE=0 #Change between START MODES
	  -e PUID=1000 # Remember to use same as your user
      -e PUID=1000 # Remember to use same as your user
    volumes:
      - ./ServerFiles:/home/sdtdserver/serverfiles/ #Optional if you dont care about serverfiles
      - ./7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/ #Optional if you dont care about maps files
    ports:
      - 26900:26900/tcp
      - 26900:26900/udp
      - 26901:26901/udp
      - 26902:26902/udp
      - 8081:8081/tcp #OPTIONAL WEBUI
      - 8082:8082/tcp #OPTIONAL WEBSERVER https://7dtd.illy.bz/wiki/Server%20fixes
    restart: unless-stopped #NEVER USE WITH START_MODE=0, 2 or 4 
```

## Parameters

| Parameter | Function |
| :----: | --- |
| `-v /home/sdtdserver/.local/share/7DaysToDie/` | 7DaysToDie saves, where maps store. |
| `-v /path/to/ServerFiles:/home/sdtdserver/serverfiles/` | 7DaysToDie server config files. |
| `-p 26900:26900/tcp` | Default 7DaysToDie port **required** |
| `-p 26900:26900/udp` | Default 7DaysToDie port **required** |
| `-p 26901:26901/udp` | Default 7DaysToDie port **required** |
| `-p 26902:26902/udp` | Default 7DaysToDie port **required** |
| `-p 8081:8081/tcp` | Default 7DaysToDie port, webui **optional** |
| `-p 8082:8082/tcp` | Default 7DaysToDie port, webui (https://7dtd.illy.bz/wiki/Server%20fixes) **optional** |
| `-e START_MODE=0` | Start mode of the container - see below for explanation  **required** |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `--restart unless-stopped` | Restart container always unlesss stopped manually **NEVER USE WITH START_MODE=0, 2 or 4** |

### START MODES:

| START_MODE | Information |
| :----: | :----: |
| 0 | Install server |
| 1 | Start server |
| 2 | Update server TO STABLE |
| 3 | Update server TO STABLE and start |
| 4 | Update server TO LATEST_EXPERIMENTAL |
| 5 | Update server TO LATEST_EXPERIMENTAL and start |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Support Info

* Shell access whilst the container is running: `docker exec -it 7dtdserver /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f 7dtdserver`

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

* **25.10.2019:** - Added ENV START_MODE and fixed version config files path
* **24.10.2019:** - Initial Release.

## Thanks

* **https://www.linuxserver.io/** - For readme structure and all the info.
