# Docker-7DaysToDie
7 days to die LATEST EXPERIMENTAL server using LinuixGSM script in Docker

## IMPORTANT

Rigth now this image its working well, i have been using for a week without any problem, but i want to fix volumes to just simple run the docker command and avoid to create and change permissions to folders.

## Installation WITHOUT Docker-compose
This will work both on linux and Docker for Windows. With Docker for Windows, skip the first command and make a folder the normal way. When running the container, Docker for Windows may ask for permission to access the folder. Simply allow this action.

```bash
$ mkdir -p /path/to/7DaysToDie && mkdir -p /path/to/ServerFiles && sudo chown -R 1001:1001 /path/to/7DaysToDie && sudo chown -R 1001:1001 /path/to/ServerFiles
$ docker run --name 7dtdserver --restart always --net=host --hostname LGSM -it -v "/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/" -v "/path/to/ServerFiles:/home/sdtdserver/serverfiles/" vinanrra/7dtd
```

## Installation WITH Docker-compose



```bash
$ mkdir -p /path/to/7DaysToDie && mkdir -p /path/to/ServerFiles && sudo chown -R 1001:1001 /path/to/7DaysToDie && sudo chown -R 1001:1001 /path/to/ServerFiles
```

```version: '3.3'
services:
  7dtd:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: 7dtd
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Madrid #OPTIONAL, can be change to any TimeZone
    volumes:
    - ./ServerFiles:/home/sdtdserver/serverfiles/
    - ./7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/
    ports:
    - 26900:26900/tcp
    - 26900:26900/udp
    - 26901:26901/udp
    - 26902:26902/udp
    - 8081:8081/tcp #OPTIONAL
    - 8082:8082/tcp #OPTIONAL
    #KEPP CONTAINER ALIVE - NEED TO CHANGE TO SHOW LOG AT PORTAINER
    command: tail -f /dev/null
    #KEPP CONTAINER ALIVE - NEED TO CHANGE TO SHOW LOG AT PORTAINER
    restart: unless-stopped
```

Just change volumes and ports if necessary, i am not sure if enviroments are working but the server it working so i am not going to change it.
