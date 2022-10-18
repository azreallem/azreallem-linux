#!/bin/bash

gg=$(grep -Inr --color=always --include=*.{cpp,c,h,td,inc}  $1 \
     | awk '{printf("%3d\.\ %s\n",NR,$0)}' \
     | tee /dev/tty)

echo "=------------------------------------------="
gg=$(echo "$gg" | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g")


read -p "Enter line(1-100, 0 is exit): " LINE
if [ $LINE -ne 0 ]
then
	line_code="$(echo "${gg:5}" | awk '{print $1}' | sed -n ""$LINE"p")"
	lf=${line_code%%:*}
	line_code=${line_code#*:}
	ll=${line_code%%:*}
	vim  $lf +$ll
fi
