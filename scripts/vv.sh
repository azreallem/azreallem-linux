#!/bin/sh

line_code=$1

lf=${line_code%%:*}
line_code=${line_code#*:}
ll=${line_code%%:*}
if [ lf=ll ] ; then
vim  $lf
else
vim $lf +$ll
fi
