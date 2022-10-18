#!/bin/bash
# -------------------------------------------
# SYNOPSIS
#        show.sh FILE_Part
# EXAMPLE
#        show.sh test
# EXAMPLE OUTPUT
#        /home/gaoliang/sources/github/azreallem-linux/scripts/test/test.c
# -------------------------------------------


file_name="$(find $(pwd) -name *$1*)"
if [ -z $file_name ]
then
	echo "Not find file: $1"
else
	echo $file_name
fi
