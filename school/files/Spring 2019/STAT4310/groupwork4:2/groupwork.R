library(tidyverse)
setwd('/Users/maxryoo/Documents/Spring 2019/STAT4310/groupwork4:2')
data <- read_csv("personality_IDKs.csv")
data
head(data)

data %>%
  ggplot(aes(x=Age)) + geom_bar(aes(fill = PartyID), position = "fill") + facet_grid(.~Income)


names(data)
data %>%
  select(IN12)

data %>%
  ggplot(aes(x=Pokemon)) + geom_bar(aes(fill = PartyID),position="fill") + facet_grid(.~CatDog)

data %>%
  select(HarryPotter)

data %>%
  ggplot(aes(x=HarryPotter)) + geom_bar(aes(fill = CatDog) , position ="fill")

data %>%
  names()

data %>%
  ggplot(aes(x=CatDog)) + geom_bar(aes(fill=Pokemon), position="fill") + facet_grid(.~HarryPotter)

data %>%
  select(Pokemon) %>%
  filter(!is.na(Pokemon) == "")
