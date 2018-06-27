#!/bin/bash 

read -p 'Enter your name: ' name 
echo "Your name = $name"

## You can read some secret text 
read -s -p 'Enter your Password: ' pass 
echo -e "\nYour Password = $pass"

