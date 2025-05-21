#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 06:00:00
#SBATCH -J trimmomatic_rnaseq
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sarina.emad.4348@student.uu.se
#SBATCH --output=%x_%j.out

module load bioinfo-tools
module load trimmomatic

ADAPTERS=/sw/bioinfo/trimmomatic/0.39/snowy/adapters/TruSeq3-PE.fa

RAW_BH=/home/saem4348/genomanalys/data/RNA_seq/RNA_seq_BH
RAW_SERUM=/home/saem4348/genomanalys/data/RNA_seq/RNA_seq_SERUM

OUT_BASE=/home/saem4348/genomanalys/analyses/5_preprocessing_RNA/trimmed
mkdir -p "$OUT_BASE/bh" "$OUT_BASE/serum"

run_trimmomatic () {
  SAMPLE=$1
  SOURCE=$2
  OUTDIR=$3

  fwd="${SOURCE}/trim_paired_ERR${SAMPLE}_pass_1.fastq.gz"
  rev="${SOURCE}/trim_paired_ERR${SAMPLE}_pass_2.fastq.gz"
  out_paired_fwd="${OUTDIR}/ERR${SAMPLE}_R1_paired.fq.gz"
  out_unpaired_fwd="${OUTDIR}/ERR${SAMPLE}_R1_unpaired.fq.gz"
  out_paired_rev="${OUTDIR}/ERR${SAMPLE}_R2_paired.fq.gz"
  out_unpaired_rev="${OUTDIR}/ERR${SAMPLE}_R2_unpaired.fq.gz"

  trimmomatic PE -threads 4 \
    "$fwd" "$rev" \
    "$out_paired_fwd" "$out_unpaired_fwd" \
    "$out_paired_rev" "$out_unpaired_rev" \
    ILLUMINACLIP:"$ADAPTERS":2:30:10 \
    LEADING:3 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:36
}

for sid in 1797972 1797973 1797974; do
  run_trimmomatic $sid "$RAW_BH" "$OUT_BASE/bh"
done

for sid in 1797969 1797970 1797971; do
  run_trimmomatic $sid "$RAW_SERUM" "$OUT_BASE/serum"
done

