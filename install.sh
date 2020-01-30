#!/usr/bin/env bash

echo "
USER INFO:

UID: $PUID
GID: $PGID

MORE INFO:

If you have permission problems remember to use same PUID and PGID that your main user use.
Check it with "id" command
If problem persist check: https://github.com/vinanrra/Docker-7DaysToDie/blob/master/README.md
"

groupmod -o -g "$PGID" sdtdserver
usermod -o -u "$PUID" sdtdserver
chown -R sdtdserver:sdtdserver /home/sdtdserver

# Changing user

su stdserver -c "

# Changing user

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
"
