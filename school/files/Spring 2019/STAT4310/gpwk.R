library(tidyverse)

#Groupwork Question 1
# For the time-period of 2000-2010, calculate, for each team, 
# the average of the per-player median yearly salary-per-game 
# over the players career with that team.

#notes:
# a player who plays for 10 years with a team will have a single median yearly salary per game
# my advice on this or ANY pipeline is to build it step by step, verifying after
#       each step that you have results that you expect

#YOU ARE NOT ALLOWED TO SAVE ANYTHING (in other words, your answer should be a single pipe)

setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310")
salary_games_info <- read_csv('Lect2data.csv')

salary_games_info %>% filter(yearID >= 2000 & yearID <= 2010) %>% group_by(teamID) %>% group_by(playerID) %>%
  summarize(Median=median(salary))

#final?#
salary_games_info %>% filter(yearID >= 2000 & yearID <= 2010) %>% 
  group_by(playerID) %>% 
  mutate(per_player_median = median(salary)) %>% 
  group_by(teamID) %>% 
  mutate(team_average = mean(per_player_median))
  
#Groupwork Question 2
  # Calculate the average year continuity across everybody in baseball in the dataset.
  
#notes:
# as before, this should be a single pipeline

salary_games_info %>% 
  arrange(playerID, yearID) %>% 
  group_by(playerID) %>% 
  mutate(yearContinuity = yearID - lag(yearID)) %>% 
  filter(yearContinuity > 0) %>% summarize(average_yearcont=mean(yearContinuity))

salary_games_info %>% group_by(playerID) %>% arrange(yearID) %>% mutate(yearContinuity = yearID - lag(yearID)) %>% filter(yearID>1985)



  