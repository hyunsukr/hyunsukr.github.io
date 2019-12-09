library(tidyverse)
dir <- './'
salaries <- read_csv(paste0(dir, 'Salaries.csv'))
batting <- read_csv(paste0(dir, 'Batting.csv'))
###################################################
############ 2 Categorical Variables ##############
###################################################

#let's start to deal with 2 categorical variables in our plots
#stacked bar chart
salaries %>%
  filter(teamID %in% c('BOS', 'WAS', 'PHI')) %>%
  group_by(teamID, playerID) %>%
  summarize(numYearsPlayed = length(unique(yearID))) %>%
  ggplot(aes(x=numYearsPlayed)) +
  geom_bar(aes(fill=teamID))
#there are various bits of info contained in this chart
#what's easy to see?  What's hard to see?



#relative proportions,
salaries %>%
  filter(teamID %in% c('BOS', 'WAS', 'PHI')) %>%
  group_by(teamID, playerID) %>%
  summarize(numYearsPlayed = length(unique(yearID))) %>%
  ggplot(aes(x=numYearsPlayed)) +
  geom_bar(aes(fill=teamID), position="fill")

#side-by-side 
salaries %>%
  filter(teamID %in% c('BOS', 'WAS', 'PHI')) %>%
  group_by(teamID, playerID) %>%
  summarize(numYearsPlayed = length(unique(yearID))) %>%
  ggplot(aes(x=numYearsPlayed)) +
  geom_bar(aes(fill=teamID), position="dodge")

#let's look at batting
batting %>%
  filter(yearID >= 2000 & yearID <=2010)

#let's plot number of games played
batting %>%
  filter(yearID >= 2000 & yearID <=2010) %>%
  ggplot(aes(x=G)) +
  geom_histogram()

batting %>%
  filter(yearID >= 2000 & yearID <=2010) %>%
  ggplot(aes(x=G)) +
  geom_histogram(binwidth=1)



sewing <- read_csv('Allstits.txt')

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot() + geom_histogram(aes(x=`Stitch Multiple`), binwidth=1)


sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + 
  geom_histogram(bins=40, fill='red', color='black')

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + 
  geom_histogram(bins=40, aes(fill=Book), color='black')

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + 
  geom_histogram(bins=30, aes(fill=Book), color='black', position="dodge")
