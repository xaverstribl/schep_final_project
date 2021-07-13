#!/bin/bash

function Splitter {

	## check that given argument is a existing directory
	[[ $# -eq 1 ]] || { echo "Error: wrong number of arguments"; return 1; }
	[[ -d ${1} ]] || { echo "Error: given directory does not exist"; return 2; }
	
	## split into seperate files
	## 1
	(
	cd ${1}
	cd ./0/
	
	for i in 0 1 2 3 4 5 6 7 8 9; do
		lines=($(echo $(grep -n BEGINNINGOFEVENT HIJING_LBF_test_small.out | awk 'BEGIN {FS=":"}{print $1}') | awk '{print $i}'))
	done
	
	local last_line=$(wc -l HIJING_LBF_test_small.out | awk '{print $1}')
	
	sed -n ${lines[0]},${lines[1]}p HIJING_LBF_test_small.out > event_0.dat
	sed -n ${lines[1]},${lines[2]}p HIJING_LBF_test_small.out > event_1.dat
	sed -n ${lines[2]},${lines[3]}p HIJING_LBF_test_small.out > event_2.dat
	sed -n ${lines[3]},${lines[4]}p HIJING_LBF_test_small.out > event_3.dat
	sed -n ${lines[4]},${lines[5]}p HIJING_LBF_test_small.out > event_4.dat
	sed -n ${lines[5]},${lines[6]}p HIJING_LBF_test_small.out > event_5.dat
	sed -n ${lines[6]},${lines[7]}p HIJING_LBF_test_small.out > event_6.dat
	sed -n ${lines[7]},${lines[8]}p HIJING_LBF_test_small.out > event_7.dat
	sed -n ${lines[8]},${lines[9]}p HIJING_LBF_test_small.out > event_8.dat
	sed -n ${lines[9]},${last_line}p HIJING_LBF_test_small.out > event_9.dat
	)
	
}
