#!/bin/bash
set -e
echo "0 $BACKUP_HOUR * * *  /home/sdtdserver/scripts/server_backup.sh >> /home/sdtdserver/log/sdtdserver-console.log 2>&1" >> crontab.txt
echo "[INFO] Activated automatic backup at $BACKUP_HOUR"
