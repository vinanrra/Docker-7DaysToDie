#!/bin/bash
echo "[INFO] Starting backup, this backup will create a backup in a .tar.gz archive of your worlds"
sleep 3s

BACKUP_FOLDER="/home/sdtdserver/.local/share/7DaysToDie/"
BACKUP_DESTINATION="/home/sdtdserver/lgsm/backup/"
scriptsDir="/home/sdtdserver/scripts"

echo "Stopping 7 Days To Die"
./sdtdserver stop

# Disable crontab and montoring if enabled
crontab -r

# Backup the specified folder
echo "Backing up folder: $BACKUP_FOLDER"
TIMESTAMP=$(date +"%Y-%m-%d-%H%M%S")
BACKUP_FILE="$BACKUP_DESTINATION/sdtdserver-$TIMESTAMP.tar.gz"
tar -czvf $BACKUP_FILE $BACKUP_FOLDER

# Enable crontab and monitoring
source "$scriptsDir/utils/crontab.sh"

echo "Starting 7 Days To Die"
./sdtdserver start

echo "Backup completed. Backup file: $BACKUP_FILE"

sleep 3s

echo "[INFO] Backup complete"

find "$BACKUP_DESTINATION" -type f -name "*.tar.gz" -mtime +7 -delete
