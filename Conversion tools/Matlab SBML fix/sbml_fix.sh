#!/bin/bash
# (C) Andrei Kramer, andreikr@kth.se

# INTENDED PURPOSE:
# MATLAB has a toolbox called simbiology.
# simbiology creates sbml exports that look a bit weird
# it creates very long ids instead of using the species names it has
# this script replaces all ids with the names, everywhere
# The script also fixes the time variable

# DISCLAIMER: 
# the author does not fully understand many details of sbml
# he is trying his best

# This script will become entirely unnecessary when simbiology is fixed.

# NO WARRANTY of course

FILE=${1}

tags="model species parameter compartment reaction"

for tag in ${tags}; do

IFS=$'\n' lines=( `egrep "<$tag[ ]" ${FILE}` )
n=${#lines[@]}
for ((i=0;i<n;i++)); do
    svstr="${lines[i]}"
    # number of digits
    d=${#n}
    # write index i as 0001 etc. if necessary
    I=`printf "%0${d}i" $i`
    if [[ $svstr =~ id=\"([^\"]+)\" ]]; then
	id[i]="${BASH_REMATCH[1]}"
    else
	echo "warning: id not found in «${svstr}»"
    fi
    if [[ $svstr =~ name=\"([^\"]+)\" ]]; then
	name[i]="${BASH_REMATCH[1]//[ ]/}"
	# also strip all spaces from names
    else
	echo "warning: name not found in «${svstr}»"
	name[i]="${tag}_${I}"
    fi
    if [[ "${id[i]}" ]]; then
	sed -i -e "s/${id[i]}/${name[i]}/g" ${FILE}
    fi
done

# part of the sbml peculiarity is this:
# 
# according to the FAQ (http://sbml.org/Documents/FAQ#What_is_the_symbol_for_time_in_SBML.3F) 
# The _time_ variable is represented like this in sbml:      
#      <csymbol encoding="text" definitionURL="http://www.sbml.org/sbml/symbols/time"> 
#           t 
#      </csymbol> 
# where t can be any string, MATLAB's simbiology toolbox creates just this instead:
# <ci> time </ci>

sed -E -i -e 's|<ci>\s*time\s*</ci>|<csymbol encoding="text" definitionURL="http://www.sbml.org/sbml/symbols/time">time</csymbol>|g' ${FILE}


echo "id: ${id[*]}"
echo "name: ${name[*]}"
echo "done"

done
