#Groupwork Question 1
# For the time-period of 2000-2010, calculate, for each team, 
# the average of the per-player median yearly salary-per-game 
# over the players career with that team.

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

library(tidyverse)

salary_games_info <- read_csv('Lect2data.csv')

salary_games_info %>%
  filter(yearID >=2000 & yearID <= 2010) %>%
  select(yearID, teamID, playerID, salary, G) %>%
  mutate(salaryPerGame=salary/G) %>%
  group_by(playerID, teamID) %>%
  summarize(median=median(salaryPerGame)) %>%
  group_by(teamID) %>%
  summarize(mean=mean(median))


salary_games_info %>%
  filter(yearID >=2000 & yearID <= 2010) %>%
  group_by(teamID) %>%
  arrange(teamID, playerID) %>%
  summarize(mean=mean(salary))
#Groupwork Question 2
# Calculate the average year continuity across everybody in baseball in the dataset.


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

# Why does it produce the same result 
salary_games_info %>% 
  group_by(playerID) %>%
  arrange(yearID) %>%
  mutate(yearContinuity = yearID - lag(yearID)) %>% 
  ungroup() %>%
  summarize(average_years_continuity = mean(yearContinuity, na.rm = TRUE))

#Note that this is not the same as:
salary_games_info %>% 
  group_by(playerID) %>%
  arrange(yearID) %>%
  mutate(yearContinuity = yearID - lag(yearID)) %>% 
  summarize(average_years_continuity_per_player = mean(yearContinuity, na.rm=TRUE)) %>%
  summarize(average_years_continuity = mean(average_years_continuity_per_player, na.rm = TRUE))

#why??


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

salary_games_info %>%
  select(yearID, teamID, playerID, salary, G) %>%
  mutate(salaryPerGame=salary/G) %>%
  group_by(playerID, teamID) %>%
  filter(!(max(yearID)<2000 | min(yearID)>2010)) %>%
  summarize(median=median(salaryPerGame)) %>%
  group_by(teamID) %>%
  summarize(mean=mean(median))



