#!/bin/sh
#Assemble genomes using spades program
spades -t 6 -o ~/HW2/assembly/spades/ERR204044 -1 ~/HW2/outputs/trimmed/ERR204044_1_val_1.fq.gz -2 ~/HW2/outputs/trimmed/ERR204044_2_val_2.fq.gz 
spades -t 6 -o ~/HW2/assembly/spades/SRR15131330 -1 ~/HW2/outputs/trimmed/SRR15131330_1_val_1.fq.gz -2 ~/HW2/outputs/trimmed/SRR15131330_2_val_2.fq.gz 
spades -t 6 -o ~/HW2/assembly/spades/SRR18214264 -1 ~/HW2/outputs/trimmed/SRR18214264_1_val_1.fq.gz -2 ~/HW2/outputs/trimmed/SRR18214264_2_val_2.fq.gz
#Assemble the same genomes using velvet (did this step in Galaxy web)

#Evaluate assemblies using QUAST (did this step in Galaxy). Results:
#spades assemblies are much better aligned to the reference genome than velvet assemblies

#Orientating contigs using RagTag

#Spades assemblies
ragtag.py scaffold /home/bioinformatikai/HW2/refs/CP015498.fasta /home/bioinformatikai/HW2/assembly/spades/ERR204044/contigs.fasta -o /home/bioinformatikai/HW2/outputs/ragtag/ERR204044_spades -t 6 --aligner /home/bioinformatikai/minimap2/minimap2
ragtag.py scaffold /home/bioinformatikai/HW2/refs/CP015498.fasta /home/bioinformatikai/HW2/assembly/spades/SRR15131330/contigs.fasta -o /home/bioinformatikai/HW2/outputs/ragtag/SRR15131330_spades -t 6 --aligner /home/bioinformatikai/minimap2/minimap2
ragtag.py scaffold /home/bioinformatikai/HW2/refs/CP015498.fasta /home/bioinformatikai/HW2/assembly/spades/SRR18214264/contigs.fasta -o /home/bioinformatikai/HW2/outputs/ragtag/SRR18214264_spades -t 6 --aligner /home/bioinformatikai/minimap2/minimap2

#Velvet assemblies 
ragtag.py scaffold /home/bioinformatikai/HW2/refs/CP015498.fasta /home/bioinformatikai/HW2/assembly/velvet/ERR204044/velvetContigs.fasta -o /home/bioinformatikai/HW2/outputs/ragtag/ERR204044_velvet -t 6 --aligner /home/bioinformatikai/minimap2/minimap2
ragtag.py scaffold /home/bioinformatikai/HW2/refs/CP015498.fasta /home/bioinformatikai/HW2/assembly/velvet/SRR15131330/velvetContigs.fasta -o /home/bioinformatikai/HW2/outputs/ragtag/SRR15131330_velvet -t 6 --aligner /home/bioinformatikai/minimap2/minimap2
ragtag.py scaffold /home/bioinformatikai/HW2/refs/CP015498.fasta /home/bioinformatikai/HW2/assembly/velvet/SRR18214264/velvetContigs.fasta -o /home/bioinformatikai/HW2/outputs/ragtag/SRR18214264_velvet -t 6 --aligner /home/bioinformatikai/minimap2/minimap2

#Map original reads to assemblies (only spades)
bwa index ~/HW2/assembly/spades/ERR204044/contigs.fasta
bwa mem -t 6 ~/HW2/assembly/spades/ERR204044/contigs.fasta ~/HW2/outputs/trimmed/ERR204044_1_val_1.fq.gz ~/HW2/outputs/trimmed/ERR204044_2_val_2.fq.gz 2> ~/HW2/outputs/mapping/ERR204044_bwa.txt |\
samtools view -bS -@ 6 | samtools sort -@ 6 -o ~/HW2/outputs/mapping/ERR204044.bam
samtools stats -in ~/HW2/outputs/mapping/ERR204044.bam > ~/HW2/outputs/mapping/ERR204044_map_stats.txt

bwa index ~/HW2/assembly/spades/SRR15131330/contigs.fasta
bwa mem -t 6 ~/HW2/assembly/spades/SRR15131330/contigs.fasta ~/HW2/outputs/trimmed/SRR15131330_1_val_1.fq.gz ~/HW2/outputs/trimmed/SRR15131330_2_val_2.fq.gz 2> ~/HW2/outputs/mapping/SRR15131330_bwa.txt |\
samtools view -bS -@ 6 | samtools sort -@ 6 -o ~/HW2/outputs/mapping/SRR15131330.bam
samtools stats -in ~/HW2/outputs/mapping/SRR15131330.bam > ~/HW2/outputs/mapping/SRR15131330_map_stats.txt

bwa index ~/HW2/assembly/spades/SRR18214264/contigs.fasta
bwa mem -t 6 ~/HW2/assembly/spades/SRR18214264/contigs.fasta ~/HW2/outputs/trimmed/SRR18214264_1_val_1.fq.gz ~/HW2/outputs/trimmed/SRR18214264_2_val_2.fq.gz 2> ~/HW2/outputs/mapping/SRR18214264_bwa.txt |\
samtools view -bS -@ 6 | samtools sort -@ 6 -o ~/HW2/outputs/mapping/SRR18214264.bam
samtools stats -in ~/HW2/outputs/mapping/SRR18214264.bam > ~/HW2/outputs/mapping/SRR18214264_map_stats.txt

#Evaluate mapping fraction as well as genome coverage from mapped reads using data from *_map_stats.txt files

#ERR204044
#mapping fraction: 99.71%; genome coverage: 99.72%

#SRR15131330
#mapping fraction: 99.83%; genome coverage: 99.86%

#SRR18214264
#mapping fraction: 99.72%; genome coverage: 99.73%

#Based on the results a very large percentage of reads successfully aligned to the reference genomes;
#and the reference genomes are mostly covered by the mapped reads