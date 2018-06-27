#!/bin/bash 

## echo command is used to print message on screen
echo Hello World

## You can print some new lines and new tabs and colors while printing.

echo line1
echo line2

### Escape seq like \n will work if you enable -e option in echo command, And also input should be provided in quotes (Preferred double quotes)
echo -e "line1\nline2"
echo -e "word1\t\tword2"

## We can print colors with escape seq
## echo -e "\e[COLmMESSAGE"
## Colors are Red(31) Green(32) Yellow(33) Blue(34) Magenta(35) Cyan(36) reset(0)
echo -e "\e[31mRed Color \e[32mGreen Color \e[33mYellow Color \e[34mBlue Color \e[35mMagenta Color \e[36mCyan Color\e[0m"

echo "Today date is 2018-06-27"

### Colors are two types, 1. Foreground 2. Background
## Explore using the URL :   https://misc.flogisoft.com/bash/tip_colors_and_formatting
