#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J prokka_annotation
#SBATCH -o prokka_%j.out
#SBATCH -e prokka_%j.err
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load prokka

prokka /home/saem4348/genomanalys/analyses/0_genome_assembly/canu_pacbio/pacbio_assembly.contigs.fasta \
  --outdir /home/saem4348/genomanalys/analyses/4_annotation/ \
  --prefix pacbio_annotation \
  --cpus 1 \
  --kingdom Bacteria \
  --genus Enterococcus \
  --species faecium \
  --force

