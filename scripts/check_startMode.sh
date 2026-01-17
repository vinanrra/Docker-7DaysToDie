#!/bin/bash
set -e

echo "
    =======================================================================
    IMPORTANT:

    START_MODE $START_MODE UNKNOWN

    Stopping container...

    Check your START_MODE, the number must be between 0 and 4
    More info: https://github.com/vinanrra/Docker-7DaysToDie/blob/master/docs/parameters.md#start-modes
    =======================================================================
"

exit 1
