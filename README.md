# Docker-7DaysToDie
7 days to die LATEST EXPERIMENTAL server using LinuixGSM script in Docker

######################MPORTANT######################

Rigth now this image its working well, i have been using for a week without any problem, but i want to fix volumes to just simple run the docker command and avoid to create and change permissions to folders.

######################MPORTANT######################

## Installation
This will work both on linux and Docker for Windows. With Docker for Windows, skip the first command and make a folder the normal way. When running the container, Docker for Windows may ask for permission to access the folder. Simply allow this action.

```bash
$ mkdir -p /path/to/7DaysToDie && mkdir -p /path/to/ServerFiles && sudo chown -R 1001:1001 /path/to/7DaysToDie && sudo chown -R 1001:1001 /path/to/ServerFiles
$ docker run --name 7dtdserver --restart always --net=host --hostname LGSM -it -v "/path/to/7DaysToDie:/home/sdtdserver/.local/share/7DaysToDie/" -v "/path/to/ServerFiles:/home/sdtdserver/serverfiles/" vinanrra/7dtd
```
