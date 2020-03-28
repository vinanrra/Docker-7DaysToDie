#!/bin/bash

    # Functions
    
    startServer () {
    
        ./sdtdserver start

            echo "
            =======================================================================
            IMPORTANT:
            
            Starting server...
            Soon you will see all the info
            =======================================================================
            "

        sleep 2m
        
        ./sdtdserver details
        
        tail -f /dev/null
    
    }
    
    update () {
    
        ./sdtdserver update

        if [ $VERSION == 'stable'  ]
        then
            sed -i '/branch/d' /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
        else
            echo branch="-beta $version" >> /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
            echo VERSION: $version
        fi

        ./sdtdserver update

            echo "
            =======================================================================
            IMPORTANT:

            The server have been updated to $VERSION, now switch between "START_MODE"
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "

    }
    
    backupServer () {
    
            sleep 5s
    
            echo "
            =======================================================================
            IMPORTANT:
    
            This backup will create a complete tar bzip2 archive of the whole server.
            
            =======================================================================
            "
            ./sdtdserver backup
	    
	    sleep 5s
	    
	    echo "
            =======================================================================
            IMPORTANT:
    
            Backup complete.
            
            =======================================================================
            "
	    
    }
    
    startModeError () {
    
            echo "
            =======================================================================
            IMPORTANT:
    
            START_MODE $START_MODE UNKNOWN
	    
	          Stopping container...
    
            Check your START_MODE, the number must be between 1 and 6
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "
	      exit
    
    }
    
    # Check requeriments

    # Check if script is missing

    if [ ! -f sdtdserver ]; then
        
	    echo "
            =======================================================================
            IMPORTANT:
            
            LinuxGSM script is missing, downloading...
            =======================================================================
            "
	
            wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh sdtdserver
	
    fi
    
    # Check if server have been installed

    if [ ! -f serverfiles/DONT_REMOVE.txt ]; then

            echo "
            =======================================================================
            IMPORTANT:
            
            It seems to be the first installation, making preparations...
            =======================================================================
            "

        # Start to create default files
        ./sdtdserver
        
            echo "
            =======================================================================
            IMPORTANT:
            
            PREPARATIONS COMPLETED
	    
            Making first server installation.
            =======================================================================
            "
	
	    # Install 7 Days To Die Server

        ./sdtdserver auto-install

            echo "
            =======================================================================
            IMPORTANT:
            
            The server have been installed.
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "
	    
            echo "If this file is missing, server will be re-installed" > serverfiles/DONT_REMOVE.txt
    fi

# Use of case to avoid errors if used wrong START_MODE

  case $START_MODE in
     1)
        startServer
     ;;
     2)
        update
	exit
     ;;
     3)
        update
        startServer
     ;; 
     4)
        backupServer
	exit
     ;;
     *)
        startModeError
     ;;
  esac
