#part 1
#make a scatterplot of "data3" in the file "data3.Rdata".  map z to color.
#you should adjust the size of the dots to better see the colors.
#Use the principles discussed in class on Tuesday to choose appropriate colors.
#What is the principle, and how did it affect your plot?

library(tidyverse)
setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/groupwork_16")
load('data3.Rdata')
data3

ggplot(data3, aes(x=x, y=y)) +
  geom_point(aes(color=z), size=4) + scale_color_gradient2(low="red",high="blue",mid="white",trans="log10",midpoint=median(data3["z"][[1]]))

data3 %>%ggplot(aes(x =x, y=y)) +
  geom_point(aes(color=log(z)),size=4) +
  scale_color_gradient2(low="blue",mid='green', high="red", midpoint=0)


#part 2:
#Plot matrix 1 and matrix 2 found in "mat1.Rdata" and "mat2.Rdata", respectively, using
#geom_tile.
#Use the principles discussed in class on Tuesday to choose appropriate colors.
#What was the principle?  How does that impact the choices you make?
#for the adventurous, read in mat1.csv and mat2.csv instead of mat1.Rdata and mat2.Rdata,
#and shape the resulting data frame so that it is appropriate for plotting with geom_tile.

load("mat1.Rdata")
load("mat2.Rdata")
median(mat1["intensity"][[1]])
mat2
mat1 %>% ggplot(aes(x=rows, y=columns)) +
  geom_tile(aes(fill=intensity)) + scale_fill_gradient2(low="red",high="blue",mid="white",midpoint=median(mat1$intensity))

mat2 %>% ggplot(aes(x=rows, y=columns)) +
  geom_tile(aes(fill=intensity)) + scale_fill_gradient(low="red",high="blue")
