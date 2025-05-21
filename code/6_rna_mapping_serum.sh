#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J rna_mapping_serum
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o /home/saem4348/genomanalys/analyses/6_RNA_mapping/serum/%x_%j.out
#SBATCH -e /home/saem4348/genomanalys/analyses/6_RNA_mapping/serum/%x_%j.err

set -euo pipefail

module load bioinfo-tools
module load bwa
module load samtools
module load gzip

RNA_DIR="/home/saem4348/genomanalys/data/RNA_seq/RNA_seq_SERUM"
REF="/home/saem4348/genomanalys/analyses/0_genome_assembly/canu_pacbio/pacbio_assembly.contigs.fasta"
OUT_DIR="/home/saem4348/genomanalys/analyses/6_RNA_mapping/serum"
BAM_DIR="$OUT_DIR/bam_files"

mkdir -p "$BAM_DIR"

if [ ! -e "$REF.bwt" ]; then
    echo "Indexing reference genome..."
    bwa index "$REF"
fi

for R1 in "$RNA_DIR"/trim_paired_*_pass_1.fastq.gz; do
    R2=${R1/_pass_1.fastq.gz/_pass_2.fastq.gz}
    SAMPLE=$(basename "$R1" | sed 's/trim_paired_\(.*\)_pass_1.fastq.gz/\1/')

    echo "Aligning $SAMPLE..."

    TMP_SORTED_BAM="$SNIC_TMP/${SAMPLE}.sorted.bam"

    bwa mem -t 4 "$REF" "$R1" "$R2" | \
        samtools view -bS - | \
        samtools sort -o "$TMP_SORTED_BAM"

    samtools index "$TMP_SORTED_BAM"

    mv "$TMP_SORTED_BAM" "$BAM_DIR/${SAMPLE}.sorted.bam"
    mv "$TMP_SORTED_BAM.bai" "$BAM_DIR/${SAMPLE}.sorted.bam.bai"
done

