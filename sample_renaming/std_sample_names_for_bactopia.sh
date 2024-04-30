#!/bin/bash

# Iterate over directories in the parent directory
for dir in /well/bag/users/nch313/flye_medaka_workflow/test_data/RIVM_*; do
    if [ -d "$dir" ]; then  # Check if it's a directory
        sample_name="${dir##*/}"  # Extract sample_name from directory name
        echo $sample_name
        # Rename files beginning with rerio_
        mv "$dir"/rerio_* "$dir/$sample_name.fastq.gz"
        mv "$dir"/short_*1.fastq.gz "$dir/${sample_name}_R1.fastq.gz"
        mv "$dir"/short_*2.fastq.gz "$dir/${sample_name}_R2.fastq.gz"
    fi
done
