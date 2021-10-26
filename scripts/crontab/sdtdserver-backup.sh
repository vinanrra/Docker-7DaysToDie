#!/bin/bash
(crontab -l 2>/dev/null; echo "0 5 * * *  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1") | crontab -
echo "
            =======================================================================
            IMPORTANT:
            
            Added automatic backup at 5AM
            =======================================================================
            "
