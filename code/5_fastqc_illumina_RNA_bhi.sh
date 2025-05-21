#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_RNASeq_BH
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o fastqc_output_%j.out
#SBATCH -e fastqc_error_%j.err

module load bioinfo-tools
module load FastQC

READ_DIR="/home/saem4348/genomanalys/data/RNA_seq/RNA_seq_BH"

OUTDIR="/home/saem4348/genomanalys/analyses/5_preprocessing_RNA"

mkdir -p $OUTDIR

fastqc -t 2 -o $OUTDIR ${READ_DIR}/trim_paired_ERR1797972_pass_1.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797973_pass_1.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797974_pass_1.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797972_pass_2.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797973_pass_2.fastq.gz \
  ${READ_DIR}/trim_paired_ERR1797974_pass_2.fastq.gz

