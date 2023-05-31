#!/bin/sh

#FASTQC analysis on each FASTQ file
fastqc -t 6 ~/HW2/inputs/ERR204044_1.fastq.gz ~/HW2/inputs/ERR204044_2.fastq.gz -o ~/HW2/outputs
fastqc -t 6 ~/HW2/inputs/SRR15131330_1.fastq.gz ~/HW2/inputs/SRR15131330_2.fastq.gz -o ~/HW2/outputs
fastqc -t 6 ~/HW2/inputs/SRR18214264_1.fastq.gz ~/HW2/inputs/SRR18214264_2.fastq.gz -o ~/HW2/outputs

#Trim sequences
trim_galore -j 6 --paired --length 20 --quality 20 --illumina -o ~/HW2/outputs/trimmed/ ~/HW2/inputs/ERR204044_1.fastq.gz ~/HW2/inputs/ERR204044_2.fastq.gz
trim_galore -j 6 --paired --length 20 --quality 20 --illumina -o ~/HW2/outputs/trimmed/ ~/HW2/inputs/SRR18214264_1.fastq.gz ~/HW2/inputs/SRR18214264_2.fastq.gz
trim_galore -j 6 --paired --length 20 --quality 20 --illumina -o ~/HW2/outputs/trimmed/ ~/HW2/inputs/SRR15131330_1.fastq.gz ~/HW2/inputs/SRR15131330_2.fastq.gz
 #-----------
#FASTQC analysis on each trimmed FASTQ file
fastqc -t 6 ~/HW2/outputs/trimmed/ERR204044_1_val_1.fq.gz ~/HW2/outputs/trimmed/ERR204044_2_val_2.fq.gz -o ~/HW2/outputs
fastqc -t 6 ~/HW2/outputs/trimmed/SRR18214264_1_val_1.fq.gz ~/HW2/outputs/trimmed/SRR18214264_2_val_2.fq.gz -o ~/HW2/outputs
fastqc -t 6 ~/HW2/outputs/trimmed/SRR15131330_1_val_1.fq.gz ~/HW2/outputs/trimmed/SRR15131330_2_val_2.fq.gz -o ~/HW2/outputs

#trimmed sequences generally have a different sequence length distribution and per base sequence coverage levels
#that are being marked by the fastqc tool

#Create multiQC plots for raw and processed data
multiqc ~/HW2/outputs -o ~/HW2/outputs