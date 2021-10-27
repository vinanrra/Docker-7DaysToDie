#!/bin/sh
function exit_handler {
        echo "
                =======================================================================
               
                Shutdown signal received..
                
                =======================================================================
        "

        # Execute the  shutdown commands
        su-exec sdtdserver /home/sdtdserver/sdtdserver stop

        echo "
                =======================================================================
                
                7 DAYS TO DIE SERVER HAVE BEEN STOPPED
                
                =======================================================================
        "
        exit
}

# Trap specific signals and forward to the exit handler
trap exit_handler SIGTERM

set -eu

# Print info
echo "
=======================================================================
USER INFO:

UID: $PUID
GID: $PGID

MORE INFO:

If you have permission problems remember to use same user UID and GID.
Check it with "id" command
If problem persist check:
https://github.com/vinanrra/Docker-7DaysToDie/blob/master/README.md
=======================================================================
"

# Set user and group ID to sdtdserver user
groupmod -o -g "$PGID" sdtdserver  > /dev/null 2>&1
usermod -o -u "$PUID" sdtdserver  > /dev/null 2>&1

# Apply owner to the folder to avoid errors
chown -R sdtdserver:sdtdserver /home/sdtdserver

# Change user to sdtdserver
su-exec su sdtdserver

rootDir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
scriptsDir="${rootDir}/scripts"
    
# Check requeriments

# Check if script is missing

if [ ! -f sdtdserver ]; then
   
   source $scriptsDir/check_script.sh

fi

# Check if server have been installed

if [ ! -f serverfiles/DONT_REMOVE.txt ]; then
   
   source $scriptsDir/first_install.sh
fi

# Use of case to avoid errors if used wrong START_MODE

if [ "${BACKUP,,}" == 'yes'  ]; then
      source $scriptsDir/crontab/sdtdserver-backup.sh
fi

if [ "${MONITOR,,}" == 'yes'  ]; then
      source $scriptsDir/crontab/sdtdserver-monitor.sh
fi

case $START_MODE in
   0)
      exit
   ;;
   1)
      source $scriptsDir/server_start.sh
if [ "${TEST_ALERT,,}" == 'yes'  ]; then
   source $scriptsDir/server_alerts.sh
fi
tail -f /dev/null
   ;;
   2)
      source $scriptsDir/server_update.sh
exit
   ;;
   3)
      source $scriptsDir/server_update.sh

      source $scriptsDir/server_start.sh
if [ "${TEST_ALERT,,}" == 'yes'  ]; then
   source $scriptsDir/server_alerts.sh
fi
tail -f /dev/null
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
