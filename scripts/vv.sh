#!/bin/sh
# -------------------------------------------
# SYNOPSIS
#        vv.sh FILE:LINE
#        vv.sh FILE
# EXAMPLE
#        vv.sh test.c:4
#        vv.sh test.c
# SAME AS
#        vim test.c +4
#        vim test.c
# -------------------------------------------

line_code=$1

lf=${line_code%%:*}
line_code=${line_code#*:}
ll=${line_code%%:*}
if [ ! lf=ll ] ; then
vim  $lf
else
vim $lf +$ll
fi
