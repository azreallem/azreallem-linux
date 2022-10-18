#!/bin/sh
# Description: rm all .*.swp file;

find $(pwd) -name ".*.swp" | while read line
do
	echo "rm $line"
	rm $line
done
echo "Clean finished."
