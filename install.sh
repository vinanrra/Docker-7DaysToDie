#!/bin/bash

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

  case $START_MODE in
     0)
        exit
     ;;
     1)
        source $scriptsDir/server_start.sh
	if [ "$TEST_ALERT" == 'YES'  ] then
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
	if [ "$TEST_ALERT" == 'YES'  ] then
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
