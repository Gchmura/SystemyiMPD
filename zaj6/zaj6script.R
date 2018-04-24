library("neuralnet")

#Going to create a neural network to perform prediction
#Type ?neuralnet for more information on the neuralnet library

#Generate training data
#And store them as a dataframe
traininginput <- as.data.frame(matrix(c(58,4,128,
                                        59,4,64,
                                        58,4,64,
                                        61,6,128,
                                        52,3,16,
                                        52,3,32,
                                        58,4,64,
                                        56,3,32,
                                        50,2,16,
                                        51,4,64), nrow=10, ncol=3))
trainingoutput <- c(2699, 1299, 1599, 3499, 679, 899, 1598, 979, 519, 1699)

#Column bind the data into one variable
trainingdata <- cbind(traininginput, trainingoutput)

# Create Vector of Column Max and Min Values
maxs <- apply(trainingdata[,], 2, max)
mins <- apply(trainingdata[,], 2, min)

# Use scale() and convert the resulting matrix to a data frame
scaled.trainingdata <- as.data.frame(scale(trainingdata[,], center=mins, scale=maxs-mins))
trainingdata <- scaled.trainingdata

# Check out results
print(head(trainingdata, 10))

colnames(trainingdata) <- c("wyswietlacz", "ram", "pamiec", "Cena") 
print(trainingdata)

#Train the neural network
#Going to have C(5, 4, 3) hidden layers
#Threshold is a numeric value specifying the threshold for the partial
#derivatives of the error function as stopping criteria.
net.price <- neuralnet(Cena~ram+wyswietlacz+pamiec, trainingdata, hidden=c(5, 4, 3), threshold=0.001)
print(net.price)

#Plot the neural network
plot(net.price)

#Test the neural network on some training data
testdata <- as.data.frame(matrix(c(1262, 3349, 1028,
                                   2060, 1075, 1600,
                                   1361, 800, 2000), nrow=3, ncol=3))
scaled.testdata <- as.data.frame(scale(testdata[,], center=mins[1:3], scale=maxs[1:3]-mins[1:3]))
net.results <- compute(net.price, scaled.testdata) #Run them through the neural network

#Lets see what properties net.price has
ls(net.results)

#Lets see the results
print(net.results$net.result)
