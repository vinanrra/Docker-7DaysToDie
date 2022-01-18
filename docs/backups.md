
# Backups

The backup command allows the creation of .tar.gz archives of a game server, alter these three settings by editing LinuxGSM Config

* maxbackups
* maxbackupdays
* stoponbackup

Backups settings can be changed in */path/to/LGSM-Config/common.cfg*

If you wants to force a backup run this command:

```bash
  docker-compose exec 7dtdserver ./sdtdserver backup
```
