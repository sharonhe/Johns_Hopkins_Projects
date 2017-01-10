rm(list = ls())

# Downloading the Data
library(AnnotationHub)
ah <- AnnotationHub()
fetal_brain <- ah[["AH44720"]]
adult_brain <- ah[["AH43565"]]
liver <- ah[["AH44167"]]

# Get the GRanges BED file of fetal brain, adult brain and liver
library(pander)
fetal_brain_df <- as.data.frame(fetal_brain)
pander(fetal_brain_df[1:2,])

adult_brain_df <- as.data.frame(adult_brain)
pander(adult_brain_df[1:2,])

liver_df <- as.data.frame(liver)
pander(liver_df[1:2,])

# Examine peak distance
summary(width(fetal_brain))
summary(width(adult_brain))
summary(width(liver))

# Examine overlapping peaks
# library(ChIPpeakAnno)
# ol_f_a_l <- findOverlapsOfPeaks(fetal_brain, adult_brain, liver)
# makeVennDiagram(ol_f_a_l)

# Examine the overlaps between H3k4me3 and gene promoters
# hg19 was used as the reference genome

