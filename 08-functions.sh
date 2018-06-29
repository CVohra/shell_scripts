#!/bin/bash

### Define a function
SAMPLE() {
    echo hai from function 
    echo '$1 of function =' $1
    #local a=20
    echo a in function = $a
    return 1
}

## Main program
# Accessing the function
a=10
SAMPLE abc
echo "Exit status of function = $?"
echo value of a in main program = $a

