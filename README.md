# [vinanrra/7days-server](https://github.com/vinanrra/Docker-7DaysToDie)

# 7 days to die server using LinuxGSM script in Docker with backups, monitor, auto-installable mods and more

[![Docker Pulls](https://img.shields.io/badge/dynamic/json?color=red&label=pulls&query=pull_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Stars](https://img.shields.io/badge/dynamic/json?color=red&label=stars&query=star_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Last Updated](https://img.shields.io/badge/dynamic/json?color=red&label=Last%20Update&query=last_updated&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)

![Image of 7 Days To Die](https://raw.githubusercontent.com/vinanrra/Docker-7DaysToDie/master/7dtd.png)

## Information

* If you want to change any server settings, edit `/path/to/ServerFiles/sdtdserver.xml`
* Read EVERYTHING to avoid any errors, if you have any problems open a [github ticket](https://github.com/vinanrra/Docker-7DaysToDie/issues).

## Features

* **Auto-installable mods**, [more info](docs/mods_support.md).
* **Automatic Backups**, [more info](docs/backups.md) also check [parameters info](docs/parameters.md).
* **Monitor** if server crash and restart it, [more info](docs/parameters.md).
* **Alerts** if server requiere your attention, [more info](docs/alerts.md#alerts).
* **User/Group Identifiers**, [more info](docs/user_groups_identifiers.md)

## [Usage](docs/usage.md)

## [Parameters](docs/parameters.md)

## [Updating Info](docs/updating_info.md)

## Support Info

* Shell access whilst the container is running: `docker exec -it 7dtdserver /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f 7dtdserver`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' 7dtdserver`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' vinanrra/7dtd-server`


## Thanks

* **[LinuxGSM](https://linuxgsm.com/)** - For the awesome script
* **[Linuxserver](https://www.linuxserver.io/)** - For readme structure and all the info.
* **[Linuxserver Base Image](https://github.com/linuxserver/docker-baseimage-ubuntu/blob/bionic/root/etc/cont-init.d/10-adduser)** - For the user script.
* **[Codestation Reddit User](https://www.reddit.com/r/docker/comments/evn3st/permission_problems_with_volumes/fg16w87/)** - Permission problems with volumes

## Donations

   If you want to buy me a beer here you can

   <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=25XWMUHD8NZHG&source=url" rel="PayPal">![PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)
