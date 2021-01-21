#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --nodes=1
#SBATCH --mem=7G
#SBATCH --time=2-00:00:00
#SBATCH --mail-user=araje002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH -p batch
#SBATCH -o history/Kinship-%A.out
set -eu

export PATH=/bigdata/littlab/arajewski/kmerGWAS/software/bin:$PATH
module load extra 
module load GCC/7.4.0-2.31.1

emma_kinship_kmers \
    -t kmers_table1 \
    -k 31 \
    --maf 0.05 > kmers_table1.kinship
