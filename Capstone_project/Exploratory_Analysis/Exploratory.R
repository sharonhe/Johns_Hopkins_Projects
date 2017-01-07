# Clear workspace
rm(list = ls())

# Load packages
library(devtools)
library(Biobase)

# Load expression and phenotype data
exp_data = read.table("Expression.txt", header = TRUE)
pheno_data = read.table("Biosample_pheno.txt", header = TRUE)

# Make a boxplot for each sample to see whether data need to be transformed
boxplot(exp_data[ ,2:7],col=2,range=0)
boxplot(log2(exp_data[ ,2:7]+1),col=2,range=0)

# Make a histogram for each sample to see whether data need to be transformed
par(mfrow=c(1,2))
hist(log2(exp_data[ ,2]+1),col=2)
hist(log2(exp_data[ ,3]+1),col=2)

# assign row names
row.names(exp_data) <- make.names(exp_data[,1], unique = TRUE)
exp_data <- exp_data[,-1]
dim(exp_data)

# Transform the data
edata <- log2(exp_data + 1)

# transpose and center the data
edata_t <- t(edata)
edata_t_centered <- edata_t - rowMeans(edata_t)

# calculate the singular vectors
svd1 = svd(edata_t_centered)

# Look at the percent variance explained
plot(svd1$d,ylab="Singular value",col=2)

# Plot top two principal components
par(mfrow=c(1,2))
plot(svd1$v[,1],col=2,ylab="1st PC")
plot(svd1$v[,2],col=2,ylab="2nd PC")

# color by different variables to see if clusters stand out
palette()  # the colours and their order

# by group
par(mfrow=1)
plot(svd1$v[,1],svd1$v[,2],ylab="2nd PC",
     xlab="1st PC",col=as.numeric(pheno_data$group))
legend("topleft", c("adult", "fetus"), pch = c(1,1), col = c("black", "red"))

# by sex
plot(svd1$v[,1],svd1$v[,2],ylab="2nd PC",
     xlab="1st PC",col=as.numeric(pheno_data$sex))
legend("topleft", c("female", "male"), pch = c(1,1), col = c("black", "red"))

# by race
plot(svd1$v[,1],svd1$v[,2],ylab="2nd PC",
     xlab="1st PC",col=as.numeric(pheno_data$race))
legend("topleft", c("AA", "HISP"), pch = c(1,1), col = c("black", "red"))

# by RIN
plot(svd1$v[,1],svd1$v[,2],ylab="2nd PC",
     xlab="1st PC",col=pheno_data$RIN)
legend("topleft", c("9.6", "8.3", "8.6", "8.4", "5.3", "9.0" ), pch = c(1,1), col = c(9.6, 8.3, 8.6, 8.4, 5.3, 9.0))

