library(tidyverse)
setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/Project")
data <- read_csv('country_profiles.csv')

data
#EDA
data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  mutate(Regiongroup = ifelse(grepl("South America", Region), "South America", 
                              ifelse(grepl("Asia",Region),"Asia",
                                     ifelse(grepl("Europe",Region),"Europe",
                                            ifelse(grepl("Africa",Region),"Africa",
                                                   ifelse(grepl("North America", Region),"North America", "Other")))))) %>%
  ggplot() + 
  geom_point(aes(y= GDP1, x=Employment)) + facet_wrap(~Regiongroup,ncol=2)


data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  mutate(Population = log(`Population in thousands (2017)`)) %>%
  mutate(Regiongroup = ifelse(grepl("America", Region), "America", 
                              ifelse(grepl("Asia",Region),"Asia",
                                     ifelse(grepl("Europe",Region),"Europe",
                                            ifelse(grepl("Africa",Region),"Africa","Other"))))) %>%
  ggplot() + 
  geom_point(aes(y= Population, x=Employment)) + facet_wrap(~Regiongroup,ncol=2)





names(data)


data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  mutate(CO2 = log(`CO2 emission estimates (million tons/tons per capita)`)) %>%
  mutate(Regiongroup = ifelse(grepl("America", Region), "America", 
                              ifelse(grepl("Asia",Region),"Asia",
                                     ifelse(grepl("Europe",Region),"Europe",
                                            ifelse(grepl("Africa",Region),"Africa","Other"))))) %>%
  ggplot() + 
  geom_point(aes(y=CO2 , x=Employment)) + facet_wrap(~Regiongroup,ncol=2)

data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  mutate(Mobile = as.numeric(`Mobile-cellular subscriptions (per 100 inhabitants)`)) %>%
  mutate(Regiongroup = ifelse(grepl("America", Region), "America", 
                              ifelse(grepl("Asia",Region),"Asia",
                                     ifelse(grepl("Europe",Region),"Europe",
                                            ifelse(grepl("Africa",Region),"Africa","Other"))))) %>%
  ggplot() + 
  geom_point(aes(y=Mobile, x=Employment)) + facet_wrap(~Regiongroup,ncol=2)

data2 = data %>% select(Region) %>% unique() 


data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  mutate(Internet = log(as.numeric(`Individuals using the Internet (per 100 inhabitants)`))) %>%
  mutate(Regiongroup = ifelse(grepl("America", Region), "America", 
                              ifelse(grepl("Asia",Region),"Asia",
                                     ifelse(grepl("Europe",Region),"Europe",
                                            ifelse(grepl("Africa",Region),"Africa","Other"))))) %>%
  ggplot() + 
  geom_point(aes(y=Internet, x=Employment)) + facet_wrap(~Regiongroup,ncol=2)


names(data)
data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  mutate(Regiongroup = ifelse(grepl("America", Region), "America", 
                              ifelse(grepl("Asia",Region),"Asia",
                                     ifelse(grepl("Europe",Region),"Europe",
                                            ifelse(grepl("Africa",Region),"Africa","Other"))))) %>%
  ggplot() + 
  geom_histogram(aes(x=Employment), binwidth = 5) + facet_grid(.~Regiongroup)


data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Regiongroup =ifelse(grepl("SouthAmerica", Region), "South America", 
                             ifelse(grepl("Asia",Region),"Asia",
                                    ifelse(grepl("Europe",Region),"Europe",
                                           ifelse(grepl("Africa",Region),"Africa",
                                                  ifelse(grepl("NorthernAmerica", Region),"North America", "Other")))))) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  ggplot() +
  geom_point(aes(y = GDP1, x=Employment, size=`Population in thousands (2017)`, fill=Regiongroup),shape=21) +
  scale_size(range = c(1,25)) + 
  theme_bw() + 
  theme(panel.grid.major=element_line(linetype="dotted",color='#b3b3b3')) +
  theme(panel.grid.minor=element_blank()) +
  theme(axis.line=element_line(colour = "black"),
        panel.border=element_blank(),
        panel.background= element_blank()) +
  scale_y_continuous(limits = c(4,20),
                     breaks=c(4,8,12,16,20)) +
  scale_x_continuous(limits = c(65,100),
                     breaks=c(65,70,75,80,85,90,95,100)) +
  ggtitle('Employment vs GDP') + guides(size = FALSE)

data %>% arrange(desc(`Population in thousands (2017)`)) %>%
  filter(`Unemployment (% of labour force)` > 0 ) %>%
  filter(`GDP: Gross domestic product (million current US$)` > 0 ) %>%
  mutate(GDP1 = log(`GDP: Gross domestic product (million current US$)`)) %>%
  mutate(Pop1 = log(`Population in thousands (2017)`)) %>%
  mutate(Regiongroup = ifelse(grepl("America", Region), "America", 
                              ifelse(grepl("Asia",Region),"Asia",
                                     ifelse(grepl("Europe",Region),"Europe",
                                            ifelse(grepl("Africa",Region),"Africa","Other"))))) %>%
  mutate(Employment = 100 - as.numeric(`Unemployment (% of labour force)`)) %>%
  ggplot() +
  geom_smooth(aes(y = GDP1, x=Employment, color=Regiongroup),method=lm,se=FALSE) + 
  scale_colour_manual(labels=c("Africa","Europe","Asia","America","Other"),
                      values=c("Red", "Blue", "Orange","Green","Purple"))
  
