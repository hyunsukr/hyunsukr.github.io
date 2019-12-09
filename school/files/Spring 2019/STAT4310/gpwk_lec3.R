library(tidyverse)

#Groupwork Question 1
# For the time-period of 2000-2010, calculate, for each team, 
# the average of the per-player median yearly salary-per-game 
# over the players career with that team.

setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310")
salary_games_info <- read_csv('Lect2data.csv')

salary_games_info %>% 
  filter(yearID >= 2000 & yearID <= 2010) %>% 
  group_by(playerID, teamID) %>% 
  mutate(per_player_median = median(salary)) %>% 
  group_by(teamID) %>%
  mutate(team_average = mean(per_player_median)) %>% filter(teamID == "BAL")


#notes:
# a player who plays for 10 years with a team will have a single median yearly salary per game
# my advice on this or ANY pipeline is to build it step by step, verifying after
#       each step that you have results that you expect

#YOU ARE NOT ALLOWED TO SAVE ANYTHING (in other words, your answer should be a single pipe)

#######################################################
#######################################################
#Further clarification for question 1:
  
#If you were doing this by hand, you would
#-- calculate a salary per game for each player, and each year.
#------if a player played for more than 1 team in a year, you would
#      calculate a salary per game for each team the player played on
#-- for each player, you would calculate their median salary per game.
#      If they played for multiple teams, you would calculate their median
#      for each team
#-- for each team, calculate the average of the medians from the
#      previous step
#######################################################
#######################################################

salary_games_info <- read_csv('Lect2data.csv')

salary_games_info %>%
  

  
  
  
  
#Groupwork Question 2
  # Calculate the average year continuity across everybody in baseball in the dataset.

salary_games_info %>% 
  arrange(playerID, yearID) %>%
  group_by(playerID) %>% 
  mutate(yearContinuity = yearID - lag(yearID)) %>% 
  filter(yearContinuity > 0) %>%
  summarize(average_yearcont=mean(yearContinuity)) %>%
  summarize(avg = mean(average_yearcont))
  
#notes:
# see the lecture 2 notes for the definition of year continuity
# as before, this should be a single pipeline

#######################################################
#######################################################
#Further clarification for question 2:

#If you were doing this by hand, you would
#-- calculate the year continuity for every player and every year
#      the player played
#-- remove any NAs
#-- calculate the average of the year continuity variable.
#-- this will produce a single number
#######################################################
#######################################################
  
salary_games_info %>%
  
  

  
#Groupwork Question 3
# This one is super similar to question 1, so we start by 
#  reiterating question 1.
# For the time-period of 2000-2010, calculate, for each team, 
#  the average of the per-player median yearly salary-per-game 
#  over the players career with that team.
  
# The difference now, is that, to calculate the median salary
#  per game, you would consider the entire career (defined with
#  respect to a single team) of a player if any part of that career
#  falls in the desired year time frame.
  
#notes:

#YOU ARE NOT ALLOWED TO SAVE ANYTHING (in other words, your answer should be a single pipe)

