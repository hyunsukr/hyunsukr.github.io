#starting to look at pipelines
library(tidyverse)

salary_games_info <- read_csv('Lect2data.csv')


head(salary_games_info)

##############################################################
##############################################################
################### Ceci n'est pas une pipe ##################
##############################################################
##############################################################

salary_games_info %>% head()

salary_games_info %>% head() %>% tail(3)

tail(head(salary_games_info), 3)

salary_small_save <- salary_games_info %>% head() %>% tail(3)


##############################################################
##############################################################
######################## SUMMARIZE ###########################
##############################################################
##############################################################

salary_games_info %>% 
  summarize(count=n())

salary_games_info %>% 
  summarize(average_salary=mean(salary))

salary_games_info %>% summary()

salary_games_info %>% 
  summarize(average_salary=mean(salary)) %>% is_tibble()

salary_games_info %>% summary() %>% is_tibble()

##############################################################
##############################################################
########################## FILTER ############################
##############################################################
##############################################################

salary_games_info %>% filter(yearID > 1986 & yearID <= 2000)

salary_games_info %>% filter(yearID > 1986 & yearID <= 2000) %>% tail()

##############################################################
##############################################################
######################### ARRANGE ############################
##############################################################
##############################################################

salary_games_info %>% filter(yearID > 1986 & yearID <= 2000) %>% arrange(desc(yearID))

salary_games_info %>% filter(yearID > 1986 & yearID <= 2000) %>% arrange(desc(yearID), salary)

##############################################################
##############################################################
######################## GROUP_BY ############################
##############################################################
##############################################################

salary_games_info %>% 
  group_by(playerID) %>% 
  summarize(count=n())


salary_games_info %>% 
  group_by(playerID) %>% 
  summarize(count=n()) %>% 
  arrange(desc(count))

salary_games_info %>% 
  group_by(playerID) %>% 
  summarize(numYearsPlayed = length(unique(yearID)), count=n())

salary_games_info %>% 
  group_by(playerID) %>%
  arrange(yearID) %>%
  mutate(yearContinuity = yearID - lag(yearID)) %>% 
  filter(yearID>1985)



##############################################################
##############################################################
######################### MUTATE #############################
##############################################################
##############################################################

salary_games_info %>% mutate(sqrt_games = sqrt(G))

salary_games_info %>% mutate(atbats_per_game = AB/G)
