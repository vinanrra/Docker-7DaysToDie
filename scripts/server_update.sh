#!/bin/bash
./sdtdserver update

        if [ "${VERSION,,}" == 'stable'  ]
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
            
            Server version changed to: ${VERSION,,}
            
            =======================================================================
            "
        fi

        ./sdtdserver update

            echo "
            =======================================================================
            IMPORTANT:

            The server have been updated to ${VERSION,,}
            More info: https://github.com/vinanrra/Docker-7DaysToDie#start-modes
            =======================================================================
            "

        if [ "${ALLOC_FIXES,,}" == 'yes'  ]
        then
        source $scriptsDir/Mods/alloc_fixes.sh

            echo "
            =======================================================================
            IMPORTANT:

            Alloc Fixes updated.
            =======================================================================
            "
        else
            echo "
            =======================================================================
            IMPORTANT:

            Not installing new Alloc Fixes.
            =======================================================================
            "
        fi
