#!/bin/bash -l
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=02:00:00
#SBATCH -p short
#SBATCH --mail-user=araje002@ucr.edu
#SBATCH --mail-type=all
#SBATCH -o history/Downsample-%A.out

# Set up the right env for multithreaded trimming
module load BBMap

# Use the array id to parallelie this
Indiv=(1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 4 40 41 42 42683 42813 43 44 45 46 47 48 49 5 50 51 52 53 54 55 56 57 58 59 6 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 77 78 79 8 80 87 88 89 9 90 91 92 93 94 95 96 A1 A2 A3 A4 A5 A6 A7 A8 A9 B1 B2 B3 B6 B8 B9 C1 C2 C3 C4 C5 C6 C8 C9 D1 D2 D3 D4 D5 F1 F2 F3 F4 F5 F6 F8 F9 G1 G2 G3 G4 G7 G8 G9 H1 H2 I3 I4 I5 I6 I7 I9 J2 Julian4 L1 L2 L3 L4 L5 L6 L7 L8 L9 MC4 N2 N3 N4 N5 N6 N8 O6 PF7 )
cd Manzanita/${Indiv[$SLURM_ARRAY_TASK_ID]}

reformat.sh \
    in1=${Indiv[$SLURM_ARRAY_TASK_ID]}_1.fq.gz \
    in2=${Indiv[$SLURM_ARRAY_TASK_ID]}_2.fq.gz \
    samplereadstarget=2000000 \
    out1=${Indiv[$SLURM_ARRAY_TASK_ID]}_1_subsample.fq.gz \
    out2=${Indiv[$SLURM_ARRAY_TASK_ID]}_2_subsample.fq.gz
