# [vinanrra/7days-server](https://github.com/vinanrra/Docker-7DaysToDie)

# 7 days to die server using LinuxGSM in Docker with backups, monitor, auto-installable mods and more

[![Docker Pulls](https://img.shields.io/badge/dynamic/json?color=red&label=pulls&query=pull_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Stars](https://img.shields.io/badge/dynamic/json?color=red&label=stars&query=star_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)
[![Docker Last Updated](https://img.shields.io/badge/dynamic/json?color=red&label=Last%20Update&query=last_updated&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2F7dtd-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/7dtd-server)

![7DaysToDie](https://raw.githubusercontent.com/vinanrra/Docker-7DaysToDie/master/7dtd.png)

## Features

* **Multi-version** you can choose which version you want to play, [more info](docs/parameters.md#7-days-to-die).
* **Auto-installable mods**, [more info](docs/mods_support.md#mods) also check [Mods parameters](docs/parameters.md#mods).
* **Automatic Backups**, [more info](docs/backups.md) also check [LinuxGSM parameters](docs/parameters.md#linuxgsm)
* **Monitor** if server crash will be restarted, [more info](docs/parameters.md#linuxgsm).
* **Alerts** if server requiere your attention, [more info](docs/alerts.md#alerts) also check [LinuxGSM parameters](docs/parameters.md#linuxgsm).
* **User/Group Identifiers**, [more info](docs/user_groups_identifiers.md).

## Information

* If you want to change any server settings, edit `/path/to/ServerFiles/sdtdserver.xml`
* Read EVERYTHING to avoid any errors, if you have any problems open a [github ticket](https://github.com/vinanrra/Docker-7DaysToDie/issues).

## [Usage](docs/usage.md)

## [Parameters](docs/parameters.md)

## [Updating Info](docs/updating_info.md)

## [Support Info](docs/support.md)

## Donations

   If you want to buy me a beer here you can

   <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=25XWMUHD8NZHG&source=url" rel="PayPal">![PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)

## Thanks

* **[LinuxGSM](https://linuxgsm.com/)** - For the awesome script
* **[Linuxserver](https://www.linuxserver.io/)** - For readme structure and all the info.
* **[Linuxserver Base Image](https://github.com/linuxserver/docker-baseimage-ubuntu/blob/bionic/root/etc/cont-init.d/10-adduser)** - For the user script.
* **[Codestation Reddit User](https://www.reddit.com/r/docker/comments/evn3st/permission_problems_with_volumes/fg16w87/)** - Permission problems with volumes
* **All contributors**
