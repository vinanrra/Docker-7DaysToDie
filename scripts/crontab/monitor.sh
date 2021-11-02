#!/bin/bash
echo "*/5 * * * *  /home/sdtdserver/sdtdserver monitor > /dev/null 2>&1" >> crontab.txt

echo "
            =======================================================================
            IMPORTANT:
            
            Activated server monitoring, automatic restart if crash
            =======================================================================
            "
