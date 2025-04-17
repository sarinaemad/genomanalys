#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4  
#SBATCH -t 24:00:00  
#SBATCH -J spades_assembly
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o spades_output_%j.out
#SBATCH -e spades_%j.err

module load bioinfo-tools
module load spades/4.0.0

ILLUMINA_READ1="/home/saem4348/genomanalys/data/Illumina/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz"
ILLUMINA_READ2="/home/saem4348/genomanalys/data/Illumina/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz"
NANOPORE_READS="/home/saem4348/genomanalys/data/Nanopore/E745_all.fasta.gz"
OUTDIR="/home/saem4348/genomanalys/analyses/0_genome_assembly/spades_nanopore_illumina"

mkdir -p $OUTDIR

spades.py --careful \
  --pe1-1 $ILLUMINA_READ1 \
  --pe1-2 $ILLUMINA_READ2 \
  --nanopore $NANOPORE_READS \
  -o $OUTDIR



