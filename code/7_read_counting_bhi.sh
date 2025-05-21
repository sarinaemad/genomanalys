#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J read_counting_Serum
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load htseq/2.0.2

GFF_FILE="/home/saem4348/genomanalys/analyses/4_annotation/pacbio_annotation.gff"

OUTPUT_DIR="/home/saem4348/genomanalys/analyses/7_read_counting/BHI"
mkdir -p "$OUTPUT_DIR"

for BAM in /home/saem4348/genomanalys/analyses/6_RNA_mapping/BHI/bam_files/*.bam; do
    BASENAME=$(basename "$BAM" _mapped.bam)
    htseq-count \
        --format=bam \
        --order=pos \
        --type=CDS \
        --idattr=locus_tag \
        --mode=union \
        --stranded=reverse \
        "$BAM" "$GFF_FILE" > "$OUTPUT_DIR/${BASENAME}_counts.txt"
done


