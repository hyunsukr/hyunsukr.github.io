###################################################
###################################################
####################  Joins  ######################
###################################################
###################################################

#Data rarely comes from a single table.  Instead
#we often collect data from multiple sources and
#must merge the data in order to use it.

#joins accomplish this, and much more.


library(tidyverse)
#Let's define two easy tibbles
A <- tibble(x=1:10, y=rnorm(10))
B <- tibble(x=c(1:5, 11:13), z=runif(8))

#let's describe the following
rbind(A, tibble(x=1:10, y=rnorm(10))) %>% inner_join(B)
A %>% inner_join(B)
A
B
A %>% left_join(B)
A %>% right_join(B)
A %>% full_join(B)
A %>% semi_join(B)
A %>% anti_join(B)



#Let's add a little complexity
A <- tibble(x=1:10, y=rnorm(10))
B <- tibble(w=c(1:5, 11:13), z=runif(8))

A %>% inner_join(B, by=c("x"="w"))



#still further complexity
A <- tibble(x=rep(1:5, each=4), y=rnorm(20), b=rep(c('a', 'b', 'c', 'd'), times=5))
B <- tibble(w=c(1:5, 11:13), z=runif(8), f=rep(c('a', 'b', 'c', 'd'), each=2))

A %>% inner_join(B, by=c("x"="w", "b"="f"))







