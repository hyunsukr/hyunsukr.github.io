# spread and gather

# goal is to get data into tidy format.
# often data is not tidy, so you have to do some work
# what is tidy data?
#     each variable has its own column
#     each observation gets its own row, and not multiple rows
#     one datapoint per cell
library(tidyverse)

#gather takes a variable that is spread across multiple columns
# and puts them in a column

data <- tibble(group = sample(c('red', 'green', 'blue'), 100, replace=TRUE), 
               `2011`=runif(100), `2012`=rnorm(100), `2013`=1:100)

data.tidy <- data %>% gather(key="year", value="measurement", -group)

data.tidy <- data %>% gather(key="year", value="measurement", -group) %>%
  mutate(year=as.integer(year))

#spread does the opposite.  If too many variables are put into the 
# same column you can spread them into the columns

data <- tibble(observation=rep(1:10, each=3), 
               meas_var=rep(c('length', 'width', 'height'), times=10), 
               measurement=runif(30))

data.tidy <- data %>% spread(key="meas_var", value="measurement")

