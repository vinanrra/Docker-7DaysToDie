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
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DESTINATION/sdtdserver-$TIMESTAMP.tar.gz"
tar -czvf $BACKUP_FILE $BACKUP_FOLDER

# Enable crontab and monitoring
source "$scriptsDir/utils/crontab.sh"

echo "Starting 7 Days To Die"
./sdtdserver start

echo "Backup completed. Backup file: $BACKUP_FILE"

sleep 3s

echo "[INFO] Backup complete"

# Find all .tar.gz files in the backup directory
backups=( "$BACKUP_DESTINATION"/*.tar.gz )

if [[ ${#backups[@]} -eq 0 ]]; then
  echo "No backup files found in $BACKUP_DESTINATION"
  exit 0
fi

# Sort backups by modification time (newest first)
shopt -s nullglob  # Allow sorting empty arrays
backups=($(sort -r --key='{}' <<< "${backups[@]}"))  # Double quotes for filenames with spaces

# Keep only the most recent 7 backups
backups_to_keep=("${backups[@]:0:$BACKUP_MAX}")

# Delete remaining backups
for backup in "${backups[@]:$BACKUP_MAX}"; do
  rm -f "$backup"
  echo "Deleted backup: $backup"
done

echo "Kept ${#backups_to_keep[@]} backups and deleted ${#backups[@]} - ${#backups_to_keep[@]} older ones."
