#!/bin/bash

source $scriptsDir/check_space.sh
	    
	    if [ "$space" == 'no'  ]; then
	    
	    echo "
            =======================================================================
            ERROR:
            
            Not enough space.
            
            Needed: 12 GB
            Available: $freeGB GB
            
            =======================================================================
            "
	    	exit
	    fi

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
