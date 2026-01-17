#!/bin/bash
set -e

echo "[BACKUP] Starting backup, this backup will create a backup in a .tar.gz archive of your worlds"
sleep 3s

BACKUP_FOLDER="/home/sdtdserver/.local/share/7DaysToDie/"
BACKUP_DESTINATION="/home/sdtdserver/lgsm/backup/"
scriptsDir="/home/sdtdserver/scripts"

# Function to ensure server is started on exit (success or failure)
cleanup() {
    echo "[BACKUP] Ensuring server is started..."
    ./sdtdserver start || true
    # Re-enable crontab and monitoring if it was disabled
    if [ -f "$scriptsDir/utils/crontab.sh" ]; then
        source "$scriptsDir/utils/crontab.sh" || true
    fi
}
trap cleanup EXIT

echo "[BACKUP] Stopping 7 Days To Die"
./sdtdserver stop

# Disable crontab and monitoring if enabled
crontab -r || true

# Backup the specified folder
echo "[BACKUP] Backing up folder: $BACKUP_FOLDER"
TIMESTAMP=$(date +"%Y-%m-%d-%H%M%S")
BACKUP_FILE="$BACKUP_DESTINATION/sdtdserver-$TIMESTAMP.tar.gz"
mkdir -p "$BACKUP_DESTINATION"
tar -czvf "$BACKUP_FILE" "$BACKUP_FOLDER"

echo "[BACKUP] Backup completed. Backup file: $BACKUP_FILE"

sleep 3s

echo "[BACKUP] Removing backups older than $BACKUP_MAX days"
find "$BACKUP_DESTINATION" -type f -name "*.tar.gz" -mtime +"$BACKUP_MAX" -delete || true

echo "[BACKUP] Backup process finished successfully"
