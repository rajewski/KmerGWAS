#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=7G
#SBATCH --time=10:00:00
#SBATCH -p batch
#SBATCH --mail-user=araje002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH -o history/GWAS-%A.out
set -eu

export PATH=/bigdata/littlab/arajewski/kmerGWAS/software:/bigdata/littlab/arajewski/kmerGWAS/software/bin:$PATH
module load extra
module load GCC/7.4.0-2.31.1

kmers_gwas.py \
    --pheno phenotypes.pheno \
    --kmers_table kmers_table1 \
    --permutations 25 \
    -l 31 \
    --maf 0.05 \
    --mac 1 \
    -k 100000 \
    --min_data_points 1 \
    -p $SLURM_CPUS_PER_TASK \
    --outdir output_dir
