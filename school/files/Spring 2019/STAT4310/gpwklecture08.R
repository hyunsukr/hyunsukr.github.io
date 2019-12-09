library(tidyverse)

#data
salaries <- read_csv('/Users/maxryoo/Documents/Spring 2019/STAT4310/lecture08/Salaries.csv')
batting <- read_csv('/Users/maxryoo/Documents/Spring 2019/STAT4310/lecture08/Batting.csv')


#####################################################
############### Question 1###########################
#####################################################


#Construct a scatterplot of players games played by at bats
#for seasons 2001-2004.  Encode lgID (league ID) in a reasonable way
#in this scatter plot.

batting %>% filter(yearID <= 2004) %>% filter(yearID >= 2001) %>% 
  ggplot() + geom_point(aes(G, AB,color=lgID) ,alpha=.2) + facet_grid(.~lgID)

batting %>% filter(yearID <= 2004) %>% filter(yearID >= 2001) %>% 
  ggplot() + geom_point(aes(G, AB, color=lgID),alpha=.2) + facet_grid(.~lgID)

#####################################################
############### Question 2###########################
#####################################################

#There is one trend that makes intuitive sense.  The more
#games you play, the more at bats you have.  There is another
#trend that is not as intuitive.  Isolate that trend by
#by filtering your data.  Plot the results.  Any interesting
#trends when you color by league?

batting %>% filter(yearID <= 2004) %>% filter(yearID >= 2001) %>% filter(AB < 10) %>%
  ggplot(aes(G, AB, color=lgID)) + geom_point(alpha= 0.5)


#####################################################
############### Question 3###########################
#####################################################

#Our data is technically not continuous.  nobody has a partial game
#or a partial at bad on their record.  What are some issues with this?
#it is especially noticable when you are zoomed in on your data set.



#We can fix this by jittering the data a little.  Replace the geom_point
#command with geom_jitter(#insert aes or other statements here as well)
#what happens?

batting %>% filter(yearID <= 2004) %>% filter(yearID >= 2001) %>% filter(AB < 10) %>%
  ggplot(aes(G, AB, color=lgID)) + geom_jitter(alpha= 0.2)

batting %>% filter(yearID <= 2004) %>% filter(yearID >= 2001) %>% 
  ggplot() + geom_point(aes(G, log(AB), color=lgID),alpha=.2) + facet_grid(.~lgID)


batting %>% filter(yearID <= 2004) %>% filter(yearID >= 2001) %>% 
  ggplot() + geom_point(aes(G, AB^0.5,color=lgID) ,alpha=.2)

#####################################################
############### Key idea ############################
#####################################################

#when we tried to find a good cutoff for our data, 
#the interaction between the two variables made this
#somewhat challenging.  But remember, the variables
#are only there because we collected them like that,
#not because they make the most sense for our purposes.
#can you come up with a good function of your variables
#such that the two trends in your original graph become
#more easily separated?

#you can replace the y aesthetic in your current formula
#with the transformation you are proposing.  you do not
#need to create a new variable in the pipeline.

