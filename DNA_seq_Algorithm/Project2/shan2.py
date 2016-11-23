#!/usr/bin/python

from genomicAligmentV2 import findPatternV2
from genomicAligmentV2 import Index
from genomicAligmentV2 import SubseqIndex
from bm_preproc import BoyerMoore

#Q1:
filename = ("chr1.GRCh38.excerpt.fasta")
pattern = "GGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGGGAGGCCGAGG"
patterns = findPatternV2(pattern, filename)
print "Q1: The alignments for naive match algorithm is %d\n"%patterns.naiveMatch(0)[1]
patterns = findPatternV2("GGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGGGAGGCCGAGG", filename)    

#Q2:
print "Q2: The characters comparisons for naive match algorithm is %d\n"%patterns.naiveMatch(0)[2]

#Q3:
print "Q3: The alignments for Boyer-Moore algorithm is %d\n"%patterns.boyerMoore(0, \
          BoyerMoore(pattern, "ACGT"))[1]

#Q4:
k_mer = 8      
pattern = "GGCGCGGTGGCTCACGCCTGTAAT"
genome = patterns.readGenome()
index = Index(genome, k_mer)
occurances, numberOfOccurs, numberOfhits = patterns.matchedIndex(index, \
                                               k_mer, pattern, isSubseqIndex = False)
print "Q4: Within 2 mismatchs, the string occurs %d times\n" %numberOfOccurs

#Q5:
print "Q5: Within 2 mismatchs, the total index hits are %d \n" %numberOfhits

#Q6: 
pattern = "GGCGCGGTGGCTCACGCCTGTAAT"
k_mer = 8
vial = 3
index = SubseqIndex(genome, k_mer, vial)
occurances, numberOfOccurs, numberOfhits = patterns.matchedIndex(index, \
                                               k_mer, pattern, isSubseqIndex = vial)

print "Q6: Within 2 mismatchs, the hits are %d\n" %numberOfhits