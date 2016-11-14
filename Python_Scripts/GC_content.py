#!/usr/bin/python

dna = 'atcgaattggccatgctgactgacaccgt'  # read dna sequence
no_c = dna.count('c')  # count the number of 'c' in dna sequence
no_g = dna.count('g')  # count the number of 'g' in dna sequence
dna_length = len(dna)  # determine the length of dna sequence
gc_percent = (no_c + no_g) * 100.0 / dna_length # compute the GC %
print(gc_percent) # print GC %
