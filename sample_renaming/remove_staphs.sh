#!/bin/bash

# Directory containing directories with files to rename
parent_dir=$PWD

# Iterate over directories in the parent directory
for dir in "$parent_dir"/RIVM_M*; do
    if [ -d "$dir" ]; then  # Check if it's a directory
        rm -rf "$dir"
        echo $dir "removed"
    fi
done