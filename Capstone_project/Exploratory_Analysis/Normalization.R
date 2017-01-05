R2857_PMRM = (59395338 + 57177287) / (1*10^6)
R3098_PMRM = (57898880 + 56211062) / (1*10^6)
R3467_PMRM = (76978929 + 73116538) / (1*10^6)
R3452_PMRM = (173775507 + 166759512) / (1*10^6)
R4706_PMRM = (123264007 + 118364127) / (1*10^6)
R4707_PMRM = (145149165 + 138414686) / (1*10^6)

rawCount = read.table("FeatureCounts.txt", header = TRUE)
rawCount[,2] = rawCount[,2]/R3098_PMRM
rawCount[,3] = rawCount[,3]/R2857_PMRM
rawCount[,4] = rawCount[,4]/R3467_PMRM
rawCount[,5] = rawCount[,5]/R3452_PMRM
rawCount[,6] = rawCount[,6]/R4706_PMRM
rawCount[,7] = rawCount[,7]/R4707_PMRM

write.table(rawCount, file = "Expression.txt", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

