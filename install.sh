#!/bin/bash

    if [ ! -f sdtdserver ]; then
        
	echo "
            =======================================================================
            IMPORTANT:
            
            LinuxGSM script is missing, downloading...
            =======================================================================
            "
	
        wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh sdtdserver
	
    fi
    
    if [ ! -f DONT_REMOVE.txt ]; then
    
        # Start to create default files
        ./sdtdserver
        
	# Install 7 Days To Die Server
        ./sdtdserver auto-install

        echo "
            =======================================================================
            IMPORTANT:
            
            The server have been installed.
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "
	    
	echo "If this file is missing, server will be re-installed" > DONT_REMOVE.txt
    fi

    # Start server
    if [ "$START_MODE" = "1" ]; then

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
    fi

    # Update to stable
    if [ "$START_MODE" = "2" ]; then

        ./sdtdserver update

        cp -v sdtdserver.cfg.stable lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

        ./sdtdserver update

        echo "
            =======================================================================
            IMPORTANT:

            The server have been updated to STABLE, now switch between "START_MODE"
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "

        exit
    fi

    # Update to stable and start
    if [ "$START_MODE" = "3" ]; then

        ./sdtdserver update

        cp -v sdtdserver.cfg.stable lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
        
        ./sdtdserver update

        echo "The server have been updated to STABLE."

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

    fi

    # Update to experimental
    if [ "$START_MODE" = "4" ]; then

        ./sdtdserver update

        cp -v sdtdserver.cfg lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
        
        ./sdtdserver update
        
        cp -v serverfiles/serverconfig.xml serverfiles/sdtdserver.xml

        echo "
            =======================================================================
            IMPORTANT:

            The server have been updated to EXPERIMENTAL, now switch between "START_MODE"
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "
	exit
    fi

    # Update to experimental and start
    if [ "$START_MODE" = "5" ]; then

        ./sdtdserver update

        cp -v sdtdserver.cfg lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
        
        ./sdtdserver update
        
        cp -v serverfiles/serverconfig.xml serverfiles/sdtdserver.xml

        echo "The server have been updated to EXPERIMENTAL."

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
    fi

if (($START_MODE >= 6)) || (($START_MODE = 0)); then
echo "
    =======================================================================
    IMPORTANT:
    
    START_MODE $START_MODE UNKNOWN
    
    Check your START_MODE the number must be between 1 and 5
    More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
    =======================================================================
    "
fi
