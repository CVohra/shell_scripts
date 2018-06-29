#!/bin/bash

# Single Node Stack
LOG_FILE=/tmp/stack.log 
rm -f $LOG_FILE

### Functions
DBSetup() {
    yum install mariadb-server -y &>>$LOG_FILE 
    if [ $? -eq 0 ]; then 
        echo "Installing DB Server -- SUCCESS"
    else
        echo "Installing DB Server -- FAILURE"
        exit 1
    fi
}


### Main Program
DBSetup