#!/usr/bin/python

from genomeAssembly import deNovoAssambly
import itertools

# text = ["CCT", "CTT", "TGC", "TGG", "GAT", "ATT"]
# assembly = deNovoAssambly (text = text)
# print assembly.shortComSupstr()

filename = "ads1_week4_reads.fq"
assembly = deNovoAssambly (filename = filename)
reads, _ = assembly.readFastq()
sequence = assembly.greedyScs(reads, 8)
counts = assembly.countNt(sequence)
assembly.output(sequence)
print counts