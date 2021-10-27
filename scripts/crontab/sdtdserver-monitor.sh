#!/bin/bash
STRING="*/5 * * * *  /home/sdtdserver/sdtdserver monitor > /dev/null 2>&1"

if  crontab -l | grep -q "$STRING" ; then
    (crontab -l 2>/dev/null; echo "*/5 * * * *  /home/sdtdserver/sdtdserver monitor > /dev/null 2>&1") | crontab -
fi

echo "
            =======================================================================
            IMPORTANT:
            
            Activated server monitoring, automatic restart if crash
            =======================================================================
            "
