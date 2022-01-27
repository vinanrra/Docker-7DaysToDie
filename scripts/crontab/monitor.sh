#!/bin/bash
echo "*/5 * * * *  /home/sdtdserver/sdtdserver monitor > /dev/null 2>&1" >> crontab.txt

echo "[INFO] Activated LinuxGSM server monitoring"
