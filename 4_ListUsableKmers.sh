#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=50:00:00
#SBATCH --mail-user=araje002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH -o /bigdata/littlab/arajewski/kmerGWAS/history/ListUsableKmers-%A.out
set -eu

export PATH=/bigdata/littlab/arajewski/kmerGWAS/software/bin:$PATH
module load extra 
module load GCC/7.4.0-2.31.1

#Get a list of kmers matching our parameters
list_kmers_found_in_multiple_samples \
    -l /bigdata/littlab/arajewski/kmerGWAS/kmers_list_paths.txt \
    -k 31 \
    --mac 1 \
    -p 0.1 \
    -o kmers_to_use1

# Create the presence/absence table of kmers by individual
build_kmers_table \
    -l /bigdata/littlab/arajewski/kmerGWAS/kmers_list_paths.txt \
    -k 31 \
    -a kmers_to_use1 \
    -o kmers_table1
