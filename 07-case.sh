#!/bin/bash 

IP=$1
ping -c 2 $IP &>/dev/null
STAT=$?

# case $var in 
#   pat1) commands ;;
#   pat2) commands ;;
# esac
case $STAT in 
    0)  echo "SUCCESS" 
        exit 0 ;;
    1)  echo "FAILURE"
        exit 1 ;;
    *)  echo "UNKNOWN"
        exit 5 ;;
esac
