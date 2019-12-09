library(tidyverse)

setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/Lecture12")
load('nytimes.Rdata')


nytimes[50:60, 50:60]

#do pca
#take away frist column since it is the classifying column
nytimes.pca = prcomp(nytimes[,-1])

nytimes.pca$rotation[20:30,1:5]

signif(head(sort(nytimes.pca$rotation[,1], decreasing = TRUE), 30), 2)

signif(head(sort(nytimes.pca$rotation[,1], decreasing = FALSE), 30), 2)

nytibble <- tibble(PCA1=nytimes.pca$x[,1], PCA2=nytimes.pca$x[,2], labels=nytimes[,1])

ggplot(nytibble, aes(x=PCA1, y=PCA2))+
  geom_point(aes(color=labels)) + 
  scale_color_discrete(name="Category") +
  labs(title = "First and second principle components for art and music articles") +
  theme_minimal()
