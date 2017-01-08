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
par(mfrow=c(2,3))
hist(log2(exp_data[ ,1]+1),col=2, main = "R3098")
hist(log2(exp_data[ ,2]+1),col=2, main = "R2857")
hist(log2(exp_data[ ,3]+1),col=2, main = "R3467")
hist(log2(exp_data[ ,4]+1),col=2, main = "R3452")
hist(log2(exp_data[ ,5]+1),col=2, main = "R4706")
hist(log2(exp_data[ ,6]+1),col=2, main = "R4707")

# assign row names
row.names(exp_data) <- make.names(exp_data[,1], unique = TRUE)
exp_data <- exp_data[,-1]
dim(exp_data)

# Transform the data
edata <- log2(exp_data + 1)

# Center the data
edata_centered <- edata - rowMeans(edata)

# calculate the singular vectors
svd2 = svd(edata)

# Look at the percent variance explained
par(mfrow=c(1,1))
plot(svd2$d^2/sum(svd2$d^2),ylab="Percent Variance Explained",col=2)

# Plot top two principal components
par(mfrow=c(1,2))
plot(svd2$v[1,],col=2,ylab="1st PC")
plot(svd2$v[2,],col=2,ylab="2nd PC")

# color by different variables to see if clusters stand out
palette()  # the colours and their order

# by group
par(mfrow=c(1,2))
plot(svd2$v[,1],svd2$v[,2],ylab="2nd PC",
     xlab="1st PC",col=as.numeric(pheno_data$group))
legend("bottomright", c("adult", "fetus"), pch = c(1,1), col = c("black", "red"))

# by sex
plot(svd2$v[,1],svd2$v[,2],ylab="2nd PC",
     xlab="1st PC",col=as.numeric(pheno_data$sex))
legend("bottomright", c("female", "male"), pch = c(1,1), col = c("black", "red"))

# by race
par(mfrow=c(1,2))
plot(svd2$v[,1],svd2$v[,2],ylab="2nd PC",
     xlab="1st PC",col=as.numeric(pheno_data$race))
legend("bottomright", c("AA", "HISP"), pch = c(1,1), col = c("black", "red"))

# by RIN
plot(svd2$v[,1],svd2$v[,2],ylab="2nd PC",
     xlab="1st PC",col=pheno_data$RIN)
legend("bottomright", c("9.6", "8.3", "8.6", "8.4", "5.3", "9.0" ), pch = c(1,1), col = c(9.6, 8.3, 8.6, 8.4, 5.3, 9.0))

# transpose and center the data
# edata_t <- t(edata)
# edata_t_centered <- edata_t - rowMeans(edata_t)

# calculate the singular vectors
# svd1 = svd(edata_t_centered)






