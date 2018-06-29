#!/bin/bash

# Single Node Stack
LOG_FILE=/tmp/stack.log 
rm -f $LOG_FILE

## COLOR VARS
G="\e[32m"
Y="\e[33m"
R="\e[31m"
N="\e[0m"

TOMCAT_URL="http://redrockdigimark.com/apachemirror/tomcat/tomcat-9/v9.0.10/bin/apache-tomcat-9.0.10.tar.gz"
TOMCAT_DIR="/opt/$(echo $TOMCAT_URL| awk -F / '{print $NF}' | sed -e 's/.tar.gz//')"
WAR_URL='https://github.com/cit-aliqui/APP-STACK/raw/master/student.war'
JAR_URL='https://github.com/cit-aliqui/APP-STACK/raw/master/mysql-connector-java-5.1.40.jar'
IPADDRESS=$(hostname -i)
CONTEXT=$(echo '<Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource" maxActive="50" maxIdle="30" maxWait="10000" username="student" password="student@1" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql://IPADDRESS:3306/studentapp"/>' | sed -e "s/IPADDRESS/$IPADDRESS/")

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
    if [ "$1" = SKIP ]; then 
        echo -e "-- ${Y}SKIPPING$N" 
    elif [ $1 -eq 0 ]; then 
        Succ
    else
        Fail
    fi
}

DBSetup() {
    Head "DB Server Configurations"
    Print "Installing MariaDB Server"
    yum install mariadb-server -y &>>$LOG_FILE 
    Stat $? 
    Print "Starting MariaDB Server"
    systemctl enable mariadb &>>$LOG_FILE
    systemctl start mariadb &>>$LOG_FILE
    Stat $? 
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
    Print "Configuring Database"
    mysql < /tmp/student.sql &>>$LOG_FILE
    Stat $? 

}

AppSetup() {
    Head "Application Server Configurations"
    Print "Installing Java"
    yum install java -y &>>$LOG_FILE
    Stat $?
    Print "Downloading Tomcat"
    if [ -d $TOMCAT_DIR ]; then 
        Stat SKIP
    else
        cd /opt
        wget -qO - $TOMCAT_URL | tar -xz 
        Stat $?
    fi
    rm -rf $TOMCAT_DIR/webapps/*
    Print "Downloading WAR file"
    wget -q $WAR_URL -O $TOMCAT_DIR/webapps/student.war 
    Stat $?
    Print "Downloading JDBC Jar file"
    wget -q $JAR_URL -O $TOMCAT_DIR/lib/mysql-connector-java-5.1.40.jar
    Stat $?
    sed -i -e '/TestDB/ d' -e "$ i $CONTEXT" $TOMCAT_DIR/conf/context.xml
}

### Main Program

## Check Root User or not.
if [ $(id -u) -ne 0 ]; then 
    echo -e "${R}You should be a root user to execute this script$N"
    exit 2
fi 
#DBSetup
AppSetup