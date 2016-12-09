#!/bin/bash

# python mergeTailToHead_fastq.py Fe_R3452_SRR1554537Rd1.fastq Fe_R3452_SRR2071348Rd1.fastq
# echo "merged Fe_R3452_Rd1"

python mergeTailToHead_fastq.py Fe_R3452_SRR1554537Rd2.fastq Fe_R3452_SRR2071348Rd2.fastq
echo "merged Fe_R3452_Rd2"

python mergeTailToHead_fastq.py Fe_R4706_SRR1554566Rd1.fastq Fe_R4706_SRR2071377Rd1.fastq
echo "merged Fe_R4706_Rd1"

python mergeTailToHead_fastq.py Fe_R4706_SRR1554566Rd2.fastq Fe_R4706_SRR2071377Rd2.fastq
echo "merged Fe_R4706_Rd2"

python mergeTailToHead_fastq.py Fe_R4707_SRR1554567Rd1.fastq Fe_R4707_SRR2071378Rd1.fastq
echo "merged Fe_R4707_Rd1"

python mergeTailToHead_fastq.py Fe_R4707_SRR1554567Rd2.fastq Fe_R4707_SRR2071378Rd2.fastq
echo "merged Fe_R4707_Rd2"

python mergeTailToHead_fastq.py Ad_SRX683794_SRR1554536Rd1.fastq Ad_SRX683794_SRR2071347Rd1.fastq
echo "merged Ad_R3098_Rd1"

python mergeTailToHead_fastq.py Ad_SRX683794_SRR1554536Rd2.fastq Ad_SRX683794_SRR2071347Rd2.fastq
echo "merged Ad_R3098_Rd2"