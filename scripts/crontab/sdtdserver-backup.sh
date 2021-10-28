#!/bin/bash
echo "0 5 * * *  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1" >> crontab.txt

echo "
            =======================================================================
            IMPORTANT:
            
            Activated automatic backup at 5AM
            =======================================================================
            "
