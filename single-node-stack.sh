#!/bin/bash

### Functions
DBSetup() {
    yum install mariadb-server -y &>/dev/null
    echo $?
}


### Main Program
DBSetup