#!/usr/bin/env bash

# Install
if [ "$START_MODE" = "0" ]; then
    ./sdtdserver auto-install && exit
fi

# Start server
if [ "$START_MODE" = "1" ]; then
	./sdtdserver start
fi

# Update to stable
if [ "$START_MODE" = "2" ]; then
    cp sdtdserver.cfg.stable /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update && exit
fi

# Update to stable and start
if [ "$START_MODE" = "3" ]; then
    cp sdtdserver.cfg.stable /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
	./sdtdserver start
fi

# Update to experimental
if [ "$START_MODE" = "4" ]; then
    cp sdtdserver.cfg /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update && cp serverfiles/serverconfig.xml serverfiles/sdtdserver.xml && exit
fi

# Update to experimental and start
if [ "$START_MODE" = "5" ]; then
    cp sdtdserver.cfg /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    cp serverfiles/serverconfig.xml serverfiles/sdtdserver.xml
	./sdtdserver start
fi
