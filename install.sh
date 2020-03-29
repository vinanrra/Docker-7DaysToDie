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
    
    }
    
    AlertServer () {
    
        ./sdtdserver test-alert
	
	    echo "
            =======================================================================
            IMPORTANT:
            
            Testing alerts...
            Check your alerts method
            =======================================================================
            "
    
    }
    
    update () {
    
        ./sdtdserver update

        if [ "$VERSION" == 'stable'  ]
        then
	    # Remove branch line
            sed -i '/branch/d' /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
        else
	    # Remove branch line if exist to avoid multiple branch lines
	    sed -i '/branch/d' /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
	    
            echo branch='"-beta $VERSION"' >> /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
	    
            echo "
            =======================================================================
            IMPORTANT:
            
            Server version changed to: $VERSION
            
            =======================================================================
            "
        fi

        ./sdtdserver update

            echo "
            =======================================================================
            IMPORTANT:

            The server have been updated to $VERSION, now switch between START_MODE
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "

    }
    
    backupServer () {
    
            
    
            echo "
            =======================================================================
            IMPORTANT:
    
            This backup will create a complete tar bzip2 archive of the whole server.
            
            =======================================================================
            "
	    
	    sleep 3s
	    
            ./sdtdserver backup
	    
	    sleep 3s
	    
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
	
	# Add alerts examples
	
	    mv -f common.cfg /home/sdtdserver/lgsm/config-lgsm/sdtdserver/common.cfg
	
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
	if [ "$TEST_ALERT" == 'YES'  ]
	then
	AlertServer
	fi
	tail -f /dev/null
     ;;
     2)
        update
	exit
     ;;
     3)
        update
        startServer
	if [ "$TEST_ALERT" == 'YES'  ]
	then
	AlertServer
	fi
	tail -f /dev/null
     ;; 
     4)
        backupServer
	exit
     ;;
     *)
        startModeError
     ;;
  esac
