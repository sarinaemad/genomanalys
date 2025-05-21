#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J rna_mapping
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --mail-type=ALL
#SBATCH -o /home/saem4348/genomanalys/analyses/6_RNA_mapping/BHI/%x_%j.out
#SBATCH -e /home/saem4348/genomanalys/analyses/6_RNA_mapping/BHI/%x_%j.err

set -euo pipefail

module load bioinfo-tools
module load bwa
module load samtools
module load gzip

RNA_DIR="/home/saem4348/genomanalys/data/RNA_seq/RNA_seq_BH"
REF="/home/saem4348/genomanalys/analyses/0_genome_assembly/canu_pacbio/pacbio_assembly.contigs.fasta"
OUT_DIR="/home/saem4348/genomanalys/analyses/6_RNA_mapping/BHI"

if [ ! -e "$REF.bwt" ]; then
    echo "Indexerar referensgenomet..."
    bwa index "$REF"
fi

mkdir -p "$OUT_DIR"/sam_files
mkdir -p "$OUT_DIR"/bam_files

for R1 in "$RNA_DIR"/trim_paired_*_pass_1.fastq.gz; do
    R2=${R1/_pass_1.fastq.gz/_pass_2.fastq.gz}
    
    SAMPLE=$(basename "$R1" | sed 's/trim_paired_\(.*\)_pass_1.fastq.gz/\1/')
    
    echo "Alignar $SAMPLE..."

    bwa mem -t 4 "$REF" "$R1" "$R2" > "$OUT_DIR"/sam_files/"$SAMPLE.sam"

    samtools view -bS "$OUT_DIR"/sam_files/"$SAMPLE.sam" > "$OUT_DIR"/bam_files/"$SAMPLE.bam"
    samtools sort "$OUT_DIR"/bam_files/"$SAMPLE.bam" -o "$OUT_DIR"/bam_files/"$SAMPLE.sorted.bam"
    samtools index "$OUT_DIR"/bam_files/"$SAMPLE.sorted.bam"

    rm "$OUT_DIR"/sam_files/"$SAMPLE.sam"
done

