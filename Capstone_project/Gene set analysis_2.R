rm(list = ls())

# Get the list of genes which are differentially expressed in adult and fetal brains. 
gene_exp_final <- read.table("gene_exp_final.txt", header = TRUE)
# list of genes which are up-regulated in fetal brains
up_fetal_exp <- subset(gene_exp_final, gene_exp_final[,4] < 0.05 & gene_exp_final[,2] > 1)
# list of genes which are down-regulated in fetal brains
down_fetal_exp <- subset(gene_exp_final, gene_exp_final[,4] < 0.05 & gene_exp_final[,2] < -1)

# Downloading the ChIP-seq Data
library(AnnotationHub)
ah <- AnnotationHub()
ah <- subset(ah, species == "Homo sapiens")
qhs <- query(ah, "H3K4me3")
d <- display(qhs)

fetal_brain <- ah[["AH44720"]] 
adult_brain <- ah[["AH43565"]]
liver <- ah[["AH44167"]]

# Downstream ChIP-seq Analysis Workflows using ChIPpeakAnno can be found here:
# https://www.bioconductor.org/packages/devel/bioc/vignettes/ChIPpeakAnno/inst/doc/pipeline.html

# Annotate the peaks with promoters provided by TxDb
library(ChIPpeakAnno)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb = TxDb.Hsapiens.UCSC.hg19.knownGene
annoData <- toGRanges(TxDb.Hsapiens.UCSC.hg19.knownGene)
annoData[1:2]

seqlevelsStyle(fetal_brain) <- seqlevelsStyle(annoData)

## ChIPpeakAnno quick start guide can be found here: http://bioconductor.org/packages/devel/bioc/vignettes/ChIPpeakAnno/inst/doc/quickStart.html
## usage of annotatePeakInBatch can be found here: https://www.rdocumentation.org/packages/ChIPpeakAnno/versions/3.6.5/topics/annotatePeakInBatch
anno_fetal_brain <- annotatePeakInBatch(fetal_brain, AnnotationData=annoData, 
                            output="overlapping", 
                            FeatureLocForDistance="TSS",
                            bindingRegion = c(-2000, 300))
library(org.Hs.eg.db)
anno_fetal_brain$gene.name <- xget(anno_fetal_brain$feature, org.Hs.egSYMBOL)
head(anno_fetal_brain)

# anno_fetal_brain <- addGeneIDs(anno_fetal_brain,
#                            "org.Hs.eg.db",
#                            IDs2Add = "entrez_id")
# head(anno_fetal_brain)
anno_fetal_brain_df <- as.data.frame(unname(anno_fetal_brain))

# Subset anno_fetal_brain_df by Genes in up_fetal_exp
selectedRows_up <- which(anno_fetal_brain_df$gene.name %in% up_fetal_exp$Genes)
up_anno_fetal_brain_df <- anno_fetal_brain_df[selectedRows_up,]
# Subset anno_fetal_brain_df by Genes in down_fetal_exp
selectedRows_down <- which(anno_fetal_brain_df$gene.name %in% down_fetal_exp$Genes)
down_anno_fetal_brain_df <- anno_fetal_brain_df[selectedRows_down,]
# Subset anno_fetal_brain_df by Genes in gene_exp_final
selectedRows_all <- which(anno_fetal_brain_df$gene.name %in% gene_exp_final$Genes)
all_anno_fetal_brain_df <- anno_fetal_brain_df[selectedRows_all,]

# Do the same process for adult brain
anno_adult_brain <- annotatePeakInBatch(adult_brain, AnnotationData=annoData, 
                                        output="overlapping", 
                                        FeatureLocForDistance="TSS",
                                        bindingRegion = c(-2000, 300))

anno_adult_brain$gene.name <- xget(anno_adult_brain$feature, org.Hs.egSYMBOL)
head(anno_adult_brain)

anno_adult_brain_df <- as.data.frame(unname(anno_adult_brain))

## Subset anno_adult_brain_df by Genes in up_fetal_exp
selectedRows_up_2 <- which(anno_adult_brain_df$gene.name %in% up_fetal_exp$Genes)
up_anno_adult_brain_df <- anno_adult_brain_df[selectedRows_up_2,]
## Subset anno_adult_brain_df by Genes in down_fetal_exp
selectedRows_down_2 <- which(anno_adult_brain_df$gene.name %in% down_fetal_exp$Genes)
down_anno_adult_brain_df <- anno_adult_brain_df[selectedRows_down_2,]
## Subset anno_adult_brain_df by Genes in gene_exp_final
selectedRows_all_2 <- which(anno_adult_brain_df$gene.name %in% gene_exp_final$Genes)
all_anno_adult_brain_df <- anno_adult_brain_df[selectedRows_all_2,]

# Do the same process for liver
anno_liver <- annotatePeakInBatch(liver, AnnotationData=annoData, 
                                        output="overlapping", 
                                        FeatureLocForDistance="TSS",
                                        bindingRegion = c(-2000, 300))

anno_liver$gene.name <- xget(anno_liver$feature, org.Hs.egSYMBOL)
head(anno_liver)
anno_liver_df <- as.data.frame(unname(anno_liver))

## Subset anno_liver_df by Genes in gene_exp_final
selectedRows_all_3 <- which(anno_liver_df$gene.name %in% gene_exp_final$Genes)
all_anno_liver_df <- anno_liver_df[selectedRows_all_3,]




# Obtain enriched GO terms 
# over <- getEnrichedGO(anno_fetal_brain, orgAnn="org.Hs.eg.db", 
#                     feature_id_type = "entrez_id",
#                     maxP=.05, minGOterm=10, 
#                     multiAdjMethod="BH", condense=TRUE)
# head(over[["bp"]][, -c(3, 10)])




write.csv(as.data.frame(unname(anno_fetal_brain)), "anno_fetal_brain.csv")









