#!/bin/bash

gg="$(grep -Inr --include=*.{cpp,c,h,td,inc} $1 ./)"
echo "$gg"
read -p "Enter line(1-100, 0 is exit):" LINE
if [ $LINE -ne 0 ]
then
	line_code="$(echo "$gg" | awk '{print $1}' | sed -n ""$LINE"p")"
	echo $line_code
	lf=${line_code%%:*}
	line_code=${line_code#*:}
	ll=${line_code%%:*}
	vim  $lf +$ll
fi
