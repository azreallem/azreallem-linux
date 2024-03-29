#!/bin/bash
# -------------------------------------------
# SYNOPSIS
#        gg.sh string
#        gg.sh "string1 string2" "linux-4.19/driver"
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
#gg=$(grep -Inr --color=always --include=*.{cpp,c,h,td,inc}  "$1" \
gg=$(grep -Iinr --color=always --exclude={tags,*output*,cscope.*,*.log} "$1" $2 \
     | awk '{printf("%3d. %s\n",NR,$0)}' \
     | tee /dev/tty)
gg=$(echo "$gg" | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g")
echo "=------------------------END-------------------------------="


read -p "Please input No.(1-999, 0 is exit) to open file: " LINE
if [ $LINE -ne 0 ]
then
	line_code="$(echo "${gg}" | awk '{print $2}' | sed -n ""$LINE"p")"
	lf=${line_code%%:*}
	line_code=${line_code#*:}
	ll=${line_code%%:*}
	vim  $lf +$ll
fi
