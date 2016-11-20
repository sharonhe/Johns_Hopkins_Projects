#!/Users/Shanshan/anaconda2/bin/python

# Using Biopython to find out what species an unknow DNA sequence comes from 

import Bio

from Bio.Blast import NCBIWWW  # running the BLAST over the internet
fasta_string = 'TGGGCCTCATATTTATCCTATATACCATGTTCGTATGGTGGCGCGATGTTCTACGTGAATCCACGTTCGAAGGACATCATACCAAAGTCGTACAATTAGGACCTCGATATGGTTTTATTCTGTTTATCGTATCGGAGGTTATGTTCTTTTTTGCTCTTTTTCGGGCTTCTTCTCATTCTTCTTTGGCACCTACGGTAGAG'
result_handle = NCBIWWW.qblast("blastn", "nt", fasta_string)

from Bio.Blast import NCBIXML # the BLAST record
blast_record = NCBIXML.read(result_handle)

len(blast_record.alignments)

E_VALEU_THRESH = 0.01
for alignment in blast_record.alignments:
	for hsp in alignment.hsps:
		if hsp.expect < E_VALEU_THRESH:
			print("*****Alignment*****")
			print('sequence:', alignment.title)
			# print('length:', alignment.length)
			print('e value:', hsp.expect)
			# print(hsp.query)
			# print(hsp.match)
			# print(hsp.sbjct)
