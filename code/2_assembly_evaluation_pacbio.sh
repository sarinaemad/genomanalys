#!/bin/bash
#SBATCH -A uppmax2025-3-3  
#SBATCH -M snowy            
#SBATCH -p core             
#SBATCH -n 1                
#SBATCH -t 02:00:00         
#SBATCH -J asssembly_evaluation_pacbio_quast
#SBATCH --mail-user=sarina.emad.4348@student.uu.se  # Din e-post
#SBATCH --mail-type=ALL     
#SBATCH -o quast_output_%j.out  # Standard outputfil
#SBATCH -e quast_%j.err        # Feloutputfil

module load bioinfo-tools
module load quast

ASSEMBLY_FILE="/home/saem4348/genomanalys/analyses/0_genome_assembly/canu_pacbio/pacbio_assembly.contigs.fasta"
OUTPUT_DIR="/home/saem4348/genomanalys/analyses/2_assembly_evaluation/quast_evaluation_pacbio"

mkdir -p $OUTPUT_DIR

quast.py $ASSEMBLY_FILE -o $OUTPUT_DIR

