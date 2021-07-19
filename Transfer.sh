#!/bin/bash

function Transfer {

	## variables
	local topDir=$(realpath ${1})
	local dir
	local file
	local currentDir=$(pwd)
	
	while read dir; do
		
		## start subshells
		(
		
		## go to directory
		cd ${dir}
		while read file; do
			
			## execute root stuff to create TTree			
			root -l -b -q ${currentDir}/importASCIIfileIntoTTree.C\(\"${file}\"\)
			
		done < <(find ${dir} -type f -name "event_*.dat")
		
		) &

	done < <(find ${topDir} -type d -name "[0-9]")
	
	wait
	## remove event files
	rm $(find ${topDir} -type f -name "event_*.dat")

	return 0

}
