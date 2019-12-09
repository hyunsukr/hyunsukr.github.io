library(tidyverse)

setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/lect4groupwork")

series <- read_csv('series.csv')
salaries <- read_csv('Salaries.csv')
fielding <- read_csv('Fielding.csv') %>% select(playerID, yearID, stint, teamID, POS)


##########################################################################
##########################################################################
############################ Question 1 ##################################
##########################################################################
##########################################################################

# Using one and only one of each of type of join we discussed 
# in lecture (except full_join), followed by one group_by and 
# one summarize statement, produce a table of the average salary
# over each position in the infield, for players during the year 
# their team competed in the World Series (the final series of the playoffs), 
# excluding infielders who played for teams that did not win 
# at least 2 games.  Calculate averages for the  years 2000 and later.
# You must use a single pipeline to do so.


year <- tibble(x=2000:2019)

tibble(year=2000:2016) %>% 
  left_join(series, by=c("year"="yearID")) %>% 
  anti_join(tibble(wins=0:1), by=c("number_wins"="wins")) %>%  
  semi_join(tibble(round="WS"), by=c("round","round")) %>%
  right_join(fielding, by=c("team"="teamID")) %>% 
  inner_join(salaries, by=c("playerID"="playerID")) %>%
  group_by(POS) %>%
  summarize(mean=mean(salary)) %>% 
  arrange(desc(mean))

series %>%
  semi_join(tibble(year=2000:2016), by=c("yearID"="year")) %>% 
  anti_join(tibble(wins=0:1), by=c("number_wins"="wins")) %>% 
  right_join(tibble(round="WS"), by=c("round", "round")) %>% 
  left_join(salaries, by=c("team"="teamID")) %>% 
  inner_join(fielding, by=c("playerID"="playerID")) %>%
  group_by(POS) %>%
  summarize(mean=mean(salary)) %>% 
  arrange(POS)

series %>%
  right_join(tibble(year=2000:2016), by=c("yearID"="year")) %>% 
  anti_join(tibble(wins=0:1), by=c("number_wins"="wins")) %>%
  semi_join(tibble(round="WS"), by=c("round", "round")) %>%
  inner_join(salaries, by=c("team"="teamID", "yearID"="yearID")) %>%
  left_join(fielding,  by=c("playerID"="playerID")) %>%
  group_by(POS) %>%
  summarize(mean=mean(salary)) %>% 
  arrange(POS)

### Actual Answer ###
series %>%
  right_join(tibble(yearID=c(2000:2016), round=rep("WS"))) %>%
  anti_join(tibble(number_wins = c(rep(0,1), rep(1,1)))) %>%
  inner_join(salaries, by = c("yearID"="yearID", "team"="teamID")) %>%
  left_join(fielding, by =c("yearID" = "yearID", "team"="teamID", "playerID"="playerID")) %>%
  semi_join(tibble(POS=c("1B", "2B", "3B", "C", "P", "SS"))) %>%
  group_by(POS) %>%
  summarize(mean=mean(salary))

#####################################################
########## More detail ##############################
#####################################################
#####################################################

# If you were to do this by hand, you would:
# 1. Look at teams that competed in the world series from 2000 onwards
# 2. Select teams, winners or losers, who won at least 2 games
# 3. For those teams, in the year they competed in the world series,
#    grab the salary information for all infield players
# 4. For each position, calculate the average salary

# reminder: you must use one each of anti_join, left_join, inner_join,
#    right_join, semi_join, followed by one group_by and one summarize.

# Your final table should look like this:

# A tibble: 6 x 2
#POS   mean_salary
#<chr>       <dbl>
#1 1B       3842549.
#2 2B       2443084.
#3 3B       2707716.
#4 C        2733326.
#5 P        3680639.
#6 SS       2972497.

#fun friday activity with friends"
# In addition to the data for this activity, I have uploaded a larger
# dataset (don't use the files in this larger data set for your group
# work, though, because I have modified some of the files to suit this question).
# If one were interested in mean salary of infield positions for relatively
# successful world series contenders, there are several reason why
# our current answer isn't satisfactory (for instance, you might really)
# be interested only in infielders who actually played in the world series
# or maybe infielders who played in the world series and had some measure of
# offensive success (maybe with the exception of pitchers, though one might)
# want to only look at pitchers who had some measure of defensive success.
# With your friends, consider some ways to make these means more informative or
# interesting in ways like those mentioned above.  Perhaps on Saturday, consider
# what other questions might be interesting to ask.