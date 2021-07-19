#!/bin/bash

function Splitter {

	## variables
	local topDir=$(realpath ${1})
	local eventLines
	local lastLine
	local dir
	
	while read dir; do

		## start subshells
		(
		
		## get lines of events
		eventLines=($(echo $(grep -n BEGINNINGOFEVENT ${dir}/HIJING_LBF_test_small.out | awk 'BEGIN {FS=":"}{print $1}') | awk '{print $i}'))
		
		## get the last line of the file
		lastLine=$(wc -l ${dir}/HIJING_LBF_test_small.out | awk '{print $1}')
		
		## split into files
		sed -n ${eventLines[0]},${eventLines[1]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_0.dat
		sed -n ${eventLines[1]},${eventLines[2]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_1.dat
		sed -n ${eventLines[2]},${eventLines[3]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_2.dat
		sed -n ${eventLines[3]},${eventLines[4]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_3.dat
		sed -n ${eventLines[4]},${eventLines[5]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_4.dat
		sed -n ${eventLines[5]},${eventLines[6]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_5.dat
		sed -n ${eventLines[6]},${eventLines[7]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_6.dat
		sed -n ${eventLines[7]},${eventLines[8]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_7.dat
		sed -n ${eventLines[8]},${eventLines[9]}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_8.dat
		sed -n ${eventLines[9]},${lastLine}p ${dir}/HIJING_LBF_test_small.out > ${dir}/event_9.dat
		
		) &

	done < <(find ${topDir} -mindepth 1 -maxdepth 1 -type d)
	
	wait
	return 0

} >> output.log
