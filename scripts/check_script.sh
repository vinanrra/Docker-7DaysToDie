#!/bin/bash
echo "[INFO] LinuxGSM script is missing, downloading..."
wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh sdtdserver
