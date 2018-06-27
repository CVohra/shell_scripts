#!/bin/bash

## define a variable as follows
a=10
## access the variable by using $ symbol followed with variable name
echo Value of a = $a 

## Variable in shell doesn't have data types (by default), everything is a string
## Command Substution
users=$(who | wc -l)
echo "No of users logged in = $users"

## Arithematic substution
ADD=$((1+2))

#DATE=$(date +%F)
echo "Today date is $(date +%F)"

## Properties of a variable 1. Local 2. ReadWrite 3. Scalar
### We will try to access a variable from CLI
echo "Logged in Username = $USER"
echo "Class = $class"