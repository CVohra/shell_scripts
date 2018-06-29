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
    echo -e "$1 -- ${G}SUCCESS $N"
}

Fail() {
    echo -e "$1 -- ${R}FAILURE$N"
    echo "Check the log file -- $LOG_FILE"
    exit 1
}

Head() {
    echo -e "\t\e[1;4;36m$1$N"
}

Stat() {
    if [ $1 -eq 0 ]; then 
        Succ "$2"
    else
        Fail "$2"
    fi
}

DBSetup() {
    Head "DB Server Configurations"
    yum install mariadb-server -y &>>$LOG_FILE 
    Stat $? "Installing MariaDB Server"
    systemctl enable mariadb &>>$LOG_FILE 
    systemctl start mariadb &>>$LOG_FILE
    Stat $? "Starting MariaDB Server"

}


### Main Program

## Check Root User or not.
if [ $(id -u) -ne 0 ]; then 
    echo -e "${R}You should be a root user to execute this script"
    exit 2
fi 
DBSetup