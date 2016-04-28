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
explore_percent=`echo "scale=2; $explore_total / $weight_total" | bc`
honey_percent=`echo "scale=2; $honey_total / $weight_total" | bc`
malware_percent=`echo "scale=2; $malware_total / $weight_total" | bc`
ddos_percent=`echo "scale=2; $ddos_total / $weight_total"  | bc`
nuke_percent=`echo "scale=2; $nuke_total / $weight_total" | bc`

#calculate which is highest
echo "$explore_percent explore" >> temp
echo "$honey_percent honey" >> temp
echo "$malware_percent malware" >> temp
echo "$ddos_percent ddos" >> temp
echo "$nuke_percent nuke" >> temp
result1=`cat temp | sort | tail -1 | cut -d ' ' -f 2`
result2=`cat temp | sort | tail -2 | head -1 | cut -d ' ' -f 2`
result3=`cat temp | sort | tail -3 | head -1 | cut -d ' ' -f 2`
result4=`cat temp | sort | tail -4 | head -1 | cut -d ' ' -f 2`
result5=`cat temp | sort | head -1 | cut -d ' ' -f 2`

#check for a tie
tie="no tie"
result1_value=`cat temp | sort | tail -1 | cut -d ' ' -f 1`
result2_value=`cat temp | sort | tail -2 | head -1 | cut -d ' ' -f 1`
result3_value=`cat temp | sort | tail -3 | head -1 | cut -d ' ' -f 1`
result4_value=`cat temp | sort | tail -4 | head -1 | cut -d ' ' -f 1`
result5_value=`cat temp | sort | head -1 | cut -d ' ' -f 1`
if [ "$result1_value" = $result2_value ] && [ "$result1_value" != "$result3_value" ]
then
	tie="$result1,$result2"
fi
if [ "$result1_value" = $result2_value ] && [ "$result1_value" = $result3_value ] && [ "$result1_value" != "$result4_value" ]
then
        tie="$result1,$result2,$result3"
fi
if [ "$result1_value" = $result2_value ] && [ "$result1_value" = $result3_value ] && [ "$result1_value" = $result4_value ] && [ "$result1_value" != "$result5_value" ]
then
        tie="$result1,$result2,$result3,$result4"
fi
if [ "$result1_value" = $result2_value ] && [ "$result1_value" = $result3_value ] && [ "$result1_value" = $result4_value ] && [ "$result1_value" = $result5_value ]
then
        tie="$result1,$result2,$result3,$result4,$result5"
fi

#print results
if [ "$tie" = "no tie" ]
then
	echo "$explore_percent|$honey_percent|$malware_percent|$ddos_percent|$nuke_percent|$result1"
else
	echo "$explore_percent|$honey_percent|$malware_percent|$ddos_percent|$nuke_percent|$tie"
fi

#remove temporary file
rm temp
