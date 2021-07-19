#!/bin/bash

function Filter {

	## variables
	local topDir=$(realpath ${1})
	local file
	local backup
	#local counter
	#local cpus=$(nproc)

	while read file; do
	
		#echo "cycle:" ${counter}
	
 		## go to the directory of the current file
 		cd $(dirname ${file})

		## check usage of cpus
		#[[ ${counter} -lt ${cpus} ]] || wait && counter=0 && echo "max cpu reached"
		
		## start subshells
		(
		#echo "Subshell PID: ${BASHPID}"
		backup=$( sed "s/event/backup/" <(echo ${file}))
		cp ${file} ${backup} 
		awk '{if ($3 == 0) print $0}' < ${backup} 1>${file}
		) &
		
		## go back
 		cd -

		## increase counter
		#(( counter++ ))
 		
	done < <(find ${topDir} -type f -name "event_*.dat")
	
	## remove backup files again
	rm $(find ${topDir} -type f -name "backup_*.dat")
	
	wait
	return 0

}
