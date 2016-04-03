#!/bin/bash
float(){
printf "%.0f\n" "$@"
}
potato() {
cat network_usage | grep "$1 recieved:" | cut -d ' ' -f 3 | sort -n | tr -d " \t\r" | sed '/^\s*$/d' > $1"_r"
awk 'BEGIN {FS=OFS=","} {for (i=1; i<=NF; i++) $i/=10;}1' $1"_r" > $1"_r1"
r2=$1"_r1"
R1=$(float `perl -nle '$sum += $_ } END { print $sum' $r2`)
R2=$(cat $r2 | wc -l)
if [ $R2 -ne 0 ]
then
	R=`expr $R1 / $R2`
else
	R="No Flow"
fi
echo "$1 recieved: $R"
rm $r2 && rm $1"_r"
cat network_usage | grep "$1 sent:" | cut -d ' ' -f 3 | sort -n | tr -d " \t\r" | sed '/^\s*$/d' > $1"_s"
awk 'BEGIN {FS=OFS=","} {for (i=1; i<=NF; i++) $i/=10;}1' $1"_s" > $1"_s1"
s2=$1"_s1"
S1=$(float `perl -nle '$sum += $_ } END { print $sum' $s2`)
S2=$(cat $s2 | wc -l)
if [ $S2 -ne 0 ]
then
	S=`expr $S1 / $S2`
else
	S="No Flow"
fi
echo "$1 sent: $S"
rm $s2 && rm $1"_s" 
}
potato br0
potato eth0
potato eth1
potato eth2
potato lo
potato venet0
potato veth101.0
potato veth102.0
potato veth103.0
