# Genome analysis project

In this file, the pipeline and file organisation are written for the project based on paper 1 in the course Genome Analysis.

## Organisation
I created directories for the organisation of my files. I created three directories in my genome analysis folder named "analyses", "code" and "data". In the analyses folder I saved all outputs for each analysis that I got from each tool in subfolder for each step: genome assembly, preprocessing, assembly evaluatiion, visualisation, annotation, RNA preprocessing, RNA mapping, read counting and differential expression. In the code folder I saved all batches with code that I wrote for each analysis. In the data folder, I saved all the data I had including the reads from PacBio, Nanopore and Illumina as well as the reference genome downloaded from NIH.

## Pipeline:

### 1. Soft links to data:

To begin with I created soft links to the sequencing data which I saved in the data folder. The soft links were created with following commands:

Illumina data
ln -s /proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/* /home/saem4348/genomanalys/data/

Nanopore data
ln -s /proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/Nanopore/* /home/saem4348/genomanalys/data/

PacBio data
ln -s /proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/* /home/saem4348/genomanalys/data/

RNA-Seq BH data
ln -s /proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_BH/* /home/saem4348/genomanalys/data/

RNA-Seq Serum data
ln -s /proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_Serum/* /home/saem4348/genomanalys/data/

### 2. Genome assembly Canu : 

I then created a genome assembly with the PacBio sequences using Canu. The code for this is saved in the batch called 0_pacbioassembly.sh.

### 3. Quality check Illumina reads: 

Before creating a genome assembly using the Illumina reads I did a quality check with FastQC on them. The code for this is in the code folder in a batch called 1_fastqc_illumina.sh. All metrics were approved, therefore no preprocessing was needed.

### 4. Genome assembly Spades:

Now I created a genome assembly with Spades using the Nanopore and Illumina reads. The code for this is in the batch 0_nanopore_illumina_assembly.sh in the code folder.

### 5. Assembly evaluation Quast:

I did a assembly evaluation of the PacBio assembly with Quast. The code is saved in batch 2_assembly_evaluation_pacbio.sh in the code folder.

### 6. Assembly evaluation MUMmerplot:

I did another assembly evaluation of the two assemblies I had created with the tool MUMmerplot. The batch with this code is saved in 2_assembly_evaluation_mumerplots.sh in the code folder. 

### 7. Download closely related genome

From NCBI a closely related genome was downloaded. The link to NCBI is https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/864/255/GCF_016864255.1_ASM1686425v1/ and the downloaded file is called GCF_016864255.1_ASM1686425v1_genomic.fna.gz. 

### 8. Comparison file with BLASTn and synteny comparison with ACT

With BLASTn a comparison file was created for the downloaded genome and my genome assembly. The code batch is called 3_blast.sh and is in the code folder. Then ACT was started with these commands: 

module load bioinfo-tools 
module load artemis/16.0.0
act

Then the genome assembly, comparison file and reference genome were provided in order to visualize the synteny. 

### 9. Annotation Prokka

Next step is the annotation with Prokka which was done with the code in the batch named 4_prokka_annotation in the code folder.

### 10. Quality check and pre-processing RNA reads

Before the RNA-mapping, the quality of then RNA sequences from Illumina were checked with the code written in batch 5_fastqc_illumina_RNA_bhi.sh and 5_fastqc_illumina_RNA_serum.sh. The metrics from the FastQC report were not all approved, thefore trimming was done according to the code in the batch 5_trimming.sh. However, quality was not improved and I continued the process with the original RNA reads.

### 11. RNA-mapping

RNA-mapping of the sequences to the genome assembly was done by using the code in 6_rna_mapping_bhi.sh and 6_rna_mapping_serum.sh in the code folder. 

### 12. Read counting 

To count how many reads were mapped to each gene, I did a read counting with the code in 7_read_counting_bhi.sh and 7_read_counting_serum.sh.

### 13. Differential expression

For the differential expression, two codes are needed a batch and a R code file. The R code can be found in the code folder and is called DESeq2_analysis.R. The batch is called  8_expression_analysis.sh. 



