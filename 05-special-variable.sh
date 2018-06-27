#!/bin/bash 

## Special variable are .. $0->$9($n), $*, $@, $#, $$, $?

echo Script Name = $0
echo First Argument = $1
echo Second Argument = $2
echo All Arguments = $*
echo All Arguments = $@
echo Number of arguments = $#

echo PID of the script = $$