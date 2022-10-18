#!/bin/bash
# -------------------------------------------
# SYNOPSIS
#        replace.sh OLD_STR NEW_STR [FILETYPE1 ...]
# EXAMPLE
#        replace.sh hello Hello
#        replace.sh hello Hello c
# -------------------------------------------

if [ -z $3 ]
then
sed -i "s/$1/$2/g" `grep -rl $1`
else
sed -i "s/$1/$2/g" `grep -rl $1 --include=*.{$3,$4,$5,$6}`
fi
