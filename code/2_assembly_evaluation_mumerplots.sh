#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J mummerplot_evaluation
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o mummerplot_output_%j.out
#SBATCH -e mummerplot_error_%j.err

module load bioinfo-tools
module load MUMmer/4.0.0rc1

REF="/home/saem4348/genomanalys/analyses/0_genome_assembly/canu_pacbio/pacbio_assembly.contigs.fasta"
QUERY="/home/saem4348/genomanalys/analyses/0_genome_assembly/spades_nanopore_illumina/contigs.fasta"

OUTDIR="/home/saem4348/genomanalys/analyses/2_assembly_evaluation/mummerplot_comparison"
mkdir -p $OUTDIR
cd $OUTDIR

nucmer --prefix=assembly_comparison $REF $QUERY

delta-filter -1 assembly_comparison.delta > assembly_comparison.filtered.delta

mummerplot --png --large --layout -p assembly_plot assembly_comparison.filtered.delta


