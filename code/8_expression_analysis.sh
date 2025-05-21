#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:00:00
#SBATCH -J DESeq2_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --output=DESeq2_analysis.%j.out
#SBATCH --error=DESeq2_analysis.%j.err

module load bioinfo-tools
module load R/4.0.0
module load R_packages/4.3.1

BHI_DIR="/home/saem4348/genomanalys/analyses/7_read_counting/BHI"
SERUM_DIR="/home/saem4348/genomanalys/analyses/7_read_counting/Serum"

cd /home/saem4348/genomanalys/code/

Rscript DESeq2_analysis.R $BHI_DIR $SERUM_DIR

