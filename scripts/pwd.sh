#!/bin/bash

pwdd="$(pwd)"
echo $pwdd
findd=$(find $pwdd -name $1)
echo $findd
findd=${findd:2}
echo $findd

