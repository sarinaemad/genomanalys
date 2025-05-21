#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J fastqc_trimmed_RNASeq
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o fastqc_trimmed_output_%j.out
#SBATCH -e fastqc_trimmed_error_%j.err

module load bioinfo-tools
module load FastQC

TRIMMED_DIR_SERUM="/home/saem4348/genomanalys/analyses/5_preprocessing_RNA/trimmed/serum"
TRIMMED_DIR_BH="/home/saem4348/genomanalys/analyses/5_preprocessing_RNA/trimmed/bh"
OUTDIR="/home/saem4348/genomanalys/analyses/5_preprocessing_RNA/fastqc_trimmed"

mkdir -p "$OUTDIR"

fastqc -t 4 -o "$OUTDIR" ${TRIMMED_DIR_SERUM}/*.fq.gz ${TRIMMED_DIR_BH}/*.fq.gz

