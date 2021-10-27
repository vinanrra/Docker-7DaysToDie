#!/bin/bash
FILE="/var/spool/cron/crontabs/sdtdserver"
STRING="*/5 * * * *  /home/sdtdserver/sdtdserver monitor > /dev/null 2>&1"

if  grep -q "$STRING" "$FILE" ; then
    (crontab -l 2>/dev/null; echo "*/5 * * * *  /home/sdtdserver/sdtdserver monitor > /dev/null 2>&1") | crontab -
fi

echo "
            =======================================================================
            IMPORTANT:
            
            Activated server monitoring, automatic restart if crash
            =======================================================================
            "