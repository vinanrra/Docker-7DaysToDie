#!/bin/sh
function exit_handler {
	echo "
            =======================================================================
            
            Shutdown signal received..
            
            =======================================================================
        "

	# Execute the  shutdown commands
        su-exec sdtdserver ./sdtdserver stop

	echo "
            =======================================================================
            
            7 DAYS TO DIE SERVER HAVE BEEN STOPPED
            
            =======================================================================
        "
	exit
}

# Trap specific signals and forward to the exit handler
trap exit_handler EXIT SIGTERM

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

# Apply owner to the folder to avoid errors
chown -R sdtdserver:sdtdserver /home/sdtdserver

# Change user to sdtdserver
su-exec sdtdserver "$@"
