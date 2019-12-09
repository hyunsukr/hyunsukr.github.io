library(tidyverse)

#data
salaries <- read_csv('/Users/maxryoo/Documents/Spring 2019/STAT4310/lecture08/Salaries.csv')
batting <- read_csv('/Users/maxryoo/Documents/Spring 2019/STAT4310/lecture08/Batting.csv')



#layering

salaries %>% filter(lgID=="NL") %>%
  ggplot()

#setting up the scales and annotations
#aes(teamID, salary) is saying that we want teamID
# and salary mapped to x and y.
# note that this pipeline takes the x and y values and
# sets up the annotations for the plot (x axis, y axis, background)
# at this point, the plot has no idea what we are going to be doing 
# in terms of mapping from the data to a geometry (point, bar etc)
salaries %>% filter(lgID=="NL") %>%
  ggplot(aes(teamID, salary))


#now we tell it we want to map these to points.
salaries %>% filter(lgID=="NL") %>%
  ggplot(aes(teamID, salary)) + geom_point()

#For the plot as it currently stands, what elementary perceptual elements
#are currently being mapped to?  Which are still available for us to map to?

#https://ggplot2.tidyverse.org/reference/


#first, let's change the colors of the points to blue
#note that the elementary perceptual task of color in this
#case is not being derived from the data.  A point is blue
#no matter what the associated covariates are.
#so this specification goes outside of an aesthetic mapping
salaries %>% filter(lgID=="NL") %>%
  ggplot(aes(teamID, salary)) + geom_point(color='blue')

#we can change size, and alpha value, etc.
salaries %>% filter(lgID=="NL") %>%
  ggplot(aes(teamID, salary)) + geom_point(color='blue', size=2, alpha=.2)



#but these qualities can come from the data itself.  so to determine
#the color, for instance, we first look at some covariate of the data point.
salaries %>% filter(lgID=="NL", yearID<2016, teamID!="CLE") %>% left_join(batting) %>%
  ggplot(aes(teamID, salary)) + geom_point(aes(color=G))

#ggplot does intelligent things like mapping what it sees as a continuous variable (int, for instance)
#to a continuous color scale (light blue to dark blue).  Note what happens if we tell it to treat
#G as a factor
salaries %>% filter(lgID=="NL", yearID<2016, teamID!="CLE") %>% left_join(batting) %>%
  ggplot(aes(teamID, salary)) + geom_point(aes(color=factor(G)))


##################### tip of the day ###############################
#what if we want to preserve global aspects of our variable but don't care about local structure?
salaries %>% filter(lgID=="NL", yearID<2016, teamID!="CLE") %>% left_join(batting) %>%
  ggplot(aes(teamID, salary)) + geom_point(aes(color=cut_number(G, 5)))


