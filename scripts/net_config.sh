#!/bin/sh

#sudo /sbin/ifconfig enp0s3f0 down
#sudo /sbin/ifconfig enp0s3f0 hw ether 00:23:a0:00:54:97
#sudo /sbin/ifconfig enp0s3f0 up

nohup python3 $HOME/scripts/acloong_request.null.py > $HOME/net_config.log &
