#!/bin/sh

dir1=`pwd`
find $dir1 -name ".*.swp" | while read line
do
	echo "rm $line"
	rm $line
done
echo "Clean finished."
