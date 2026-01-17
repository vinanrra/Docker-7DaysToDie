#!/bin/bash
set -e
scriptsDir="/home/sdtdserver/scripts"

echo "# Crontab file" > crontab.txt
echo "BACKUP=$BACKUP" >> crontab.txt
echo "BACKUP_HOUR=$BACKUP_HOUR" >> crontab.txt
echo "BACKUP_MAX=$BACKUP_MAX" >> crontab.txt
echo "MONITOR=$MONITOR" >> crontab.txt

if [ "${BACKUP,,}" == 'yes'  ]; then
  source "$scriptsDir/crontab/backup.sh"
fi

if [ "${MONITOR,,}" == 'yes'  ]; then
  source "$scriptsDir/crontab/monitor.sh"
fi

echo "# Don't remove the empty line at the end of this file. It is required to run the cron job" >> crontab.txt

# Add crontab
crontab crontab.txt

# Cleanup junk file
rm crontab.txt
