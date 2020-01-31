#!/bin/sh

set -eu

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

su-exec sdtdserver "$@"
