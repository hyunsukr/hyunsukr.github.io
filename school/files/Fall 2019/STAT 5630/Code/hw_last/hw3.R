library(e1071)
library(ElemStatLearn)
library(kernlab)
library(gbm)
library(MASS)
library(glmnet)
library(kknn)
library(class)
library(deldir)
library(lars)
library(PerformanceAnalytics)
library(leaps)
library(ncvreg)
library(party)
library(rpart)
library(tree)
library(ipred)
library(rpart)
library(randomForest)
library(ggplot2)
library(caret)
library(graphics)
library(factoextra)
library(mclust)


set.seed(1)

setwd("/Users/maxryoo/Documents/Fall 2019/STAT 5630/Code/hw_last")
train = read.table("traindata.txt")
pca = prcomp(train[1:57], scale = TRUE)
plot(pca)
fviz_eig(pca)
summary(pca)
colnames(train)
cum_prop <- cumsum(pca$sdev^2 / sum(pca$sdev^2))
last_index = min(which(cum_prop > 0.90))
dr_data <- as.data.frame(pca$x[,1:last_index])
plot <- cbind(dr_data[,1],dr_data[,2], train$V58)
colnames(plot) <- c("PC1", "PC2", "Class")
ggplot(as.data.frame(plot)) + 
  geom_point(aes(PC1,PC2, color=factor(Class)), alpha=0.5) + 
  scale_color_manual(values=c("blue", "red")) + theme_bw() + labs(color="Spam")

## all variables
spam.kmeans.all <- kmeans(pca$x, centers = 2, nstart = 20, trace = TRUE)
spam.kmeans.all$centers
all_variables = cbind(as.data.frame(pca$x), train$V58)
colnames(all_variables) <- c(colnames(pca$x), "Class")
ggplot(all_variables, aes(PC1, PC2, color=factor(Class))) +
  geom_point(alpha = 0.4, size = 3.5) + # true cluster 
  geom_point(col = c("blue", "red")[spam.kmeans.all$cluster]) +
  scale_color_manual(values = c("blue", "red")) + theme_bw() +
  ggtitle("Kmeans of all variables") + labs(color="Spam")

spam.kmeans.dr <- kmeans(dr_data, centers = 2, nstart = 20, trace = TRUE)
spam.kmeans.dr$centers
dr_variables = cbind(dr_data, train$V58)
colnames(dr_variables) <- c(colnames(dr_data), "Class")
ggplot(dr_variables, aes(PC1, PC2, color=factor(Class))) +
  geom_point(alpha = 0.4, size = 3.5) + # true cluster 
  geom_point(col = c("blue", "red")[spam.kmeans.dr$cluster]) +
  scale_color_manual(values = c("blue", "red")) + theme_bw() +
  ggtitle("Kmeans of reduced variables") + labs(color="Spam")

spam.kmeans.two <- kmeans(plot[,1:2], centers = 2, nstart = 20, trace = TRUE)
spam.kmeans.two$centers
ggplot(as.data.frame(plot), aes(PC1, PC2, color=factor(Class))) +
  geom_point(alpha = 0.4, size = 3.5) + # true cluster 
  geom_point(col = c("blue", "red")[spam.kmeans.two$cluster]) +
  scale_color_manual(values = c("blue", "red")) + theme_bw() + 
  ggtitle("Kmeans of two variables") + labs(color="Spam")



#
?Mclust
summary(Mclust(as.data.frame( cbind(dr_data[,1],dr_data[,2])), G =2), 
        parameter=TRUE)
plot(Mclust(as.data.frame( cbind(dr_data[,1],dr_data[,2])), G =2), 
     what="classification")
mclustering = Mclust(as.data.frame( cbind(dr_data[,1],dr_data[,2])), G =2)
data_mclust = mclustering$data
data_mclust_class = mclustering$classification
plot_mclust <- cbind(data_mclust, data_mclust_class, train$V58)
colnames(plot_mclust) = c("V1", "V2", "Class", "True")
ggplot(as.data.frame(plot_mclust), aes(V1, V2, color=factor(True))) +
  geom_point(alpha = 0.4, size = 3.5) + 
  scale_color_manual(values = c("blue", "red")) +
  geom_point(col = c("blue", "red")[as.data.frame(plot_mclust)$Class]) + theme_bw() + 
  ggtitle("MClustering") + labs(color="Spam")


ggplot(as.data.frame(plot_mclust), aes(V1, V2, color=factor(Class))) +
  geom_point() +   scale_color_manual(values = c("blue", "red"))
  
  
as.data.frame(plot_mclust)$Class
as.data.frame(plot_mclust)$True
#Normal mix 

