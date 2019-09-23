#!/bin/bash
l1=`find / -name Very_High_CPU_Usage.csv -type f -mmin +60`
l2=`find / -name High_CPU_Usage.csv -type f -mmin +60`
if [ l1 ]
then
	`cat Very_High_CPU_Usage.csv >> Very_High_CPU_Usage.csv_bkup`
fi

if [ l2 ]
then
	`cat High_CPU_Usage.csv >> High_CPU_Usage.csv-bkup`
fi

`find / -name Very_High_CPU_Usage.csv -type f -mmin +60 -delete`
`find / -name High_CPU_Usage.csv -type f -mmin +60 -delete`

