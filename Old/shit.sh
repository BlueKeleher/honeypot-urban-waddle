#!/bin/bash
while [ 1 ]
do 
echo "-------------------------`date`-------------------------" >> crap
ps aux --sort -rss | head -10 >> crap
echo "=========================Honeypots=========================" >> crap
sudo vzmemcheck -v | sed 's/\s\s*/ /g' | cut -d ' ' -f 1,4 | tail -5 >> crap
sleep 5
done
