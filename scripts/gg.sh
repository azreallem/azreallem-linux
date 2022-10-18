#!/bin/bash
# -------------------------------------------
# SYNOPSIS
#        gg.sh string
# EXAMPLE
#        gg.sh hello
#EXAMPLE OUTPUT
#=-----------------------BEGIN------------------------------=
#1. test.c:5:  printf("hello world\n");
#=------------------------END-------------------------------=
#Please input No.(1-999, 0 is exit) to open file:
#  (Tips:if you input:1, then will run `vim test.c +5`)
#
# -------------------------------------------

echo "=-----------------------BEGIN------------------------------="
gg=$(grep -Inr --color=always --include=*.{cpp,c,h,td,inc}  $1 \
     | awk '{printf("%3d. %s\n",NR,$0)}' \
     | tee /dev/tty)
gg=$(echo "$gg" | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g")
echo "=------------------------END-------------------------------="


read -p "Please input No.(1-999, 0 is exit) to open file: " LINE
if [ $LINE -ne 0 ]
then
	line_code="$(echo "${gg:5}" | awk '{print $1}' | sed -n ""$LINE"p")"
	lf=${line_code%%:*}
	line_code=${line_code#*:}
	ll=${line_code%%:*}
	vim  $lf +$ll
fi
