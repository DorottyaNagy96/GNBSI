#!/bin/bash

while IFS=$'\t' read -r -a fields; do
    # Loop through each field in the line
    for ((i=0; i<${#fields[@]}; i++)); do
        # Remove surrounding double quotes from the field
        fields[$i]=$(echo "${fields[$i]}" | sed 's/^"\(.*\)"$/\1/')
    done

  # Print the line with double quotes removed
    echo "${fields[*]}"

  if [ "${#fields[@]}" -ge 10 ]; then
        # Move the file with the name corresponding to the value of the first column into the directory with the name corresponding to the value of the second column
        mv longread/*${fields[9]}* *${fields[0]}*
    fi
done < SRR_SAMN_accessions_match.tsv 

