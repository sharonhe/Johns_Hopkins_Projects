#!/usr/bin/env python
from Bio import SeqIO
import itertools
import sys
import os
# Copyright(C) 2011 Iddo Friedberg
# Released under Biopython license. http://www.biopython.org/DIST/LICENSE
# Do not remove this comment
def merge_fastq(fastq_path1, fastq_path2, outpath):
    outfile = open(outpath,"w")
    fastq_iter1 = SeqIO.parse(open(fastq_path1),"fastq")
    fastq_iter2 = SeqIO.parse(open(fastq_path2),"fastq")
    for rec1, rec2 in itertools.izip(fastq_iter1, fastq_iter2):
        SeqIO.write([rec1,rec2], outfile, "fastq")
    outfile.close()

if __name__ == '__main__':
    outpath = "%s.mergedInterleaved.fastq" % os.path.splitext(sys.argv[1])[0]
    merge_fastq(sys.argv[1],sys.argv[2],outpath)