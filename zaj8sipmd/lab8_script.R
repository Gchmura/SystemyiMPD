library("rpart")
library("dplyr")
library("party")
data <- as.data.frame(matrix(c(58,59,58,61,52,52,58,56,50,51,
                               4,4,4,6,3,3,4,3,2,4,
                               128,64,64,128,16,32,64,32,16,64,
                               2699, 1299, 1599, 3499, 679, 899, 1598, 979, 519, 1699), 10, 4))

labels <- c("1", "2", "3", "4", "5")

result <- c(1, 4, 5, 4, 3, 4, 1, 2, 3, 2)

factors <- factor(result, labels)
data <- cbind(data, factors)
colnames(data) <- c("Ekran","RAM","Pamiec","Cena","Ocena")

mydata <- c("training", "test") %>% sample(nrow(data), replace=T) %>% split(data, .)
rtree_fit <- rpart(Ocena ~ ., mydata$training, control=rpart.control(minsplit=1, minbucket=1, cp=0.001))
par(mar = rep(0.2, 4))
plot(rtree_fit, uniform = TRUE)
text(rtree_fit, use.n = TRUE)