#!/bin/bash

exit_handler() {
    # Execute the  shutdown commands
    echo "[INFO] Stopping 7 Days To Die Server"
    su-exec sdtdserver /home/sdtdserver/sdtdserver stop
    echo "[INFO] 7 Days To Die Server has been stopped"
    exit 0
}

# Trap specific signals and forward to the exit handler
trap exit_handler SIGINT SIGTERM

set -eu

# Print info
echo "
        =======================================================================
        USER INFO:

        UID: $PUID
        GID: $PGID

        MORE INFO:

        If you have permission problems remember to use same user UID and GID.
        Check it with "id" command
        If problem persist check:
        https://github.com/vinanrra/Docker-7DaysToDie/blob/master/README.md
        =======================================================================
"

# Set user and group ID to sdtdserver user
groupmod -o -g "$PGID" sdtdserver  > /dev/null 2>&1
usermod -o -u "$PUID" sdtdserver  > /dev/null 2>&1

# Locale, Timezone
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
ln -snf /usr/share/zoneinfo/$TimeZone /etc/localtime && echo $TimeZone > /etc/timezone

# Apply owner to the folder to avoid errors
if [ "$CHANGE_CONFIG_DIR_OWNERSHIP" != "NO" ]; then
    chown -R sdtdserver:sdtdserver /home/sdtdserver
fi 

# Start cron
service cron start

# Change user to sdtdserver
su-exec sdtdserver bash /home/sdtdserver/install.sh &
# If bash is waiting for a command to complete and receives a signal for which a trap has been set, the trap will not be executed until the command completes.
# When bash is waiting for an asynchronous command via the wait builtin,
# the reception of a signal for which a trap has been set will cause the 'wait' builtin to return immediately with an exit status greater than 128,
# immediately after which the trap is executed.
wait $!
