#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J comparison_file
#SBATCH -o prokka_%j.out
#SBATCH -e prokka_%j.err
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load blast/2.15.0+

blastn -query /home/saem4348/genomanalys/analyses/0_genome_assembly/canu_pacbio/pacbio_assembly.contigs.fasta \
       -subject /home/saem4348/genomanalys/analyses/3_visualisation/GCF_003071425.1_ASM307142v1_genomic.fna \
       -outfmt 6 \
       -out /home/saem4348/genomanalys/analyses/3_visualisation/comparison_file.txt
