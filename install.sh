if [ "$START_MODE" = "0" ]; then
	echo "Installing 7 days to die server"
    ./sdtdserver auto-install
    echo "7 Days to die server installed"
    exit
fi

if [ "$START_MODE" = "1" ]; then
	echo "Starting 7 days to die server"
    ./sdtdserver start
    echo "7 Days to die server started"
fi

if [ "$START_MODE" = "2" ]; then
	echo "Updating 7 days to die server"
    cp sdtdserver.cfg.stable /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    echo "7 Days to die server updated"
	exit
fi

if [ "$START_MODE" = "3" ]; then
	echo "Updating 7 days to die server"
    cp sdtdserver.cfg.stable /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    echo "7 Days to die server updated"
	echo "Starting 7 Days to die server"
    ./sdtdserver start
fi

if [ "$START_MODE" = "4" ]; then
	echo "Updating 7 days to die server to LATEST_EXPERIMENTAL"
    cp sdtdserver.cfg /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    cp serverfiles/serverconfig.xml serverfiles/sdtdserver.xml
    echo "7 Days to die server updated to LATEST_EXPERIMENTAL"
	exit
fi

if [ "$START_MODE" = "5" ]; then
	echo "Updating 7 days to die server to LATEST_EXPERIMENTAL"
    cp sdtdserver.cfg /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    cp serverfiles/serverconfig.xml serverfiles/sdtdserver.xml
    echo "7 Days to die server updated to LATEST_EXPERIMENTAL"
    echo "Starting 7 Days to die server"
    ./sdtdserver start
	exit
fi
