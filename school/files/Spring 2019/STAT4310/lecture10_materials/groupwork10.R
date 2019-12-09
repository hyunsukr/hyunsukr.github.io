#Your client would like to understand the differences in the distributions of taxi times between weekends
#and weekdays (they don't care so much about what day it is, but just if it is a weekday or weekend).
#Further, your client is interested in seeing this across different airlines.

#Create a single visualization using a single pipeline that can do this.  As a further challenge,
#your client would like to see the airlines listed in order of the volume of flights, with the
#airline flying the most flights listed first.

#In creating your visualiztion, you should focus on clarity.  While not enough information is obviously
#not ideal, too much information can be confusing.  You should think about the balance between being
#informative about the distrubutions but sensitive to the fact that you are comparing across many distributions.

#this should be done in a single pipeline.

library(tidyverse)
setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/lecture10_materials")
flights <- read_csv('flights_jan.csv')

flights %>% mutate("Weekend" = ((flights["DAY_OF_WEEK"] > 5) = 1)) %>% ggplot(aes(factor(Weekend), TAXI_OUT)) +  geom_violin()

flights %>% filter(DAY_OF_WEEK <= 5) %>% mutate("Weekday" = 1) %>% 
  ggplot(aes(factor(Weekday), TAXI_OUT)) +  geom_violin() + 
  geom_violin(draw_quantiles=c(.25, .5, .75), scale="count")

flights %>% mutate(Weekend =  ifelse(DAY_OF_WEEK > 5, 1, 0)) %>%
  ggplot(aes(factor(Weekend), TAXI_OUT)) +  geom_violin() + 
  geom_violin(draw_quantiles=c(.25, .5, .75), scale="count") + facet_grid(. ~ AIRLINE)



flights %>% mutate(Weekend =  ifelse(DAY_OF_WEEK > 5, 1, 0)) %>% names()




