#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_illumina
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o fastqc_output_%j.out
#SBATCH -e fastqc_error_%j.err

module load bioinfo-tools
module load FastQC

READ1="/home/saem4348/genomanalys/data/Illumina/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz"
READ2="/home/saem4348/genomanalys/data/Illumina/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz"


OUTDIR="/home/saem4348/genomanalys/analyses/1_preprocessing"

mkdir -p $OUTDIR

fastqc -t 2 -o $OUTDIR $READ1 $READ2

#
