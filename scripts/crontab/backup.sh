#!/bin/bash
echo "${BACKUP_TIMER}  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1" >> crontab.txt

echo "
    =======================================================================
    IMPORTANT:

    Activated automatic backup at ${BACKUP_TIMER}

    =======================================================================
"
