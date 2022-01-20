#!/bin/bash
echo "
    =======================================================================
    IMPORTANT:

    This backup will create a complete tar bzip2 archive of the whole server.

    =======================================================================
"

sleep 3s

./sdtdserver backup

sleep 3s

echo "
    =======================================================================
    IMPORTANT:
    
    Backup complete.
    
    =======================================================================
"
