echo "
USER INFO:

UID: $PUID
GID: $PGID

MORE INFO:

If you have permission problems remember to use same PUID and PGID that your main user use.
Check it with "id" command
If problem persist check: https://github.com/vinanrra/Docker-7DaysToDie/blob/master/README.md
"

adduser --disabled-password --shell /bin/bash --disabled-login --gecos "" sdtdserver
groupmod -o -g "$PGID" sdtdserver
usermod -o -u "$PUID" sdtdserver
