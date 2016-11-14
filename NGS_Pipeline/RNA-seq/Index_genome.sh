#!/bin/bash

# Create a bowtie index of the genome using bowtie2-build, with the prefix ‘athal’. Include a copy of the reference genome with the name “athal.fa” in the index directory. 
echo making new directory
bowtie2-build mkdir athal

echo index the genome
bowtie2-build athal_chr.fa athal/athal

# Alignment with tophat

echo alignment with tophat for the 1st file
tophat2 -p 10 athal/athal Day8.fastq

rm -rf Day8
rename tophat_out Day8

echo alignment with tophat for the 2nd file
tophat2 -p 10 athal/athal Day16.fastq 

rm -rf Day16
rename tophat_out Day16