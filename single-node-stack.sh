#!/bin/bash

# Single Node Stack
LOG_FILE=/tmp/stack.log 
rm -f $LOG_FILE

### Functions
DBSetup() {
    yum install mariadb-server -y &>>$LOG_FILE 
    echo $?
}


### Main Program
DBSetup