#!/bin/sh

dir=$HOME/log/tmp
if [ ! -d $dir ]; then
  mkdir -p $dir
fi
nohup python3 $HOME/acloong_request.null.py > $dir/net_config.log &
