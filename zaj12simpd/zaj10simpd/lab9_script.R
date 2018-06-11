library("C50")
data <- matrix(c(58,59,58,61,52,52,58,56,50,51,
                 4,4,4,6,3,3,4,3,2,4,
                 128,64,64,128,16,32,64,32,16,64,
                 2699, 1299, 1599, 3499, 679, 899, 1598, 979, 519, 1699), 10, 4)
labels <- c("1", "2", "3", "4")
result <- c(2, 3, 4, 3, 3, 5, 3, 3, 1, 3)
test <- factor(result, labels)
colnames(data) <- c("Ekran", "RAM", "Pamiec", "Cena")
ruleModel <- C5.0(x = data[,], y = test, rules = TRUE)
ruleModel
summary(ruleModel)