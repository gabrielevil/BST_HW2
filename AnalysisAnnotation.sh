#!/bin/sh
#Using Gepard tool create dotplots to show similarities/dissimilarities between your samples. Describe, your results (in your code).
#Based on Gepard dotplots the most similar samples are ERR204044 and SRR15131330.
#Overall all of the sequences are very similar to each other and they all display chaotic sequence ends which indicate duplicates.

#Using BUSCO analysis tool, evaluate your assemblies. Provide a short comment on BUSCO results.
#ERR204044 assembly has a high (99%) level of completeness, 
#SRR15131330 assembly has 98.5% level completeness,
#SRR18214264 assembly has 99% level completeness.
#Overall the results show that these assemblies have high levels of completeness
#with 98.0%< of the conserved genes being found as complete and single-copy BUSCOs

#Using GeneMarkS-2 tool predict genes in your assembled genomes outputs in ~/HW2/outputs/genemarks/
#Using RAST genome annotation server, predict and annotate genes in your assemblies outputs in ~/HW2/outputs/rast/

#Using CP015498 genes and proteins models as well as local blast, predict genes in your assemblies.
makeblastdb -in ~/HW2/outputs/assembled/ERR204044contigs.fasta -dbtype prot -parse_seqids
makeblastdb -in ~/HW2/outputs/assembled/SRR15131330contigs.fasta -dbtype prot -parse_seqids
makeblastdb -in ~/HW2/outputs/assembled/SRR18214264contigs.fasta -dbtype prot -parse_seqids

tblastn -db ~/HW2/outputs/assembled/ERR204044contigs.fasta -query ~/HW2/refs/CP015498_pro.txt > ~/HW2/outputs/blast/ERR204044_tblastn.txt
tblastn -db ~/HW2/outputs/assembled/SRR15131330contigs.fasta -query ~/HW2/refs/CP015498_pro.txt > ~/HW2/outputs/blast/SRR15131330_tblastn.txt
tblastn -db ~/HW2/outputs/assembled/SRR18214264contigs.fasta -query ~/HW2/refs/CP015498_pro.txt > ~/HW2/outputs/blast/SRR18214264_tblastn.txt

makeblastdb -in ~/HW2/outputs/assembled/ERR204044contigs.fasta -dbtype nucl -parse_seqids
makeblastdb -in ~/HW2/outputs/assembled/SRR15131330contigs.fasta -dbtype nucl -parse_seqids
makeblastdb -in ~/HW2/outputs/assembled/SRR18214264contigs.fasta -dbtype nucl -parse_seqids

blastn -db ~/HW2/outputs/assembled/ERR204044contigs.fasta -query ~/HW2/refs/CP015498_nucl.txt > ~/HW2/outputs/blast/ERR204044_blastn.txt
blastn -db ~/HW2/outputs/assembled/SRR15131330contigs.fasta -query ~/HW2/refs/CP015498_nulc.txt > ~/HW2/outputs/blast/SRR15131330_blastn.txt
blastn -db ~/HW2/outputs/assembled/SRR18214264contigs.fasta -query ~/HW2/refs/CP015498_nucl.txt > ~/HW2/outputs/blast/SRR18214264_blastn.txt


#Using all data you got, can you identify if any of you genomes are more similar to each other than to the third one (or reference genome)? Explain your ideas.
#Based on the Gepard dotplots ERR204044 and SRR15131330 appear to be most similar however RAST ring diagram
#shows most similarities between SRR15131330 and SRR18214264. Lastly phylogenetic tree of 16S sequence shows
#that ERR204044 and SRR18214264 are most related. This data leads me to a conclusion that all of these samples are
#similar to each other and the results depend on which aspects of these samples one chooses to compare.