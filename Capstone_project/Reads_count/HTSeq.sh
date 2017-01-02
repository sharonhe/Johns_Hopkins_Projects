#!/bin/bash

# For paired-end data, the alignment have to be sorted either by read name or by alignment position.
# samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R2857_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R2857_accepted_hits_sorted

# samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R3098_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3098_accepted_hits_sorted

# samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R3467_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted

# samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R3452_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3452_accepted_hits_sorted

# samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R4706_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R4706_accepted_hits_sorted

# samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R4707_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R4707_accepted_hits_sorted

# To use htseq, Install PySam to use the BAM_Reader Class (http://code.google.com/p/pysam/). Otherwise it will give the following error:
# Error occured when reading beginning of SAM/BAM file.
# No module named pysam
# [Exception type: ImportError, raised in __init__.py:937]https://code.google.com/archive/p/pysam/

# The reference genome used for htseq-count in the following was downloaded from Gencode ("Comprehensive gene annotation" in https://www.gencodegenes.org/releases/19.html). The reference genome from Ensembl gives 0 feature result.
# htseq-count -f bam -r name -i gene_name /Volumes/EvaBook/HTSeq/R2857_accepted_hits_sorted.bam /Volumes/EvaBook/Reference_Genome/gencode.v19.annotation.gtf > /Volumes/EvaBook/HTSeq/R2857_htseq.txt

# htseq-count -f bam -r name -i gene_name /Volumes/EvaBook/HTSeq/R3098_accepted_hits_sorted.bam /Volumes/EvaBook/Reference_Genome/gencode.v19.annotation.gtf > /Volumes/EvaBook/HTSeq/R3098_htseq.txt

# htseq-count -f bam -r name -i gene_name /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted.bam /Volumes/EvaBook/Reference_Genome/gencode.v19.annotation.gtf > /Volumes/EvaBook/HTSeq/R3467_htseq.txt

# htseq-count -f bam -r name -i gene_name /Volumes/EvaBook/HTSeq/R3452_accepted_hits_sorted.bam /Volumes/EvaBook/Reference_Genome/gencode.v19.annotation.gtf > /Volumes/EvaBook/HTSeq/R3452_htseq.txt

# htseq-count -f bam -r name -i gene_name /Volumes/EvaBook/HTSeq/R4706_accepted_hits_sorted.bam /Volumes/EvaBook/Reference_Genome/gencode.v19.annotation.gtf > /Volumes/EvaBook/HTSeq/R4706_htseq.txt

# htseq-count -f bam -r name -i gene_name /Volumes/EvaBook/HTSeq/R4707_accepted_hits_sorted.bam /Volumes/EvaBook/Reference_Genome/gencode.v19.annotation.gtf > /Volumes/EvaBook/HTSeq/R4707_htseq.txt

# Error occured when processing SAM input (record #162841549 in file /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted.bam):
  # 'pair_alignments' needs a sequence of paired-end alignments
  # [Exception type: ValueError, raised in __init__.py:603]
# The reason for this error might because of some single-end reads in R3467. To solve this problem, to separate out alignments from paired-end datasets and single-end datasets just use samtools:

# samtools view -bf 1 /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted.bam > /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted_paired_end.bam
# samtools view -bF 1 /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted.bam > /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted_single_end.bam

# Then rerun the htseq-count

htseq-count -f bam -r name -i gene_name /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted_paired_end.bam /Volumes/EvaBook/Reference_Genome/gencode.v19.annotation.gtf > /Volumes/EvaBook/HTSeq/R3467_htseq.txt


