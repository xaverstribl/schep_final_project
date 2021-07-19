#!/bin/bash

function Filter {

	## variables
	local topDir=$(realpath ${1})
	local file
	local backup

	while read file; do
	
		#echo "cycle:" ${counter}
	
 		## go to the directory of the current file
 		cd $(dirname ${file})
		
		## start subshells
		(

		backup=$( sed "s/event/backup/" <(echo ${file}))
		cp ${file} ${backup} 
		awk '{if ($3 == 0) print $0}' < ${backup} 1>${file}
		) &
		
		## go back
 		cd -
 		
	done < <(find ${topDir} -type f -name "event_*.dat")
	
	## remove backup files again
	rm $(find ${topDir} -type f -name "backup_*.dat")
	
	wait
	return 0

} > output.log
