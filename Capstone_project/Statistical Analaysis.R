# Clear workspace
rm(list = ls())

# Load packages
library(DESeq2)

# Load data
rawCounts <- read.table("FeatureCounts.txt", header = TRUE)

# Asign the row names
row.names(rawCounts) <- make.names(rawCounts[,1], unique = TRUE)
rawCounts <- rawCounts[,-1]
dim(rawCounts)

pheno_data = read.table("Biosample_pheno.txt", header = TRUE)

# Differential analysis by DESeq2

# Exploratory analysis
condition <- c("adult", "adult", "adult", "fetus", "fetus", "fetus")
sample <- c("R3098", "R2857", "R3467", "R3452", "R4706", "R4707")
col_data <- data.frame(sample, condition)
row.names(col_data) <- make.names(col_data[,1], unique = TRUE)
gene_dds <- DESeqDataSetFromMatrix(countData = rawCounts, colData = col_data, design = ~ condition)
gene_dds_rltransf <- rlog(gene_dds, blind=FALSE)
dist_samples <- dist(t(assay(gene_dds_rltransf)))
gene_fit <- hclust(dist_samples, method="ward.D")
plot(gene_fit, hang=-1)
plotPCA(gene_dds_rltransf, intgroup = c("condition"))

# Statistical analysis
gene_dd_dsq <- DESeq(gene_dds)
gene_exp_results <- results(gene_dd_dsq) #retrieve gene exp results
gene_exp_results_df <- as.data.frame(gene_exp_results) #results as data.frame

# get the tab-delimited file as requested by project instruction
gene_exp_final <- data.frame(gene_exp_results_df[,1], gene_exp_results_df[,4], gene_exp_results_df[,7], gene_exp_results_df[,8])
colnames(gene_exp_final) <- c("Genes", "log2FoldChange", "pValue", "adjusted_pValue") # rename the colunm names
write.table(gene_exp_final, file = "gene_exp_final.txt", quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE) # export the data frame

# sum of genes up- and down-regulated at > 1 or < -1 fold change, and padj < 0.5
sum(gene_exp_results_df$padj < 0.05 & gene_exp_results_df$log2FoldChange > 1, na.rm=TRUE)
sum(gene_exp_results_df$padj < 0.05 & gene_exp_results_df$log2FoldChange < -1, na.rm=TRUE)

## generate volcano plot
par(mfrow = c(1,1))
with(gene_exp_results_df, plot(log2FoldChange, -log10(pvalue), pch=20, main="Volcano plot"))

## add color to points 
with(subset(gene_exp_results_df, padj<.05 ), 
     points(log2FoldChange, -log10(pvalue), pch=20, col="red"))
with(subset(gene_exp_results_df, abs(log2FoldChange)>1), 
     points(log2FoldChange, -log10(pvalue), pch=20, col="orange"))
with(subset(gene_exp_results_df, padj<.05 & abs(log2FoldChange)>1), 
     points(log2FoldChange, -log10(pvalue), pch=20, col="green"))
legend("top", c("adjusted p value < 0.05", "log2FoldChange > 1", "adjusted p value < 0.05 & log2FoldChange > 1"), pch = 20, col = c("red", "orange", "green"))

legend("bottomright", c("adult", "fetus"), pch = c(1,1), col = c("black", "red"))

library (dplyr) # version 0.5.0
gene_exp_results_df <- data.frame(row.names(rawCounts), gene_exp_results_df)
up_top <- gene_exp_results_df %>% filter (log2FoldChange > 1) %>% arrange(padj) %>% head(n = 10L) # top up-reg genes
down_top <- gene_exp_results_df %>% filter (log2FoldChange < -1) %>% arrange(padj) %>% head(n = 10L) # top down-reg genes

# Export up-regulated genes table
up_top_sum <- up_top[,c(1,5,8,9)]
formated_up_top_sum <- signif(up_top_sum[,c(2,3,4)], 3) # format the number
up_top_sum <- data.frame(up_top_sum[,1], formated_up_top_sum)
colnames(up_top_sum) <- c("Genes", "FoldChange", "Pvalue", "AdjusedPValue")
write.table(up_top_sum, file = "up_top.txt", row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# Export down-regulated genes table
down_top_sum <- down_top[,c(1,5,8,9)]
formated_down_top_sum <- signif(down_top_sum[,c(2,3,4)], 3) # format the number
down_top_sum <- data.frame(down_top_sum[,1], formated_down_top_sum)
colnames(down_top_sum) <- c("Genes", "FoldChange", "Pvalue", "AdjusedPValue")
write.table(down_top_sum, file = "down_top.txt", row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")




