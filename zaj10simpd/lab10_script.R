library("ggplot2")

df <- as.data.frame(matrix(c(58,59,58,61,52,52,58,56,50,51,
                             4,4,4,6,3,3,4,3,2,4,
                             128,64,64,128,16,32,64,32,16,64,
                             2699, 1299, 1599, 3499, 679, 899, 1598, 979, 519, 1699), 10, 4))
labels <- c("1", "2", "3", "4", "5")
result <- c(2, 3, 4, 3, 3, 5, 3, 3, 1, 3)
factors <- factor(result, labels)
df <- cbind(df, factors)
colnames(df) <- c("Ekran", "RAM", "Pamiec", "Cena", "Ocena")

stripchart <- ggplot(df, aes(Ekran, Cena, col = factor(Ocena))) + geom_jitter(position = position_jitter(width = 0.2), size=10)
stripchart <- stripchart + ylab("Cena") + xlab("Ekran") + labs(colour = "Ocena")
stripchart <- stripchart + ggtitle("Porownanie smartfonow") + theme(plot.title = element_text(vjust =+ 2))
stripchart