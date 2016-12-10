#!/bin/bash

# tophat2 -p 10 -o Ad_R2857_tophat -G /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_refFlat.gtf --transcriptome-index /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_refFlat/hg19_refFlat /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_bowtieindexed/hg19 Ad_R2857_1.fastq Ad_R2857_2.fastq
# echo "Ad_R2857 aligned"

tophat2 -p 10 -o Ad_R3098_tophat --transcriptome-index /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_refFlat/hg19_refFlat /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_bowtieindexed/hg19 Ad_R3098_1.fastq Ad_R3098_2.fastq
echo "Ad_R3098 aligned"

tophat2 -p 10 -o Ad_R3467_tophat --transcriptome-index /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_refFlat/hg19_refFlat /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_bowtieindexed/hg19 Ad_R3467_1.fastq Ad_R3467_2.fastq
echo "Ad_R3467 aligned"

tophat2 -p 10 -o Fe_R3452_tophat --transcriptome-index /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_refFlat/hg19_refFlat /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_bowtieindexed/hg19 Fe_R3452_1.fastq Fe_R3452_2.fastq
echo "Fe_R3452 aligned"

tophat2 -p 10 -o Fe_R4706_tophat --transcriptome-index /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_refFlat/hg19_refFlat /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_bowtieindexed/hg19 Fe_R4706_1.fastq Fe_R4706_2.fastq
echo "Fe_R4706 aligned"

tophat2 -p 10 -o Fe_R4707_tophat --transcriptome-index /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_refFlat/hg19_refFlat /Volumes/ShanBook/Bioinformatics/Reference_genome/hg19_bowtieindexed/hg19 Fe_R4707_1.fastq Fe_R4707_2.fastq
echo "Fe_R4707 aligned"

