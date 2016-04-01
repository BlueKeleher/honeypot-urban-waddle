#!/bin/bash
potato() {
cat network_usage | grep '$1 recieved:' | cut -d ' ' -f 3 | sort -n | tr -d " \t\r" | sed '/^\s*$/d' > `$1`_r
awk 'BEGIN {FS=OFS=","} {for (i=1; i<=NF; i++) $i/=10;}1' `$1`_r > `$1`_r1
r2=`$1`_r1
R=`expr $(perl -nle '$sum += $_ } END { print $sum' $r2) / $(cat $r2 | wc -l)`
echo "$1 recieved: $R"
cat network_usage | grep '$1 recieved:' | cut -d ' ' -f 3 | sort -n | tr -d " \t\r" | sed '/^\s*$/d' > `$1`_s
awk 'BEGIN {FS=OFS=","} {for (i=1; i<=NF; i++) $i/=10;}1' `$1`_s > `$1`_s1
s2=`$1`_s1
S=`expr $(perl -nle '$sum += $_ } END { print $sum' $r2) / $(cat $r2 | wc -l)`
echo "$1 sent: $S"
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
