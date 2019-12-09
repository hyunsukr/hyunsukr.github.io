#So far we have looked at a few different methods for looking at distributions of data
#barplots (typically categorical data), histograms (continuous data) and densities.

library(tidyverse)
flights <- read_csv('flights_jan.csv')


#does the data look approximately normal?
flights %>% filter(DAY<5) %>% ggplot(aes(sample=AIR_TIME)) + geom_qq()

flights %>% filter(DAY<5) %>% ggplot(aes(sample=AIR_TIME)) + geom_qq() + geom_qq_line()


#different visualizations can give us different information about the data
flights %>% ggplot(aes(factor(DAY_OF_WEEK), AIR_TIME)) +  geom_boxplot()

tibble(group=c(rep(c("group1", "group2"), times=100)), x=rnorm(200)) %>% ggplot(aes(group, x)) +  geom_boxplot(notch = TRUE, varwidth = TRUE)

flights %>% ggplot(aes(factor(DAY_OF_WEEK), TAXI_OUT)) +  geom_violin()

flights %>% ggplot(aes(factor(DAY_OF_WEEK), TAXI_OUT)) +  geom_violin(draw_quantiles=c(.25, .5, .75))

flights %>% ggplot(aes(factor(DAY_OF_WEEK), TAXI_OUT)) +  geom_violin(draw_quantiles=c(.25, .5, .75), scale="count")
