#!/usr/bin/python

from genomicAlignmentV3 import findPatternV3

#Q1
pattern = "GCTGATCGATCGTACG"
filename = "chr1.GRCh38.excerpt.fasta"
patterns = findPatternV3 (filename, pattern)
edit_dist = patterns.editDistance()
print "Q1: the edit distance of the best match between pattern and the genome is %d\n"\
           %edit_dist

#Q2
pattern = "GATTTACCAGATTGAG"
filename = "chr1.GRCh38.excerpt.fasta"
patterns = findPatternV3 (filename, pattern)
edit_dist = patterns.editDistance()
print "Q2: the edit distance of the best match between pattern and the genome is %d\n"\
           %edit_dist

#Q3 and Q4
import time
t1 = time.time()
filename = "ERR266411_1.for_asm.fastq"
patterns = findPatternV3 (filename)
k_mer = 30
graph = patterns.naive_overlap_map(k_mer)
t2 = time.time()
print "Running time for naive overlap mapping: %d sec\n"%(t2 - t1)
    
reads = patterns.phraseReads(k_mer)
t3 = time.time()
print "Running time for phrase reads: %d sec\n"%(t3 - t2)
graph = patterns.overlapGraph(k_mer)
t4 = time.time()
print "Running time for optimized algorithm: %d sec\n"%(t4 - t2)
numberOfNodes = len(graph)
numberOfEdges = sum([len(edges) for edges in graph.values()])
print "Q3: the total edges are %d\n"%numberOfEdges
print "Q4: the total nodes are %d"%numberOfNodes
