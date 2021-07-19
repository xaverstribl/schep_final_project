#!/bin/bash

[[ ! -d ${1} ]] && echo "Not a valid directory!" && return 1

source Splitter.sh ${1} && Splitter ${1} && echo "Done with Splitter.sh" || return 2
source Filter.sh ${1} && Filter ${1} && echo "Done with Filter.sh" || return 3
source Transfer.sh ${1} && Transfer ${1} && echo "Done with Transfer.sh" || return 4
source Analysis.sh ${1} && Analysis ${1} && echo "Done with Analysis.sh" || return 5

return 0
