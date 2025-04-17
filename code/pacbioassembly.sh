#!/bin/bash -l
#SBATCH -A uppmax2025-3-3                                        
#SBATCH -M snowy                  
#SBATCH -p core                  
#SBATCH -n 4                       
#SBATCH -t 06:00:00               
#SBATCH -J genome_assembly_pacbio 
#SBATCH --mail-type=ALL           
#SBATCH --mail-user sarina.emad.4348@student.uu.se 
#SBATCH --output=%x.%j.out        


module load bioinfo-tools
module load canu

canu -p pacbio_assembly -d /home/saem4348/genomanalys/analyses/0_genome_assembly \
    genomeSize=3m \
    useGrid=False \
    -pacbio-raw /home/saem4348/genomanalys/data/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.1.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.1.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.2.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.2.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.3.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.3.subreads.fastq.gz

