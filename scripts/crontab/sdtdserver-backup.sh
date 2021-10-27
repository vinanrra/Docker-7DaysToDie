#!/bin/bash
STRING="0 5 * * *  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1"

if  crontab -l | grep -q "$STRING" ; then
         (crontab -l 2>/dev/null; echo "0 5 * * *  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1") | crontab -
fi

echo "
            =======================================================================
            IMPORTANT:
            
            Activated automatic backup at 5AM
            =======================================================================
            "
