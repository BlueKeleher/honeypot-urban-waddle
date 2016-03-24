#!/bin/bash
ps aux | grep "network_usage.sh" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "cut -d b -f 1" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "cut -d = -f 2" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "cut -d > -f 2" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "grep <=" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "grep =>" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "iftop" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "numfmt" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "tr -d [:blank:]" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
ps aux | grep "awk {x+=$0}END{print x}" | cut -c 10-18 | tr -d [[:blank:]] >> killlist
sudo kill -9 $(cat /git/killlist)
rm killlist
