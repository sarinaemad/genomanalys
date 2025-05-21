#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_RNASeq_SERUM
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o fastqc_output_%j.out
#SBATCH -e fastqc_error_%j.err

module load bioinfo-tools
module load FastQC

READ_DIR="/home/saem4348/genomanalys/data/RNA_seq/RNA_seq_SERUM"

OUTDIR="/home/saem4348/genomanalys/analyses/5_preprocessing_RNA/fastQC_serum"

mkdir -p $OUTDIR

fastqc -t 2 -o $OUTDIR ${READ_DIR}/trim_paired_ERR1797969_R1.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797970_R1.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797971_R1.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797969_R2.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797970_R2.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797971_R2.fastq.gz

