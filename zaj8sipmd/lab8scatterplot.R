library("ggplot2")

df <- as.data.frame(matrix(c(58,59,58,61,52,52,58,56,50,51,
                             4,4,4,6,3,3,4,3,2,4,
                             128,64,64,128,16,32,64,32,16,64,
                             2699, 1299, 1599, 3499, 679, 899, 1598, 979, 519, 1699), 10, 4))
labels <- c("1", "2", "3", "4", "5")
result <- c(1, 4, 5, 4, 3, 4, 1, 2, 3, 2)
factors <- factor(result, labels)
df <- cbind(df, factors)
colnames(df) <- c("Ekran", "RAM", "Pamiec", "Cena", "Ocena")

scatterplot <- ggplot(data=df, aes(x = Ekran, y = Cena, col = Ocena)) + geom_jitter(position = position_jitter(width = 0.2), size=10)
scatterplot <- scatterplot + geom_point(size = 5) + xlab("Ekran")+ylab("Cena") + labs(colour = "Ocena") + ggtitle("Porownanie smartfonow")
scatterplot <- scatterplot + scale_colour_brewer(palette = "Set1") + theme(plot.title = element_text(vjust =+ 2)) + scale_x_continuous(breaks = 1:8)
scatterplot