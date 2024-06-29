scriptsDir="/home/sdtdserver/scripts"

echo "# Crontab file" > crontab.txt

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
