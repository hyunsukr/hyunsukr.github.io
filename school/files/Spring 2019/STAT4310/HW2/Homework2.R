library(tidyverse)

setwd("./")
setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/HW2")
airline <- read_csv('airlines.csv')
flightsjan <- read_csv('flights_jan.csv')
airline %>% arrange(IATA_CODE)
flightsjan
names(flightsjan)
## Problem 1
### Part a
airline %>%
  inner_join(flightsjan,  by=c("IATA_CODE"="AIRLINE")) %>%
  group_by(AIRLINE) %>%
  mutate(flightnum = n()) %>%
  inner_join(top_n(count(flightsjan, AIRLINE),10),by=c("IATA_CODE"="AIRLINE")) %>%
  #arrange(desc(n)) %>%
  mutate(distance =  ifelse(DISTANCE > 750, TRUE, FALSE)) %>%
  ggplot(aes(fct_reorder(IATA_CODE, flightnum, .desc=TRUE),
             TAXI_OUT,
             color=distance,
             fill=ALLIANCE)) + 
  geom_boxplot(varwidth = TRUE) +
  scale_x_discrete(labels=(top_n(count(flightsjan, AIRLINE),10))) +
  scale_fill_manual(values=c("#339933","red","#7300e6","white")) + 
  theme_bw() + 
  xlab('Airline (ordered by total number of flights)') + 
  ylab("Taxi time (variable: TAXI_OUT)") + 
  theme(panel.border = element_blank()) + 
  labs(color='distance > 750') +
  labs(fill='alliance') 

### Part b
#There seems to be a lot of information in the plot that we replicated. 
#To some degree it can be seen that it is a little of too much information. 
#There are too many messages trying to displayed, which might hinder a strong 
#message that we were trying to tell. Looking at aspects individually, they all 
#display a clear message. For example take alliance and distance > 750. The alliance 
#for the fill of the box plot could be used to see how the Taxi time differs by 
#which airlines have which alliance. If there was a strong trend it would be easy 
#to see by having the alliance separated by colors. Also, another good aesthetic was 
#the distance > 750. This was good in a sense that it was separated by airline. 
#If we wanted to see which airlines had a higher taxi time based on distance, 
#the information was easily distinguishable. However, something like the overall for 
#all airlines will be hard to picture. The varwidth = TRUE aesthetic was useful especaially
#when looking at only the top 10 proportions. We could see where the data was heavily populated
#There were more aesthetics used and all had their purpose. However, having all of these 
#aesthetics takes away from the big picture. What does the reader get out of the graph? 
#The graph has too many messages #that the reader doesn’t get a clear message. A good 
#strategy to improve the graph might be to simplify the graph down for the purpose 
#of the visualization. If the focus is on a certain aspect, trying to display that
# aspect might be a better idea. 

### Part c
airline %>%
  inner_join(flightsjan,  by=c("IATA_CODE"="AIRLINE")) %>%
  group_by(AIRLINE) %>%
  mutate(flightnum = n()) %>%
  inner_join(top_n(count(flightsjan, AIRLINE),14),by=c("IATA_CODE"="AIRLINE")) %>%
  #arrange(desc(n)) %>%
  mutate(distance =  ifelse(DISTANCE > 750, "Distance above 750", "Distance below 750")) %>%
  ggplot(aes(fct_reorder(IATA_CODE, flightnum, .desc=TRUE),
             TAXI_OUT,
             fill=ALLIANCE)) + 
  geom_boxplot(varwidth = TRUE) +
  facet_grid(.~distance) +
  scale_x_discrete(labels=(top_n(count(flightsjan, AIRLINE),10))) +
  theme_bw() + 
  scale_fill_manual(values=c("#339933","red","#7300e6","white")) + 
  xlab('Airline (ordered by total number of flights)') + 
  ylab("Taxi time (variable: TAXI_OUT)") + 
  theme(panel.border = element_blank()) + 
  theme(legend.position="none") + 
  labs(color='distance > 750')

