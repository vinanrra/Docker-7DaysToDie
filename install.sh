#!/bin/bash
rootDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
scriptsDir="${rootDir}/scripts"

# Show log function
show_log () {
   i="0"
      # -F = --follow=name --retry
      tail -F /home/sdtdserver/log/console/sdtdserver-console.log
}

test_alert () {
   if [ "${TEST_ALERT,,}" == 'yes'  ]; then
      source $scriptsDir/server_alerts.sh
   fi
}

# Check requeriments

# Check if script is missing
if [ ! -f sdtdserver ]; then
   source $scriptsDir/check_script.sh
fi

# Check if server have been installed
if [ ! -f serverfiles/DONT_REMOVE.txt ]; then
   source $scriptsDir/first_install.sh
fi

# Crontab
echo "# Crontab file" > crontab.txt

if [ "${BACKUP,,}" == 'yes'  ]; then
   source $scriptsDir/crontab/backup.sh
fi

if [ "${MONITOR,,}" == 'yes'  ]; then
   source $scriptsDir/crontab/monitor.sh
fi

echo "# Don't remove the empty line at the end of this file. It is required to run the cron job" >> crontab.txt

crontab crontab.txt

rm crontab.txt

# Use of case to avoid errors if used wrong START_MODE
case $START_MODE in
   0)
      exit
   ;;
   1)
      source $scriptsDir/server_start.sh
      test_alert
      show_log
   ;;
   2)
      source $scriptsDir/server_update.sh
      exit
   ;;
   3)
      source $scriptsDir/server_update.sh
      source $scriptsDir/server_start.sh
      test_alert
      show_log
   ;; 
   4)
      source $scriptsDir/server_backup.sh
      exit
   ;;
   *)
      source $scriptsDir/check_startMode.sh
      exit
   ;;
esac
