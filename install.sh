#!/bin/bash
rootDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
scriptsDir="${rootDir}/scripts"

exit_handler() {
   # Execute the  shutdown commands
   echo "[INFO] Stopping 7 Days To Die Server"
   su-exec sdtdserver /home/sdtdserver/sdtdserver stop
   echo "[INFO] Stopping 7 Days To Die Server have been stopped"
   exit 0
}

# Show log function
show_log () {
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

# Trap specific signals and forward to the exit handler
trap exit_handler SIGINT SIGTERM

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
