#!/bin/bash

# Single Node Stack

### Functions
DBSetup() {
    yum install mariadb-server -y &>/dev/null
    echo $?
}


### Main Program
DBSetup