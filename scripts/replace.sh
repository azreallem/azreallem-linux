#!/bin/bash
# =-----------------------------------------------------------------------------=
# Please run in terminal about `replaces.sh STR REPLACE_STR [FILETYPE1 ...]`;
# =-----------------------------------------------------------------------------=

if [ -z $3 ]
then
sed -i "s/$1/$2/g" `grep -rl $1`
else
sed -i "s/$1/$2/g" `grep -rl $1 --include=*.{$3,$4,$5,$6}`
fi
