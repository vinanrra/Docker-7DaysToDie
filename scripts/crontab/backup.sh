#!/bin/bash
echo "0 $BACKUP_HOUR * * *  /home/sdtdserver/scripts/server_backup.sh > /dev/null 2>&1" >> crontab.txt

echo "[INFO] Activated automatic backup at 5AM"
