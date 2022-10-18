#!/bin/sh

dir=$HOME/log/tmp
if [ ! -d $dir ]; then
  mkdir -p $dir
fi
nohup "/mnt/d/Program Files/Microsoft VS Code/Code.exe" $1 > $dir/vscode.log &
