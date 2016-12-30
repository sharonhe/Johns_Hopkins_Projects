#!/bin/bash

# For paired-end data, the alignment have to be sorted either by read name or by alignment position.
samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R2857_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R2857_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R3098_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3098_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R3467_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R3452_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3452_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R4706_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R4706_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R4707_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R4707_accepted_hits_sorted

# To use htseq, Install PySam to use the BAM_Reader Class (http://code.google.com/p/pysam/). Otherwise it will give the following error:
# Error occured when reading beginning of SAM/BAM file.
# No module named pysam
# [Exception type: ImportError, raised in __init__.py:937]https://code.google.com/archive/p/pysam/

htseq-count -f bam -r name /Volumes/EvaBook/HTSeq/R2857_accepted_hits_sorted.bam /Volumes/EvaBook/Reference_Genome/Homo_sapiens.GRCh38.77.gtf

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R3098_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3098_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Ad_R3467_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3467_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R3452_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R3452_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R4706_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R4706_accepted_hits_sorted

samtools sort -n /Volumes/EvaBook/merged_FASTQs/Fe_R4707_tophat/accepted_hits.bam /Volumes/EvaBook/HTSeq/R4707_accepted_hits_sorted

