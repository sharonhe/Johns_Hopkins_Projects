#!/usr/bin/python

# from genomicAlignmentV1 import findPattern

#Q1
# filename1 = "lambda_virus.fa"
# pattern = "AGGT"
# patterns = findPattern(pattern,filename1)
# print "Q1: The 'AGGT' or 'ACCT' occurs %d times \n" \
#            %len(patterns.patternIdentifier(0))

#Q2
# filename1 = "lambda_virus.fa"
# pattern = "TTAA"
# patterns = findPattern(pattern,filename1)
# print "Q2: The 'TTAA' occurs %d times \n" \
#            %len(patterns.patternIdentifier(0))

#Q3
# filename1 = "lambda_virus.fa"
# pattern = "ACTAAGT"
# patterns = findPattern(pattern,filename1)
# print "Q3: The offset of the leftmost occurrence of ACTAAGT is %d \n" \
#            %min(patterns.patternIdentifier(0))

#Q4
# filename1 = "lambda_virus.fa"
# pattern = "AGTCGA"
# patterns = findPattern(pattern,filename1)
# print "Q4: The offset of the leftmost occurrence of AGTCGA is %d \n" \
#            %min(patterns.patternIdentifier(0))

#Q5
# filename1 = "lambda_virus.fa"
# pattern = "TTCAAGCC"
# patterns = findPattern(pattern,filename1)
# print "Q5: The 'TTCAAGCC' occurs %d times with mismatch less than 2 \n" \
#            %len(patterns.patternIdentifier(2))

#Q6
# filename1 = "lambda_virus.fa"
# pattern = "AGGAGGTT"
# patterns = findPattern(pattern,filename1)
# print "Q6: The offset of the leftmost occurrence of AGGAGGTT with mismatch less than 2 is %d \n" \
#           %min(patterns.patternIdentifier(2))  

#Q7
from genomicAlignmentV1 import checkQuality

filename2 = "ERR037900_1.first1000.fastq"
qualities = checkQuality(filename2)
counters = qualities.countPoorQuality()
print "Q7: The cycle has most frequent poor quality is %d" \
          %max(counters, key = lambda x: counters[x])