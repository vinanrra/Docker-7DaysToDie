
# Backups

The backup command allows the creation of .tar.gz archives of the world of the server, alter these three settings by changing the following environments

* BACKUP_HOUR -> Must be 0-23
* BACKUP_MAX

If you wants to force a backup run this command:

```bash
  docker-compose exec 7dtdserver ./scripts/server_backup.sh
```
