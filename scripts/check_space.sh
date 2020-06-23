#!/bin/bash
FREE=`df -k --output=avail "$PWD" | tail -n1`   # df -k not df -h
FREEGB=$(expr $FREE / 1024 / 1024)
if [[ $FREE -lt 12582912 ]]; then               # 12G = 12*1024*1024k
     echo "
            =======================================================================
            ERROR:
            
            Not enough space.
            
            Needed: 12GB
            Available: $FREEGB
            
            =======================================================================
            "
fi
