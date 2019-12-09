#please only load the tidyverse library
library(tidyverse)
#######################################
######## Question 1 ###################
#######################################

#please read in the files as below.  Your code must
#run and produce the result.  If your code does not
#run on the TAs computer your HW solution will not
#be accepted.
setwd("/Users/maxryoo/Documents/Spring 2019/STAT4310/homework1")
master_file <- read_csv('Master.csv')

goalies <- read_csv('Goalies.csv')

coaches <- read_csv('Coaches.csv')

teamvteam <- read_csv('TeamVsTeam.csv')


#For this question, you will find the Master.csv, Goalies.csv, Coaches.csv,
#and TeamVsTeam.csv files handy.

#in general, W stands for win, L stands for loss, SA stands for "shots against",
#GA stands for "goals against.
#Any time you see the word "post" in front of a variable, it means it applies to
#the post season (in other words, statistics during the playoffs).  So postSA
#means shots against in the post season

#Answer the following using a single pipeline

#For seasons 2001 and later, provide the year and name of the coach whose
#team beat Pittsburgh at least 3 times, and whose goalie was born prior to 1974
#and was in at least the second year of a streak in which their ratio of
#[shots against] per [goals against] was at least as high in the postseason 
#as it was in the regular season.


#so to be clear, there are several conditions that need to be met for a coach
# and year to be listed:
#1) season 2001 or later
#2) the goalie has to be born before 1974
#3) the goalie's shots against per goals against is as high or higher in
#     the postseason as it was in the regular season
#4) Condition 3) has to be true for that goalie in the previous season as well
#5) The team that season beat Pittsburgh at least 3 times.
#6) return ONLY the name of the coach and year

#25 points for getting the right answer with a single pipeline.

#Partial credit: MUST BE A SINGLE PIPELINE!  No partial credit for multiple pipelines
#1pt for getting 1)
#1pt for getting 2)
#3pts for getting 3) but not 4)
#6pts for getting 3) and 4)
#2pts for getting 5)
#2pts for getting 6)

#total possible partial credit: 12 pts
coaches %>%
  inner_join(goalies, by=c('year','tmID','lgID','stint')) %>%
  filter(year >= 2001) %>%
  inner_join(master_file,by=('playerID'='playerID')) %>%
  filter(birthYear < 1974) %>%
  mutate(ratioSG = SA/GA) %>%
  mutate(ratioPSG = PostSA/PostGA) %>%
  filter(ratioPSG > ratioSG) %>%
  arrange(playerID, year) %>%
  group_by(playerID) %>%
  mutate(yearContinuity = year - lag(year)) %>%
  filter(yearContinuity == 1) %>%
  inner_join(teamvteam, by=c('year','lgID','tmID')) %>%
  filter(oppID == 'PIT' & W.y >= 3) %>%
  ungroup(playerID) %>%
  select(coachID.x, year) %>%
  distinct()

"
# A tibble: 2 x 2
coachID.x   year
<chr>      <int>
1 burnspa01c  2002
2 tortojo01c  2003
"
#######################################
######## Question 2 ###################
#######################################

#replicate the plot in the file LifeExpectancy.png.  Additionally,
#write down every aesthetic for the geom that you used, and indicate if
#for this plot, if it is mapped from the data or not.  You will find the
#populationLifeExpectancy.Rdata and countries.Rdata files helpful.  You can
#load the data from the .Rdata files by simply typing load(filename).
#Do NOT load them as some_variable <- load(filename)

#15 total points for the replication
#10 total points for getting the mappings correct

load('countries.Rdata')
load('populationLifeExpectancy.Rdata')

library(plotly)
require(scales)

ggplot(countries %>% arrange(desc(Population)) 
       , aes(x =GDPperCapita, y=LifeExpectancy)) +
  geom_point(aes(size = Population, fill = Region),shape=21) +
  scale_fill_manual(values=c("#ff6666", #red
                             "#e6e600", #darker yellow
                             "#FFFF00", #yellow
                             "#ff9966", #beige
                             "#66ff66", #Green
                             "#56B4E9", #big BLue
                             "#1ad1ff")) + #light blue
  scale_y_continuous(limits = c(20,90),
                     breaks=c(20,30,40,50,60,70,80,90)) +
  scale_x_continuous(limits = c(500,128000),
                     trans = log2_trans(),
                     breaks = c(500,1000,
                                2000,4000,
                                8000,16000,
                                32000,64000,
                                128000),
                     labels = c("500", "1000",
                                "2000", "4000",
                                "8000","16k",
                                "32k","64k",
                                "128k")) +
  scale_size(range = c(1,15)) + 
  theme_bw()+
  theme(panel.grid.minor = element_blank()) +
  theme(panel.grid.major = element_line(colour = 'grey', linetype="dotted")) +
  xlab('Income per person, GDP/capita in $/year adjust for inflation & prices') + 
  ylab('') + 
  ggtitle("Life expectancy, years") +
  theme(legend.position="none") +
  theme(axis.line = element_line(colour = "black"),
        panel.border = element_blank(),
        panel.background = element_blank())

## Correction for above homework 
## Only dedcuted for no list of mapping...
## X axis = GDPperCapita
## Y axis = LifeExpectancy
## Size = Population (Size doesn't need to exactly match since the data give was different)
## ## Professor said it was okay
## ## Size had a scale of 1,15
## X axis was transformed using log2 function
## Color = Region
## ## List of each color next to hex values shown inside of the code
## Theme was changed as well as the naming of axis to match the visualization given 
## ## All theme elements were not directly from the data, but just helped in visualization of the data
## ## ## Made dotted line for the lines and line color changed to grey
## ## ## Took out the legend since given visualization didn't have them.
## Scale and Range were set differently for both x and y axis to match the visulization given
## The shape of the point was set to 21


