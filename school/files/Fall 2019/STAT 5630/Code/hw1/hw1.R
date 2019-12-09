library(kknn)
library(tidyverse)
setwd("/Users/maxryoo/Documents/Fall 2019/STAT 5630/Code/hw1")
full_data <- data.frame(read.table('Q1.txt', header=TRUE))
set.seed(1)

#Split the training and testing data evenly into 50
training_data <- full_data[1:50, ]
testing_data <- full_data[51:100,]
train.x = training_data$X
train.y = training_data$Y
test.x = testing_data$X
test.y = testing_data$Y

#Order the df for plotting
test.y = test.y[order(test.x)]
test.x = test.x[order(test.x)]

training_error = replicate(21,0)
testing_error = replicate(21,0)

# 1-nearest neighbour --- you can try different k values and see the results
k = 1
knn.fit.test = kknn(y ~ x, 
               train = data.frame(x = train.x , y = train.y), 
               test = data.frame(x = test.x, y = test.y),
               k = k, 
               kernel = "rectangular")
knn.fit.train = kknn(y ~ x, 
                    train = data.frame(x = train.x , y =train.y ), 
                    test = data.frame(x = train.x , y =  train.y),
                    k = k, 
                    kernel = "rectangular")

test.pred = knn.fit.test$fitted.values
train.pred = knn.fit.train$fitted.values

#Plot for K = 1 using intro.R code
par(mar=rep(2,4))
plot(train.x,train.y, xlim = c(1, 3), pch = 19, cex = 1, axes=FALSE, ylim = c(-4.25, 20))
title(main=paste(1, "-Nearest Neighbor Regression", sep = ""))
lines(test.x, test.x**3, col = "deepskyblue", lwd = 3)
lines(test.x, test.pred, type = "s", col = "darkorange", lwd = 3)
box()

#Try for 1-20 K Values
for (i in 1:20) {
  k = i
  knn.fit.test = kknn(y ~ x, 
                      train = data.frame(x = train.x , y = train.y), 
                      test = data.frame(x = test.x, y = test.y),
                      k = k, 
                      kernel = "rectangular")
  knn.fit.train = kknn(y ~ x, 
                       train = data.frame(x = train.x , y =train.y ), 
                       test = data.frame(x = train.x , y = train.y),
                       k = k, 
                       kernel = "rectangular")
  
  test.pred = knn.fit.test$fitted.values
  train.pred = knn.fit.train$fitted.values
  
  par(mar=rep(2,4))
  plot(train.x,train.y, xlim = c(1, 3), pch = 19, cex = 1, axes=FALSE, ylim = c(-4.25, 20))
  title(main=paste(1, "-Nearest Neighbor Regression", sep = ""))
  lines(test.x, test.x**3, col = "deepskyblue", lwd = 3)
  lines(test.x, test.pred, type = "s", col = "darkorange", lwd = 3)
  box()
  
  training.error <- mean((train.pred - train.y)^2)
  testing.error <- mean((test.pred - test.y)^2)
  
  print(training.error)
  print(testing.error)
  training_error[i] = training.error
  testing_error[i] = testing.error
}

#Do a K-value of 50 
k = 50
knn.fit.test = kknn(y ~ x, 
                    train = data.frame(x = train.x , y = train.y ), 
                    test = data.frame(x = test.x, y = test.y),
                    k = k, 
                    kernel = "rectangular")
knn.fit.train = kknn(y ~ x, 
                     train = data.frame(x = train.x , y = train.y ), 
                     test = data.frame(x = train.x , y = train.y),
                     k = k, 
                     kernel = "rectangular")

test.pred = knn.fit.test$fitted.values
train.pred = knn.fit.train$fitted.values

#Plot when K=50
par(mar=rep(2,4))
plot(train.x,train.y, xlim = c(1, 3), pch = 19, cex = 1, axes=FALSE, ylim = c(-4.25, 20))
title(main=paste(1, "-Nearest Neighbor Regression", sep = ""))
lines(test.x, test.x**3, col = "deepskyblue", lwd = 3)
lines(test.x, test.pred, type = "s", col = "darkorange", lwd = 3)
box()

