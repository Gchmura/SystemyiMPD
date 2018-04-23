library(MCDA)

epsilon <-0.01

t = read.table("smartfony.csv", header = TRUE, sep = ",", row.names = 1)

# ranks of the alternatives
alternativesRanks <- c(1,2,3,4,5,6,7,8,9,10)
names(alternativesRanks) <- row.names(t)

# criteria to minimize or maximize
criteriaMinMax <- c("min","max","max","max","max")
names(criteriaMinMax) <- colnames(t)

x<-additiveValueFunctionElicitation(
  t,criteriaMinMax, epsilon, alternativesRanks = alternativesRanks)