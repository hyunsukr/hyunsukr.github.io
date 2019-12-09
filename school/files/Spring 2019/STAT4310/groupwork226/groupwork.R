library(tidyverse)


#load data
setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/groupwork226")
load('mnist_subsample.Rdata')
#the dataframe loaded is called mnist_organized.  The columns are:
# digit: the true label of the digit being written
# datapoint: an arbitrary index of the samples in the dataframe
# pixel: a linear indicator of the pixel of interest (images are 28x28 so this ranges from 0 to 783)
# value: grayscale value, ranging from 0 to 255
# x: the horizontal position of the pixel (0 to 27)
# y: the vertical position of the pixel (1 to 28)

# x and y are primarily used for plotting purposes

#use geom_tile() to plot several examples of handwritten digits.
mnist_organized %>%
  filter(digit == 5) %>%
  filter(datapoint == 1) %>%
  ggplot(aes(x=x, y=y)) + geom_tile(aes(fill=value))
  
#use the spread() function to put the pixel values of each observation on a single row.
# you should first remove the x and y columns

mnist_spread <- mnist_organized %>% select(-c(x,y)) %>% spread(pixel, value)
#use mnist_spread to create a vector with the ground truth digits

mnist_label <- mnist_spread %>% select(digit) %>% .$digit #nothing for you to do here.  just run as is


#use mnist_spread to create a matrix with observations on the rows and pixels on the columns
# i.e. remove the digit and datapoint columns.
mnist_label
mnist_pixels <- mnist_spread %>% select(-digit, -datapoint)
  

  
#run PcA on the mnist_pixels.

mnist.pca <- prcomp(mnist_pixels) #fill in function






#this tibble creates a mapping between the pixel number and the x and y location.
# this will be useful for visualizing the principle components (so that you visualize
# them in the shape of the image)

pixel_location_tibble <- tibble(pixel=0:783) %>% 
  mutate(x = pixel %% 28, y = 28 - pixel %/% 28) #nothing to do here, just run (might want to understand though!)





#visualize, with a single pipeline, the influence of each pixel on several principle components.  Use the pixel_location_tibble
# and geom_tile().  the add_column() function will be helpful.

pixel_location_tibble %>% 
  add_column(pc = mnist.pca$rotation[,1]) %>% 
  ggplot(aes(x,y,fill=pc)) + geom_tile()
  #...

pixel_location_tibble %>% 
  add_column(pc = mnist.pca$rotation[,2]) %>% 
  ggplot(aes(x,y,fill=pc)) + geom_tile()
  
  
#visualize, with a single pipeline, a scatterplot of the scores of the first and second principle components
# without knowing the ground truth, try to cluster the first 9 digits.
# your first line of the pipeline will be used to create the appropriate tibble.

tibble(pc1 = mnist.pca$x[,1], pc2=mnist.pca$x[,2]) %>%
  ggplot(aes(pc1,pc2)) + 
  geom_point()

#fill in the tibble function 
  #...

  
  
  
  
#now visualize, with a single pipeline, the scatterplot colored according to the ground truth.  
# How well did you do?

tibble(pc1 = mnist.pca$x[,1], pc2=mnist.pca$x[,2], labels=mnist_label) %>%
  ggplot(aes(pc1,pc2)) +
  geom_point(aes(color=factor(labels)))#fill in the tibble function 
  
#draw back of pca  
# Linear technique
# Dataneeds to be gaussian

# PCA good at dimensionality reduction
library(pixmap)
library(tidyverse)
tf <- read.pnm("att_face/s1/1.pgm")  
plot(tf)  

# @ instead of dolloar if we need to access s4 class







