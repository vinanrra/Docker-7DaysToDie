#!/bin/bash
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
chown -R sdtdserver:sdtdserver /home/sdtdserver

# Start cron
service cron start

# Change user to sdtdserver
su-exec sdtdserver bash /home/sdtdserver/install.sh
