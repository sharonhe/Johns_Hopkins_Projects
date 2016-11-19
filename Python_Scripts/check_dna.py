#!/usr/bin/python

# check whether imput dna has undefined bases

dna = raw_input('Enter DNA sequence:')
if 'n' in dna or 'N' in dna:
	nbases = dna.count('n') + dna.count('N')
	print("dna sequence has %d undefined bases" % nbases)
else:
	print("dna sequence has no undefined bases")