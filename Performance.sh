#!/bin/bash

#These data are mainly used for the logging into the files
echo "User Entered T value- seconds after which the loadaverage needs to be logged: $1"
echo "User Entered TP value- total time for which the record needs to be generated: $2"
echo "User Defined Threshold - 1min Load Averages: $3"
echo "User Defined Threshold - 5min Load Averages: $4"
echo "User Entered T value- seconds after which the loadaverage needs to be logged: $1" >> CPU_USAGE.csv
echo "User Entered TP value- total time for which the record needs to be generated: $2" >> CPU_USAGE.csv
echo "User Entered T value- seconds after which the loadaverage needs to be logged: $1" >> High_CPU_Usage.csv
echo "User Entered TP value- total time for which the record needs to be generated: $2" >> High_CPU_Usage.csv
echo "User Entered T value- seconds after which the loadaverage needs to be logged: $1" >> Very_High_CPU_Usage.csv
echo "User Entered TP value- total time for which the record needs to be generated: $2" >> Very_High_CPU_Usage.csv
echo "User Defined Threshold - 1min Load Averages: $3" >> CPU_USAGE.csv
echo "User Defined Threshold - 5min Load Averages: $4" >> CPU_USAGE.csv
echo "User Defined Threshold - 1min Load Averages: $3" >> High_CPU_Usage.csv
echo "User Defined Threshold - 5min Load Averages: $4" >> Very_High_CPU_Usage.csv
echo "CPU LOAD AVERAGES FILE" >> CPU_USAGE.csv
echo "======================" >> CPU_USAGE.csv


TP=$2
T=$1
i=0
Threshold=$3
HighThreshold=$4

echo "TimeStamp    1-Min  5-Min  15-Min" >> CPU_USAGE.csv
echo "---------------------------------" >> CPU_USAGE.csv
echo "TimeStamp  Alert-String                 1-Min  5-Min  15-Min" >> Very_High_CPU_Usage.csv
echo "------------------------------------------------------------" >> Very_High_CPU_Usage.csv
echo "TimeStamp  Alert-String     1-Min  5-Min  15-Min" >> High_CPU_Usage.csv
echo "------------------------------------------------" >> High_CPU_Usage.csv

while [ $i -le $TP ]
do	
	sleep $T
	l1=`uptime | awk '{print $10}' | cut -d"," -f1`
	l2=`uptime | awk '{print $11}' | cut -d"," -f1`
	l3=`uptime | awk '{print $12}' | cut -d"," -f1`
	t1=`uptime | awk '{print $1}'  | cut -d"," -f1`
#	temp=echo $l1'>'$UDThreshold | bc -l
#	echo $temp
	
	# If the CPU usage in
	#		echo "$t1   Very High CPU Usage          $l1  $l2  $l3" >> Very_High_CPU_Usage.csv
	#	fi
	#	 last one min is greater than the user defined usage then logging into the High_CPU_Usage.csv
	if [ `echo "$l1 > $Threshold" | bc` -eq 1 ] 
	then
		echo "$t1  High CPU Usage   $l1   $l2   $l3" >> High_CPU_Usage.csv
	fi
	
	#If the CPU usage in five min is greater than the user defined usage then logging into the Very_High_CPU_Usage.csv
	if [ `echo "($l2 > $HighThreshold) && ($l1 > $Threshold)" | bc` -eq 1 ]
	then
	echo "$t1,     $l1,  $l2,  $l3" >> CPU_USAGE.csv
	i=`expr $i + $T`	
done
