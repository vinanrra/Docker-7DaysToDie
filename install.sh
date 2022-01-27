#!/bin/bash
rootDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
scriptsDir="${rootDir}/scripts"

# Show log function
show_log () {
   # -F = --follow=name --retry
   tail -F /home/sdtdserver/log/console/sdtdserver-console.log
}

test_alert () {
   if [ "${TEST_ALERT,,}" == 'yes'  ]; then
      source "$scriptsDir/server_alerts.sh"
   fi
}

crontab_func (){
   # Crontab
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
}

# Check requeriments

# Check if script is missing
if [ ! -f sdtdserver ]; then
   source "$scriptsDir/check_script.sh"
fi

# Check if server have been installed, if missing file
if [ ! -f serverfiles/DONT_REMOVE.txt ]; then
   source "$scriptsDir/first_install.sh"
fi

# This will install or update mods at start but not on first install
if [ "${UPDATE_MODS,,}" == 'yes'  ] && [ ! -f serverfiles/MOD_BLOCK.txt ]; then
   source "$scriptsDir/Mods/mods_update.sh"
fi

# Remove update mod block on first install
if [ -f serverfiles/MOD_BLOCK.txt ] ; then
   rm serverfiles/MOD_BLOCK.txt
fi

crontab_func

# Use of case to avoid errors if used wrong START_MODE
case $START_MODE in
   0)
      exit
   ;;
   1)
      source "$scriptsDir/server_start.sh"
      test_alert
      show_log
   ;;
   2)
      source "$scriptsDir/server_update.sh"
      exit
   ;;
   3)
      source "$scriptsDir/server_update.sh"
      source "$scriptsDir/server_start.sh"
      test_alert
      show_log
   ;; 
   4)
      source "$scriptsDir/server_backup.sh"
      exit
   ;;
   *)
      source "$scriptsDir/check_startMode.sh"
      exit
   ;;
esac
