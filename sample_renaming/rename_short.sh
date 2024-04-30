#!/bin/bash

# Loop through directories starting with "RIVM"
for dir in RIVM*/; do
    # Check if the current item is a directory
    if [ -d "$dir" ]; then
        # Navigate into the directory
        cd "$dir" || exit

        # Loop through files in the directory
        for file in SRR*; do
            # Check if the current item is a file
            if [ -f "$file" ]; then
                # Add the prefix "rerio_" to the file name
                mv "$file" "short_$file"
            fi
        done

        # Return to the previous directory
        cd - || exit
    fi
done

