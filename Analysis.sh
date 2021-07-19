#!/bin/bash

function Analysis {

	## variables
	local topDir=$(realpath ${1})
	local dir
	local file

	{
	while read dir; do
		
		## start subshells
		(
		
		while read file; do
		
			## execute roor stuff to get data from TTree
			root -l readDataFromTTree.C\(\"${file}\"\)
		
		done < <(find ${dir} -type f -name "HIJING_LBF_test_small.root")
		
		)
		
	done < <(find ${topDir} -mindepth 1 -maxdepth 1 -type d)

	wait

	root -l -b -q fileMerger.C\(\"${topDir}\"\)
	} >> output.log
	
	root -l -b -q Final.C

	return 0

}
