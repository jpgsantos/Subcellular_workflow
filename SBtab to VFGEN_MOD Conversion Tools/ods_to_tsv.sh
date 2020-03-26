#!/bin/bash

if [[ `which ssconvert` ]]; then
    if (($#>0)); then
	Name=${1%%.*}
	Name=${Name##*/}
	echo "Model name: «${Name}»"
	LC_ALL="C" ssconvert -S --export-options="quoting-mode=never separator='	' locale=C" ${1} "${Name}_%s.txt"
	for i in ${Name}_*.txt; do
	    mv "${i}" "${i%%txt}tsv";
	done    
    fi
else
    echo "gnumeric's «ssconvert» not found"
fi
