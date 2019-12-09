
## Max Ryoo hr2ee
## Script used for hw 2 (for bcakup)
setwd("/Users/maxryoo/Documents/Fall 2019/STAT 5630/Code/hw2")
##Q1

WineQuality <- read.csv("WineQuality.csv")
trainWine <- WineQuality[0:500,]
testWine <- WineQuality[500:706,]

first_11 <- WineQuality[1:11]
first_11_withQuality <- cbind(first_11, WineQuality[32])

library(ggplot2)
library(gridExtra)
plotlist = list()
colname <- names(first_11_withQuality)
plotlist[[1]] = ggplot(first_11_withQuality,aes(x="",y=fixed.acidity)) + geom_boxplot() +theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[2]] = ggplot(first_11_withQuality,aes(x="",y=volatile.acidity)) + geom_boxplot() +theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[3]] = ggplot(first_11_withQuality,aes(x="",y=citric.acid)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[4]] = ggplot(first_11_withQuality,aes(x="",y=residual.sugar)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[5]] = ggplot(first_11_withQuality,aes(x="",y=chlorides)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[6]] = ggplot(first_11_withQuality,aes(x="",y=free.sulfur.dioxide)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[7]] = ggplot(first_11_withQuality,aes(x="",y=total.sulfur.dioxide)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[8]] = ggplot(first_11_withQuality,aes(x="",y=density)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[9]] = ggplot(first_11_withQuality,aes(x="",y=pH)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[10]] = ggplot(first_11_withQuality,aes(x="",y=sulphates)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[11]] = ggplot(first_11_withQuality,aes(x="",y=alcohol)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plotlist[[12]] = ggplot(first_11_withQuality,aes(x="",y=quality)) + geom_boxplot()+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
p <- grid.arrange(grobs=plotlist,ncol=4)
ggsave("boxplots.png",p)


response <- WineQuality[length(WineQuality)]

first_14 <- WineQuality[1:14]
first_14_withQuality <- cbind(first_14, WineQuality[32])

names(trainWine)


## A
length(names(WineQuality))
pairs(first_11, pch=".")
pairs(first_11_withQuality, pch=".")
library(PerformanceAnalytics)
suppressWarnings(chart.Correlation(first_11, col = "purple", pch = "*"))
suppressWarnings(chart.Correlation(first_11_withQuality, col = "purple", pch = "*"))


## B
pairs(first_14, pch=".")  # produce pair-wise scatter plots. Caution: a big figure.
suppressWarnings(chart.Correlation(first_14_withQuality, col = "purple", pch = "*"))

## C
#full model for regression
lmfit = lm(quality ~., data=trainWine)
round(summary(lmfit)$coef,3)
n <- nrow(trainWine)
AIC(lmfit)

##AIC
##Step wise aic and BIC
?step
## AIC
step(lmfit, direction="both", trace=0)
"
Coefficients:
        (Intercept)        fixed.acidity     volatile.acidity       residual.sugar  
2.564e+02            2.231e-01           -2.529e+00            1.246e-01  
free.sulfur.dioxide              density                   pH            sulphates  
3.423e-03           -2.599e+02            1.730e+00            1.081e+00  
Index.9  
6.441e-02  
"
step(lm(quality~1, data=trainWine), scope=list(upper=lmfit, lower=~1), direction="forward")
'
Coefficients:
        (Intercept)              alcohol     volatile.acidity       residual.sugar  
-0.029911             0.318096            -2.746851             0.028060  
pH            sulphates  free.sulfur.dioxide              Index.9  
0.833553             0.721470             0.003995             0.054131  
'
## BIC
step(lmfit, direction="both", k=log(n), trace=0) 
"
Coefficients:
     (Intercept)     fixed.acidity  volatile.acidity    residual.sugar           density  
249.4539            0.2196           -2.5663            0.1244         -252.6838  
pH         sulphates  
1.7168            1.0969  
"
step(lm(quality~1, data=trainWine), k=log(n), scope=list(upper=lmfit, lower=~1), direction="forward")
"
Coefficients:
     (Intercept)           alcohol  volatile.acidity    residual.sugar  
0.14341           0.30860          -2.78529           0.03122  
pH         sulphates  
0.84567           0.75590  

"

## D
library(MASS)
library(ElemStatLearn)
library(glmnet)
library(lars)
?cv.glmnet
set.seed(1)

x <- model.matrix(quality~., trainWine)[,-1]
y <- trainWine$quality

#ridge Regression
cv.rigde<-cv.glmnet(x,y, nfolds = 5,alpha = 0)
cv.rigde$lambda.min
model.ridge <- glmnet(x, y, alpha = 0, lambda = cv.rigde$lambda.min)
coef(model.ridge)

#lasso Regression
cv.lasso<-cv.glmnet(x,y, nfolds = 5,alpha = 1)
cv.lasso$lambda.min
model.lasso <- glmnet(x, y, alpha = 1, lambda = cv.lasso$lambda.min)
coef(model.lasso)

## E
testing<- as.data.frame(testWine)[,-32]

#OLS error
lmfit=lm(quality~., data=trainWine)
lmfit$coef  
pred_ols <- predict(lmfit, testing)
mse_ols <- mean((testWine[,32]-pred_ols)^2)
mse_ols

#CP Error

#AIC Error
aic <- lm(quality~ fixed.acidity+
            volatile.acidity+
            residual.sugar+
            free.sulfur.dioxide+
            density+
            pH+
            sulphates+
            Index.9, data=trainWine)
aicpred <- predict(aic, as.data.frame(testing))
mse_aic<- mean((testWine[,32]-aicpred)^2)
mse_aic

#BIC Error
bic <- lm(quality~ fixed.acidity+
            volatile.acidity+
            residual.sugar+
            density+
            pH+
            sulphates, data=trainWine)
bicpred <- predict(bic, as.data.frame(testing))
mse_bic<- mean((testWine[,32]-bicpred)^2)
mse_bic

#ridge error
ridgetrain <- cv.glmnet(x,y, nfolds = 5,alpha = 0)
ridgepred <- predict(ridgetrain, as.matrix(testing))
mse_testing_ridge <- mean((testWine[,32]-ridgepred)^2)
mse_testing_ridge

#lasso error
lassotrain <- cv.glmnet(x,y, nfolds = 5,alpha = 1)
predlasso <- predict(lassotrain,as.matrix(testing))
mse_testing_lasso <- mean((testWine[,32]-predlasso)^2)
mse_testing_lasso



