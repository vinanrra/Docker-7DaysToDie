#!/bin/bash
(crontab -l 2>/dev/null; echo "0 5 * * *  /home/sdtdserver/sdtdserver backup > /dev/null 2>&1") | crontab -
