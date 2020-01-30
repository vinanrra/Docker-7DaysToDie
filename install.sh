#!/usr/bin/env bash

# Install
if [ "$START_MODE" = "0" ]; then
    ./sdtdserver auto-install
fi

# Start server
if [ "$START_MODE" = "1" ]; then
    ./sdtdserver start
    sleep 2m
    ./sdtdserver details
    tail -f /dev/null
fi

# Update to stable
if [ "$START_MODE" = "2" ]; then
    cp -v sdtdserver.cfg.stable lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update && exit
fi

# Update to stable and start
if [ "$START_MODE" = "3" ]; then
    cp -v sdtdserver.cfg.stable lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    ./sdtdserver start
    sleep 2m
    ./sdtdserver details
    tail -f /dev/null
fi

# Update to experimental
if [ "$START_MODE" = "4" ]; then
    cp -v sdtdserver.cfg lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    cp -v serverfiles/serverconfig.xml serverfiles/sdtdserver.xml
fi

# Update to experimental and start
if [ "$START_MODE" = "5" ]; then
    cp -v sdtdserver.cfg lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
    ./sdtdserver update
    cp -v serverfiles/serverconfig.xml serverfiles/sdtdserver.xml
    ./sdtdserver start
    sleep 2m
    ./sdtdserver details
    tail -f /dev/null
fi
