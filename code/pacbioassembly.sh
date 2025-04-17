#!/bin/bash -l
#SBATCH -A uppmax2025-3-3        # Anger projektet du arbetar med
#SBATCH -M snowy                  # Anger klustret (kan ändras om du arbetar på ett annat kluster)
#SBATCH -p core                   # Anger vilken typ av partiton (core används för en vanlig partiton)
#SBATCH -n 4                       # Antal CPU:er
#SBATCH -t 06:00:00               # Maximerad körningstid (ändra om du behöver mer eller mindre tid)
#SBATCH -J genome_assembly_pacbio # Jobbnamn för att identifiera jobbet i Slurm
#SBATCH --mail-type=ALL           # Anger att du vill bli informerad via e-post vid olika tillfällen
#SBATCH --mail-user sarina.emad.4348@student.uu.se # Din e-postadress
#SBATCH --output=%x.%j.out        # Loggfilens namn (jobbnamn och jobbid)

# Ladda de nödvändiga modulerna
module load bioinfo-tools
module load canu

# Canu-kommandot för att köra genomassemblage
canu -p pacbio_assembly -d /home/saem4348/genomanalys/analyses/0_genome_assembly \
    genomeSize=3m \
    useGrid=False \
    -pacbio-raw /home/saem4348/genomanalys/data/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.1.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.1.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.2.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.2.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131023_233432_42174_c100519312550000001823081209281335_s1_X0.3.subreads.fastq.gz \
    /home/saem4348/genomanalys/data/m131024_200535_42174_c100563672550000001823084212221342_s1_p0.3.subreads.fastq.gz

