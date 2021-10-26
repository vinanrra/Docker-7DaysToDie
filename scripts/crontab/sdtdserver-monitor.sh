#!/bin/bash
(crontab -l 2>/dev/null; echo "*/5 * * * *  /home/sdtdserver/sdtdserver monitor > /dev/null 2>&1") | crontab -
echo "
            =======================================================================
            IMPORTANT:
            
            Added server monitoring, automatic restart if crash
            =======================================================================
            "