## Problme 2
### Part a
museum <- read_csv('museums.csv')
museum %>%
  na.omit() %>%
  filter(State != "alaska") %>%
  filter(State != "hawaii") %>%
  filter(Longitude > (-150)) %>%
  filter(Latitude < 60) %>%
  filter(Revenue > 0) %>%
  ggplot() + 
  geom_point(aes(x=Longitude, y=Latitude, color= Revenue)) +
  scale_colour_gradient(low="red",
                         high="yellow",
                         limit = c(1,1e+9),
                         breaks = c(0,1e+3,1e+6,1e+9),
                         trans="log2") +
  theme_bw() +
  theme(panel.background = element_rect(fill = 'BLACK')) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

### Part b
#The main aesthetic being used is the color of the geom_points being based on the Revenue 
#int he data set. As you can see in the image legend the revenue ranges from the color red 
#and yellow. The data underwent a log2 transformation to accurately represent the data points.
#At a first glance, it is hard to make a story out of the image. A clear message is hard to 
#point out. Which states had the highest revenue? Is there a place or location that had a higher
#revenue? This was because the majority of museums were orange and bright yellow. The data 
#points were not that varied. Also there was no distinction of the United States borders. Where 
#do the states end. It seemed like there was no real use for spacial locality for he purpose of 
#this visualization. The message was hard to understand as well. A possibility if wanting to 
#keep location a key factor, could be showing the state borders and categorizing the museums 
#by states and getting a mean value to compare the state’s museums. This way it can be a more 
#clear image and message. Another way would to salvage the x and y axis and graph income vs 
#revenue for the type of museums. Doing this methodology will yield a far more direct message 
#and more pleasing to the eye. 

### Part c
museum %>%
  group_by(Type) %>% 
  arrange(Revenue) %>%
  ggplot(aes(Income, Revenue, color=Type)) + geom_smooth(method=lm, se=F) + 
  theme_bw() + 
  xlab("Income") + 
  ylab("Revenue") + 
  labs(color="Types of Mesuems")
  
  
## Problme 3
### Part a
library(wordcloud2)

setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/HW2/emnlp2014_ageGenderLexica")
emnlp14age <- read_csv("emnlp14age.csv")
#old people
emnlp14age %>% 
  filter(weight >0) %>%
  arrange(desc(weight)) %>% 
  top_n(150) %>% 
  wordcloud2(size=0.4)
#young people
emnlp14age %>% 
  filter(weight < 0) %>%
  mutate(weight = abs(weight)) %>% 
  arrange(desc(weight)) %>% 
  top_n(100)  %>% 
  wordcloud2(size=0.2)

### Threshold comments
#The numbers of words used for the two word clouds were different. The word cloud for old 
#people used to top 150 words. I chose this threshold because after a while the extra words 
#didn’t seem to matter. Having 50 or 100 words the eye still catches the majority of the 
#words because their size doesn’t differ by a big factor. However, at 150 the new couple of
#words that come up change drastically in size and the eye doesn’t catch those words as 
#easily since the size difference is substantial. 200 was overkill in a sense that at 150 
#people wouldn’t care about the remainder of the words and 200 words would just add useless
#words to fill up white space. Therefore 150 was chosen for old people. However, for young 
#people, 100 was chosen. This was because the weights of the words were similar and the logic 
#explained for old people was applicable with the threshold of 100. 

### Part b
#In word clouds the sizes of words tend to mean the significant or prevalance of the word
#When somebody uses wordcloud they automatically imght assume that words that are bigger
#will be more importatnt than the other words. Also color plays a factor as well. What do the
#colors mean? When using word clouds these are the informations that the readers is extracting
#The relative size of the word cloud for the young people showed that a lot of the terms were 
#of equal size. In order to combat this an idea that cam naturally was to square the weights of
#the data to increase the difference in size. However, the interpretation of that change in 
#weights would be that some words showed up more than others. Although we transformed the 
#weights on the world cloud it would look like they are of difference sizes due to the nature 
#of the word sizes. Therefore, a way that could com bat the similar sizes of words and not 
#distort the data would be to color them. Perhaps color some words by the weights. Have a range 
#of values that would be red and a range of values for a different value and have a legend so 
#that when the reader is viewing the word cloud they can understand it better and categorize 
#the words better and not rely entirely on the word cloud. 

                       