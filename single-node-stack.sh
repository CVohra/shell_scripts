#!/bin/bash

# Single Node Stack
LOG_FILE=/tmp/stack.log 
rm -f $LOG_FILE

## COLOR VARS
G="\e[32m"
Y="\e[33m"
R="\e[31m"
N="\e[0m"

### Functions
Succ() {
    echo -e "$1 -- $G SUCCESS $N"
}


DBSetup() {
    yum install mariadb-server -y &>>$LOG_FILE 
    if [ $? -eq 0 ]; then 
        Succ "Installing DB Server"
    else
        echo "Installing DB Server -- FAILURE"
        echo "Check the log file -- $LOG_FILE"
        exit 1
    fi
}


### Main Program
DBSetup