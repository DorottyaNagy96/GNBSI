# GNBSI
Genomic analysis of gram negative isolates associated with bloodstream infections and positive CPE swabs, collected from across the UK in 2023-2024.

# Prepare Pilot analysis workflow 
Prepare workflow to compare hybrid, short and long read sequencing assemblies, to verifiy validity of using long-read only assemblies for main project.

This was tested on data from the preprint Landman et al., 2024 (https://www.medrxiv.org/content/10.1101/2024.02.18.24301916v1), which provided long/short-read sequences from 3 separate NCBI project accessions. The bash scripts and tsv/csv files in the 'sample_renaming' directory were used to rename and organise the downloaded .fastq.gz files into a format readily usable by downstream software, such as bactopia (bactopia prepare).

# Perform pilot analysis 
Compare quality of assemblies from hybrid (Unicycler), Long-read only with long read polishing (Flye-Medakax1), long-read only wiht short-read polishing, and short-read only (Shovill). 
