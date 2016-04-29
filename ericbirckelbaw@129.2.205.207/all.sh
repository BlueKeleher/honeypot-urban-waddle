#!/bin/bash
target=$1
target_num=`cat $target | wc -l`
i=1
while [ $i -le $target_num ]
do
	file=`cat $target | head -${i} | tail -1`
	file_commands=`cat $file | wc -l`
	if [ $file_commands -lt 4 ]
	then
		echo "$file" > lt4
		i=`expr $i + 1`
	else
		full_guess=`./catagorize.sh $file`
		./cutter.sh $file
		quarter_guess=`./catagorize.sh ${file}_25`
		echo "$file:$quarter_guess:$full_guess"
		i=`expr $i + 1`
	fi
done
