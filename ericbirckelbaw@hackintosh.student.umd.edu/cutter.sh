#!/bin/bash
target=$1
num_commands=`cat $target | wc -l`
quarter_commands=`printf "%.0f" $(echo "scale=2; $num_commands / 4" | bc)`
cat $target | head -${quarter_commands} > ${target}_25
