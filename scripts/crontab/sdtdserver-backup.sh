#!/bin/bash
FILE="/var/spool/cron/crontabs/sdtdserver"
STRING="0 5 * * *  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1"

if  grep -q "$STRING" "$FILE" ; then
         (crontab -l 2>/dev/null; echo "0 5 * * *  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1") | crontab -
fi

echo "
            =======================================================================
            IMPORTANT:
            
            Activated automatic backup at 5AM
            =======================================================================
            "
