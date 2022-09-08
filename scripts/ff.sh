#!/bin/bash

file_name="$(find . -name $1)"
if [ -z $file_name ]
then
	echo "not find files: $1"
else
	vim $file_name $2
fi
