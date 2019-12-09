library(tidyverse)
library(maps)
library(mapproj)


#load the museum data
setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/GroupworkLec17")
museums <- read_csv("museums.csv")
#Each plot below should be a geographic plot

# 1) Using the state data, make a plot in which you color each state by the number of museums
#in that state.
us_data <- map_data("state")
names(museums)
count(museums, State)$State
us_data %>%
  inner_join(count(museums,State), by=c("region"="State")) %>%
  ggplot(aes(long,lat,group=group,fill=n)) + geom_polygon(color="black")

# 2) Make a plot of average income of museums by state

museums %>% 
  group_by(State) %>% 
  summarize(avg = mean(Income))

# 3) Is this satisfactory?  What should you do to make this more informative?
#     This should be a small change from #2.



# 4) Now plot the locations of the Natural History museums.  Indicate their revenue.
