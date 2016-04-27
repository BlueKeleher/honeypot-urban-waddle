#!/bin/bash

#load file from argument
file=$1

#initialize variables at zero
explore_total=0
honey_total=0
malware_total=0
ddos_total=0
nuke_total=0

#analyze doculemt and total catagory values
scan() {
count=`grep "$1" $file | wc -l` 
explore=`expr $count \* $2`
honey=`expr $count \* $3`
malware=`expr $count \* $4`
ddos=`expr $count \* $5`
nuke=`expr $count \* $6`
explore_total=`expr $explore_total + $explore`
honey_total=`expr $honey_total + $honey`
malware_total=`expr $malware_total + $malware`
ddos_total=`expr $ddos_total + $ddos`
nuke_total=`expr $nuke_total + $nuke`
}

#scan for the following commands with given valuse in |explore|honey|malware|ddos|nuke|
scan potato 10 0 0 0 0
scan tomato 0 10 0 0 0
scan apple 0 0 10 0 0
scan banana 0 0 0 10 0
scan grape 0 0 0 0 10
scan orange 0 5 0 5 0
scan pear 5 0 5 0 5

#calculate percentages
weight_total=`expr $explore_total + $honey_total + $malware_total + $ddos_total + $nuke_total`
explore_percent=`expr $explore_total / $weight_total`
honey_percent=`expr $honey_total / $weight_total`
malware_percent=`expr $malware_total / $weight_total`
ddos_percent=`expr $ddos_total / $weight_total`
nuke_percent=`expr $nuke_total / $weight_total`

#calculate which is highest
echo "$explore_percent explore" >> temp
echo "$honey_percent honey" >> temp
echo "$malware_percent malware" >> temp
echo "$ddos_percent ddos" >> temp
echo "$nuke_percent nuke" >> temp
result=`cat temp | sort | head -1 | cut -d ' ' -f 2`
rm temp

#print results
echo "$explore_percent|$honey_percent|$malware_percent|$ddos_percent|$nuke_percent|$result"
