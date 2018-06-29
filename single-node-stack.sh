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
Print() {
    echo -n -e "$1"
}
Succ() {
    echo -e " -- ${G}SUCCESS $N"
}

Fail() {
    echo -e " -- ${R}FAILURE$N"
    echo "Check the log file -- $LOG_FILE"
    exit 1
}

Head() {
    echo -e "\t\e[1;4;36m$1$N"
}

Stat() {
    if [ $1 -eq 0 ]; then 
        Succ
    else
        Fail
    fi
}

DBSetup() {
    Head "DB Server Configurations"
    yum install mariadb-server -y &>>$LOG_FILE 
    Stat $? "Installing MariaDB Server"
    systemctl enable mariadb &>>$LOG_FILE 
    systemctl start mariadb &>>$LOG_FILE
    Stat $? "Starting MariaDB Server"
    echo "create database if not exists studentapp;
use studentapp;
CREATE TABLE if not exists Students(student_id INT NOT NULL AUTO_INCREMENT,
	student_name VARCHAR(100) NOT NULL,
    student_addr VARCHAR(100) NOT NULL,
	student_age VARCHAR(3) NOT NULL,
	student_qual VARCHAR(20) NOT NULL,
	student_percent VARCHAR(10) NOT NULL,
	student_year_passed VARCHAR(10) NOT NULL,
	PRIMARY KEY (student_id)
);
grant all privileges on studentapp.* to 'student'@'%' identified by 'student@1';
flush privileges;" >/tmp/student.sql 
    mysql < /tmp/student.sql &>>$LOG_FILE
    Stat $? "Configuring Database"

}

AppSetup() {
    Head "Application Server Configurations"
    Print "Installing Java"
    yum install java -y &>>$LOG_FILE
    Stat $? 
}

### Main Program

## Check Root User or not.
if [ $(id -u) -ne 0 ]; then 
    echo -e "${R}You should be a root user to execute this script$N"
    exit 2
fi 
#DBSetup
AppSetup