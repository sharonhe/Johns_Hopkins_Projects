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

# Venn diagram without filtering the data
# ol_f_a_l <- findOverlapsOfPeaks(fetal_brain, adult_brain, liver)
# makeVennDiagram(ol_f_a_l)

all_anno_adult_brain_df <- (all_anno_adult_brain_df[,c(1:12,20)])
all_anno_fetal_brain_df <- (all_anno_fetal_brain_df[,c(1:12,20)])
all_anno_liver_df <- (all_anno_liver_df[,c(1:12,20)])

library(dplyr)
all_anno_adult_brain_df <- all_anno_adult_brain_df %>% distinct(name, .keep_all = TRUE)
all_anno_fetal_brain_df <- all_anno_fetal_brain_df %>% distinct(name, .keep_all = TRUE)
all_anno_liver_df <- all_anno_liver_df %>% distinct(name, .keep_all = TRUE)

all_anno_adult_brain <- toGRanges(all_anno_adult_brain_df, colNames = NULL)
all_anno_fetal_brain <- toGRanges(all_anno_fetal_brain_df, colNames = NULL)
all_anno_liver <- toGRanges(all_anno_liver_df, colNames = NULL)
ol_fetal_adult_liver <- findOverlapsOfPeaks(all_anno_adult_brain, all_anno_fetal_brain, all_anno_liver, connectedPeaks="keepAll")

# Venn diagram after filtering the data
makeVennDiagram(ol_fetal_adult_liver)

# Venn diagram for genes upregulated in fetal brain
up_anno_adult_brain_df <- (up_anno_adult_brain_df[,c(1:12,20)])
up_anno_fetal_brain_df <- (up_anno_fetal_brain_df[,c(1:12,20)])

up_anno_adult_brain_df <- up_anno_adult_brain_df %>% distinct(name, .keep_all = TRUE)
up_anno_fetal_brain_df <- up_anno_fetal_brain_df %>% distinct(name, .keep_all = TRUE)

up_anno_adult_brain <- toGRanges(up_anno_adult_brain_df, colNames = NULL)
up_anno_fetal_brain <- toGRanges(up_anno_fetal_brain_df, colNames = NULL)

ol_up_fetal_adult <- findOverlapsOfPeaks(up_anno_adult_brain, up_anno_fetal_brain, connectedPeaks="keepAll")

makeVennDiagram(ol_up_fetal_adult)

# Descriptive Statistics of Peak Distances

summary(width(up_anno_adult_brain))
summary(width(up_anno_fetal_brain ))

t.test(up_anno_adult_brain_df$width,up_anno_fetal_brain_df$width, var.equal=TRUE, paired=FALSE)
# Results are as following:
# t = -28.923, df = 5742, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#         -1070.6484  -934.7274
# sample estimates:
#         mean of x mean of y 
# 1280.645  2283.333 


# make boxplot of peak width
# for all differentially expressed genes



# for genes up-regulated in fetus
boxplot(up_anno_adult_brain_df[,4], at = 1, col = 2, names = "Adult", main = "Peak Width", ylab = "Peak width", xlim = c(0,3))
boxplot(up_anno_fetal_brain_df[,4], at = 2, col =3, names = "Fetal", add = TRUE)
legend("topright", c("Adult", "Fetal"), fill = c(2, 3), col = c(2, 3))

# for genes down-regulated in fetus


write.csv(as.data.frame(unname(anno_fetal_brain)), "anno_fetal_brain.csv")









