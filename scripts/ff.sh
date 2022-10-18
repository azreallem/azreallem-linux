#!/bin/bash
# -------------------------------------------
# SYNOPSIS
#        ff.sh FILE [ARGS]
# EXAMPLE
#        ff.sh test.c
#        ff.sh test.c +4
# SAME AS
#        first, `find -name test.c`;
#        if file exist, run `vim test.c +4`;
#        if file not exist, print "not find file: test.c";
# -------------------------------------------

file_name="$(find -name $1)"
if [ -z $file_name ]
then
	echo "not find file: $1"
else
	vim $file_name $2
fi
