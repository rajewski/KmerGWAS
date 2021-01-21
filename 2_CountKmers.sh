#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --nodes=1
#SBATCH --mem=70G
#SBATCH --time=02:00:00
#SBATCH --mail-user=araje002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH -p short
#SBATCH -o history/KMC-%A_%a.out
set -eu

# Run this as an array job with the index corresponding to the individual
# For Manzanita Data
# Low read depth samples removed
Indiv=(1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 4 40 41 42 42683 42813 43 44 45 46 47 48 49 5 50 51 52 53 54 56 57 58 6 60 61 63 64 65 66 67 68 69 70 71 72 73 77 78 79 8 80 87 88 89 9 90 91 92 93 94 95 96 A1 A2 A3 A4 A5 A7 A8 A9 B1 B2 B3 B8 B9 C1 C3 C4 C5 C6 C8 C9 D2 D3 D4 D5 F1 F3 F4 F5 F6 F8 F9 G2 G3 G7 G9 H1 H2 I3 I5 I7 I9 J2 Julian4 L1 L2 L3 L5 L6 L7 L8 L9 MC4 N2 N3 N4 N8 O6 PF7 )
cd Manzanita/${Indiv[$SLURM_ARRAY_TASK_ID]}
# For People Data
#Indiv=( HG00407 HG00419 HG00422 HG00428 HG00437 HG00443 HG00446 HG00452 HG00458 HG00473 HG00476 HG00479 HG00525 HG00543 HG00557 NA18526 NA18532 NA18542 NA18545 NA18547 NA18550 NA18552 NA18555 NA18564 NA18566 NA18570 NA18571 NA18573 NA18576 NA18577 NA18579 NA18582 NA18592 NA18593 NA18595 NA18596 NA18597 NA18599 NA18610 )
#cd People/${Indiv[$SLURM_ARRAY_TASK_ID]}
# For Dog Data
#Indiv=( MB140Normal MB140Tumor MB2A11Normal MB2A11Tumor MB2C13Normal MB2C13Tumor NEWMETNormal NEWMETTumor SHAKITNormal SHAKITTumor )
#cd Dogs/${Indiv[$SLURM_ARRAY_TASK_ID]}

module load KMC/3.1.1
# Count canonical kmers occuring more than thrice
if [ ! -e output_kmc_canon.kmc_suf ]; then
# Make a list of fastq files
realpath *.gz > input_files.txt
echo Count cannonical kmers for ${Indiv[$SLURM_ARRAY_TASK_ID]}
kmc \
    -k31 \
    -v \
    -m$((SLURM_MEM_PER_NODE/1024)) \
    -t$SLURM_CPUS_PER_TASK \
    @input_files.txt \
    output_kmc_canon \
    ./ \
echo Done.
fi

# Count all kmers
if [ ! -e output_kmc_all.kmc_suf ]; then
echo Counting non-cannonical kmers for ${Indiv[$SLURM_ARRAY_TASK_ID]}
kmc \
    -t$SLURM_CPUS_PER_TASK \
    -k31 \
    -ci0 \
    -b \
    -v \
    @input_files.txt \
    output_kmc_all \
    ./ 
echo Done.
fi