#Get the MSE
training.error <- mean((train.pred - train.y)^2)
testing.error <- mean((test.pred - test.y)^2)

print(training.error)
print(testing.error)
#Put in the testing and training error for K=50
training_error[21] = training.error
testing_error[21] = testing.error

print(training_error)
print(testing_error)
#which is best K value (min training value)
which.min(testing_error)
min(testing_error)


#Plot errors vs K
errordf = data.frame("K" = c(1:20, 50), "Training" = training_error[1:21] , "Testing" = testing_error[1:21])
ggplot() + 
  geom_point(aes(x=errordf$K, y=errordf$Training,colour="darkblue")) + 
  geom_point(aes(x=errordf$K, y=errordf$Testing,colour="red")) + 
  geom_line(aes(x=errordf$K, y=errordf$Training,colour="darkblue")) + 
  geom_line(aes(x=errordf$K, y=errordf$Testing,,colour="red")) +
  theme_bw() +
  ylab("Error") +
  xlab("K-Value") + 
  ggtitle("Testing and Training Error for K-Value 1-20 & 50") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_discrete(name = "Errors", labels = c("Training", "Testing"))

#### QUESTION 2 ######

linreg_train <- lm(Y~X, data = training_data)  
linreg_test_pred <- predict(linreg_train, newdata = testing_data) 
training_summary <- summary(linreg_train)
mse_train <- mean((training_summary$residuals)^2)
mse_testing <- mean((testing_data[,2]-linreg_test_pred)^2)

### QUESTION 3 #####
nfold = 5
K=20
infold = sample(rep(1:nfold, length.out=length(train.x)))
mydata = data.frame(x = train.x, y = train.y)

#Set up matrix to store values
errorMatrix.train = matrix(NA, K + 1, nfold)
errorMatrix.test = matrix(NA, K + 1, nfold)
for (l in 1:nfold) {
  for (k in 1:K) {
      knn.fit.train.val = kknn(y ~ x, train = mydata[infold != l, ], test = mydata[infold != l, ], k = k)
      errorMatrix.train[k, l] = mean((knn.fit.train.val$fitted.values - mydata$y[infold != l])^2)
      knn.fit.test.val = kknn(y ~ x, train = mydata[infold != l, ], test = mydata[infold == l, ], k = k)
      errorMatrix.test[k, l] = mean((knn.fit.test.val$fitted.values - mydata$y[infold == l])^2)
  }
}


for(l in 1:nfold) {
  k = length( mydata[infold != l, ]$x)
  print(k)
  knn.fit.train.val = kknn(y ~ x, train = mydata[infold != l, ], test = mydata[infold != l, ], k = k )
  errorMatrix.train[21, l] = mean((knn.fit.train.val$fitted.values - mydata$y[infold != l])^2)
  knn.fit.test.val = kknn(y ~ x, train = mydata[infold != l, ], test = mydata[infold == l, ], k = k)
  errorMatrix.test[21, l] = mean((knn.fit.test.val$fitted.values - mydata$y[infold == l])^2)
}

train.mean <- apply(errorMatrix.train,1,mean)
test.mean <- apply(errorMatrix.test,1,mean)
train.mean
test.mean

# Besk K - Value was 6 for the Testing Error for CV
which.min(apply(errorMatrix.test, 1, mean))

errordfcv = data.frame("K" = c(1:20, 40), "Training" = train.mean[1:21] , "Testing" = test.mean[1:21])
ggplot() + 
  geom_point(aes(x=errordfcv$K, y=errordfcv$Training,colour="darkblue")) + 
  geom_point(aes(x=errordfcv$K, y=errordfcv$Testing,colour="red")) + 
  geom_line(aes(x=errordfcv$K, y=errordfcv$Training,colour="darkblue")) + 
  geom_line(aes(x=errordfcv$K, y=errordfcv$Testing,,colour="red")) +
  theme_bw() + 
  ylab("Error") +
  xlab("K-Value") + 
  ggtitle("Testing and Training Error for Cross Validation of K-Value 1-20 & 40") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_discrete(name = "Errors", labels = c("Training", "Testing"))

