#!/bin/bash
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
