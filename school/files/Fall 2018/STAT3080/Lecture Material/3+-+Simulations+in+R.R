
#########################################################################
#                                                                       #
#  Simulations in R                                                     #
#                                                                       #
#########################################################################

library(car)
library(ggplot2)

#  One of the powerful abilities of R is quick computation, which       #
#  allows users to simulate outcomes and results. Many statistical      #
#  results are based on the idea of repeated sampling, which is a rare  #
#  occurrence in real life. However, R gives users the ability to       #
#  simulate repeated sampling and to view the results.                  #

###########
#  Loops  #
###########

#  There are several ways to run simulations. One of the most basic is  #
#  using a loop, which repeats a certain process over and over. There   #
#  are two types of loops - for loops and while loops. The former is    #
#  used when there is a specific number of times that the process       #
#  should be repeated. While loops continue to repeat until a certain   #
#  condition is satisfied.                                              #
#                                                                       #
#  A for loop is composed of five main pieces - the for statement, the  #
#  index variable, the in statement, the vector of values for which     #
#  the for loop should run, and the code to be repeated. The index      #
#  variable can either be used in the repeated code or not.             #

for(i in 1:5) i
for(i in 1:5) print(i)

#  If the code to be repeated consists of more than one line, curly     #
#  brackets are used to define the section of code to be repeated.      #

j <- 10
for(i in 1:5){
  print(j)
  j <- j+1
}

j <- 10
for(i in 1:5){
  j <- j+1
  print(j)
}

#  If a value is being calculated in the loop that needs to be saved,   #
#  it is best practice to create a vector to record the values before   #
#  beginning the loop.                                                  #

j <- 10
new_vect <- NULL
for(i in 1:5){
  new_vect[i] <- j
  j <- j+1
}
new_vect

j <- 10
new_vect <- rep(0,5)
for(i in 1:5){
  new_vect[i] <- j
  j <- j+1
}
new_vect

#  A user may want to do different things within the process being      #
#  repeated within the loop depending on certain values that result.    #
#  In this case the if() and else() functions can be used within the    #
#  loop. These functions are different from the ifelse() function.      #

Davis
bmi <- NULL
Davis[1,] == "M"

for(i in 1:200){
  if(Davis[i,1] == "M")
  {bmi[i] <- Davis$repwt[i]/(Davis$repht[i]/100)^2}
  else{bmi[i] <- Davis$weight[i]/(Davis$height[i]/100)^2}
}
bmi

bmi2 <- ifelse(bmi<18.5,"under","not")
bmi2

#  A while loop is composed of three main pieces - the while statement, #
#  the condition, and the code to be repeated.                          #

j<-10
while(j<12){
  j <- j+1
  print(j)
}

#  No matter which type of loop is being used, users can include        #
#  options in their loops to stop the loop under certain conditions or  #
#  to move onto the next iteration.                                     #

j <- 10
new_vect <-NULL
for(i in 1:5){
  new_vect[i] <- j
  j <- j+1
  if(j==13){break}
}
new_vect

j <- 10
new_vect <- rep(0,5)
for(i in 1:5){
  if(j==13){next}
  new_vect[i] <- j
  j <- j+1
}
new_vect

j <- 10
new_vect <- rep(0,5)
for(i in 1:5){
  j <- j+1
  if(j==13){next}
  new_vect[i] <- j
}
new_vect

j<-10
while(j<20){
  j <- j+1
  print(j)
  if(j==14){break}
}

j<-10
while(j<20){
  j <- j+1
  if(j==14){next}
  print(j)
}

#  Loops can be nested so that one runs inside another.                 #

A <- matrix(1:6, nrow=2, ncol=3, byrow=T)
A
new_vect <- NULL
k<-1
for(i in 1:3){
  for(j in 1:2){
    new_vect[k]<-A[j,i]
    k<-k+1
  }
}
new_vect
## example ##

Vocab[1:5,]
ifelse(Vocab$year==2004,print("hi"),print("no"))
yrs <-sort(unique(Vocab$year))
yrs
avg_mat <- matrix(nrow=16, ncol=3)
for(i in 1:16){
  v_sub <- Vocab[Vocab$year==yrs[i],]
  avg_mat[i,2] <- mean(v_sub$education)
  avg_mat[i, 3] <- mean(v_sub$vocabulary)
  avg_mat[i,1] <- yrs[i]
}
avg_mat

#  Additional example:                                                  #
#  The dataset ChickWeight records the weights of 50 chicks from the    #
#  time of birth until 21 weeks old at two week intervals. Write a      #
#  loop to create a 50x3 matrix that records the ID number for each     #
#  chick and its average weight and standard deviation over the study.  #



#  Additional example:                                                  #
#  Update your loop to create a 50x4 matrix that records the ID number  #
#  for each chick, its average weight and standard deviation over the   #
#  study, and the diet it received.                                     #



#  Additional example:                                                  #
#  Write a loop that uses your 50x4 matrix and creates a 4x5 matrix     #
#  that records the diet number, the mean and standard deviation of     #
#  the average weights of the chicks on that diet, and the mean and     #
#  standard deviation of the standard deviations of the chicks on that  #
#  diet.                                                                #



#  Additional example:                                                  #
#  Write a loop that uses the ChickWeight dataset and creates a 4x3     #
#  matrix that records the diet number and the mean and standard        #
#  deviation of all the weights recorded for that diet.                 #



#######################
#  apply() functions  #
#######################

#  Many of the results produced by loops can be accomplished in         #
#  another way and loops are comparatively slow, so many users prefer   #
#  to avoid loops when possible. One of the main ways to avoid using    #
#  loops is using the apply() function. Recall that the apply()         #
#  function applies the specified function to either all the rows or    #
#  all the columns of a matrix and returns a vector or list.            #
#                                                                       #
#  In fact, there are four apply functions - apply(), lapply(),         #
#  sapply(), and tapply(). The lapply() function applies the specified  #
#  function to every element in a list and returns a list. The sapply() #
#  function applies the specified function to every element of a list   #
#  and returns a vector.  The tapply() function applies the specified   #
#  function for defined groups in a vector and returns an array. The    #
#  by() function uses tapply().                                         #

## lapply and sapply
list1 <- list(1:7, c(2,7,9,12)^2, 1/(1:10))
list1
list1[2]
list1[2][[1]][[3]]
list1[2][[1]][[3]]
list1[3][[1]][[2]] + list1[3][[1]][[1]]
lapply(list1,sum)
lapply(1:length(list1), function(x) list1[x][[1]][[2]] + list1[x][[1]][[1]])
lapply(1:length(list1), function(x) 1)

lapply(list1, sum)
sapply(list1, sum)
class(1:10)
sapply(1:10, function(x) 1)
sapply(1:10, function(x) 2)
sapply(1:10)
(1:10)[3]
Vocab[1:3, ]

## tapply
Davis
tapply(Davis$weight, Davis$sex, sum)

tapply(Vocab$education, Vocab$vocabulary, mean)

Vocab[Vocab$year == 1974,]

yrs
class(Vocab$year == 1974)
yrs[2]
Vocab[1,2]
Vocab[2]
Vocab[1:3]
names(Vocab)
class(Vocab$year == 1976)
yrs
sep.list <- lapply(1:length(yrs), function(x) Vocab[Vocab$year == yrs[x],])
sep.list
sep.list2 <- lapply(1:length(yrs), function(x) Vocab[Vocab$year == yrs[x],]$sex)
sep.list2[1]
yrs[1]
sapply(sep.list, function(x) cor(x$education, x$vocabulary))[2]
sep.list[1]
sep.list[1]
sep.list[[1]]$education
sapply(sep.list, function(x) mean(x$education))
sapply(sep.list, sum)
sep.list

length(sep.list)

listhey<- 1:10
mean(listhey)
#  Additional example:                                                  #
#  Use the apply() functions to create the 50x4 matrix that records     #
#  the ID number for each chick, its average weight and standard        #
#  deviation over the study, and the diet it received.                  #



#  Additional example:                                                  #
#  Use the apply() functions and your 50x4 matrix to create the 4x5     #
#  matrix that records the diet number, the mean and standard           #
#  deviation of the average weights of the chicks on that diet, and     #
#  the mean and standard deviation of the standard deviations of the    #
#  chicks on that diet.                                                 #



#  Additional example:                                                  #
#  Use the apply() functions and the ChickWeight dataset to create the  #
#  4x3 matrix that records the diet number and the mean and standard    #
#  deviation of all the weights recorded for that diet.                 #



#################
#  Replication  #
#################

#  Another useful tool for simulations and alternative to loops is      #
#  the replicate() function. This function evaluates the expression     #
#  specified the specified number of times and returns a matrix with    #
#  a column containing the results from each replication.               #

replicate(5, rnorm(10)) #this replicates rnorm(10) 5 times #
replicate(5, rnorm(10, 2, 1.6))
replicate(5, runif(10))

#  Additional example:                                                  #
#  Because you have noticed that sometimes you feel taller and          #
#  sometimes you feel shorter, you decide to do a study to see if your  #
#  height fluctuates throughout the day. For a 7-day period, you are    #
#  going to measure your height at 4 randomly selected hours each day.  #
#  You will measure exactly on the hour selected. Use the replicate()   #
#  function to select the times at which you will measure.              #
#  Hint: Incorporate either the floor() or ceiling() function with a    #
#        distribution function.                                         #



##############
#  Sampling  #
##############

#  If a simulation requires sampling from a given set of data instead   #
#  of generating random values, the sample() function can be used. The  #
#  inputs for this function are the vector of values from which to      #
#  sample, whether to replace the values, and how many values to draw.  #
#  The defaults are without replacement sampling and the number of      #
#  values in the original vector.                                       #

wtdata <- Davis$weight
class(wtdata)
sample(Davis$weight)
sample(wtdata)
sample(wtdata, 10)
sample(wtdata, 10, replace=TRUE)

#  The sample() function can be used within the replicate() function    #
#  to generate repeated samples.                                        #

#  Additional example:                                                  #
#  Use the replicate() and sample() functions to determine the 4 times  #
#  at which you will measure your height on each of the 7 days.         #
#  Hint: You will no longer need the distribution function.             #



#  Additional example:                                                  #
#  Use the sample() function to select a sample of 15 unique birth      #
#  weights of the chicks studied in the ChickWeight dataset.            #



#  Additional example:                                                  #
#  Use the sample() function to select a sample of 15 unique chick IDs. #



#  Additional example:                                                  #
#  Use the sample of 15 unique chick IDs to subset the 50x4 matrix of   #
#  ID number, average weight and standard deviation over the study,     #
#  and the diet to just show the selected chicks.                       #



##################
#  Random seeds  #
##################

#  When using any random generating function in R, evaluating the same  #
#  command multiple times will yield different results. Often, it is    #
#  important to be able to reproduce results. To generate the same      #
#  random values each time a command is run, the random generation      #
#  seed can be set by using the set.seed() function. There is one       #
#  required input -- the seed. It is common practice to use a relevant  #
#  value (lucky number, birth date, address, etc.) to protect against   #
#  searching for an optimal sample.                                     #
#                                                                       #
#  Seeds operate in a defined order, so once the seed is set, the next  #
#  random generation commands will use the next seeds in that order.    #
#  Thus, setting the seed once at the beginning of a program will give  #
#  the same random values each time the program is run, but each        #
#  command within the program will generate different results. To       #
#  yield the same values each time a random generation command is run,  #
#  the set.seed() function must be rerun prior to each command.         #

## Without a set seed
sample(wtdata,10)
sample(wtdata,10)

## With a set seed specified once
set.seed(5)
sample(wtdata,10)
set.seed(5)
sample(wtdata,10)

set.seed(5)
sample(wtdata,10)
sample(wtdata,10)

## With a set seed specified each time
set.seed(5)
sample(wtdata,10)

set.seed(5)
sample(wtdata,10)

## Generate 10 random samples of size 48 from all #
# Vocab respondents and record each selected #
# repondent's vocabular score #
set.seed(19981218)
replicate(10, sample(Vocab$vocabulary, 48))

## Clicker ##
#what data frame to store this answer in?#
# A. Vector       #
# B. Matrix (Correct answer)          #
# C. Dataframe          #
# D. List             #
# E . Other           #


## Genearte 10 samples of size 48 from all vocab#
#respondents and record each selected respondent's year, #
#education level, and score. These values should be able to be linked as#
#from the same respondent. #

replicate(10, sample(Vocab, 48))
Vocab[sample(nrow(Vocab), 48), c(1,3,4)]

Vocab[sample(nrow(Vocab), 48), c(1,3,4)]

#############################
#  Monte Carlo simulations  #
#############################

#  Monte Carlo simulation is the process of using repeated sampling     #
#  to determine some behavior or characteristic. This type of           #
#  simulation can be used in many different ways.                       #
#                                                                       #
#  Many applications of Monte Carlo sampling will use the population    #
#  or an appropriate pseudo-population to generate an estimated         #
#  sampling distribution of a relevant statistic that can then be       #
#  explored. One example in this category is to demonstrate and         #
#  understand the Central Limit Theorem.                                #
#                                                                       #
#  Suppose that we have a population from which we plan to take a       #
#  random sample and use the Central Limit Theorem to test the mean.    #
#  The distribution of our population is unknown, but we think that it  #
#  is similar to the chi-squared distribution with four degrees of      #
#  freedom. One important question is how large of a random sample is   #
#  needed from the population for the Central Limit Theorem to hold.    #
#  This question can be answered using a Monte Carlo simulation that    #
#  estimates the sampling distribution of the mean at various sample    #
#  sizes for evaluation of approximate normality.                       #

## First plot the chi-squared population distribution
Xdata2 <- data.frame(X=c(0,20))
dist2 <- ggplot(Xdata2, aes(x=X))
dist2 + stat_function(fun=dchisq, args=list(df=4))

## Determine the number of repeated samples to draw and parameter values
K <- 10000
a <- 4

## Draw 10,000 samples of size 5 from the population distribution
samps <- replicate(K, rchisq(5,a))
samps[,1:10]

## Determine the sample mean from each random sample
means5 <- apply(samps,2,mean)

## Create a QQ plot of the resulting sample means
mean_data <- data.frame(X=means5)
y <- quantile(mean_data$X, c(0.25, 0.75)) 
x <- qnorm(c(0.25, 0.75))  
slope <- diff(y)/diff(x) 
int <- y[1] - slope*x[1] 

ggplot(mean_data, aes(sample = X)) + stat_qq() + 
  geom_abline(intercept=int, slope=slope) + labs(title="n=5")

#  If we want to repeat this process with other sample sizes, we can    #
#  write a for loop instead of writing the same code several times.     #

## Repeat this process with sample sizes of 10, 15, 30, 40, and 50
for (i in c(10,15,30,40,50)){
samps <- replicate(K, rchisq(i,a))
means <- apply(samps,2,mean)
assign(paste("means",i,sep=""), means)

mean_data <- data.frame(X=means)
y <- quantile(mean_data$X, c(0.25, 0.75)) 
x <- qnorm(c(0.25, 0.75))  
slope <- diff(y)/diff(x) 
int <- y[1] - slope*x[1] 

qqmean <-ggplot(mean_data, aes(sample = X)) + stat_qq() + 
  geom_abline(intercept=int, slope=slope) + labs(title=paste("n=",i,sep=""))
print(qqmean)
}

#  Once we have determined which sample size yields a sampling          #
#  distribution that is sufficiently approximately normal, we can       #
#  verify the parameters of the sampling distribution. The population   #
#  mean and variance of chi-squared distributions are the df and 2*df,  #
#  respectively.                                                        #

## Estimate the mean of the sampling distribution (which is 4)
mean(means40)

## Estimate the standard devation of the sampling distribution
true_sd <- sqrt(2*4/40)
true_sd
sd(means40)

#  Additional example:                                                  #
#  All businesses deal with uncertainty in profits from month to        #
#  month. Suppose that an entrepreneur decides to open up a coffee      #
#  bar on The Corner with a simplified menu and faster service. An      #
#  analyst that the entrepreneur hires determines how many customers    #
#  are likely to come to the coffee bar. The coffee bar is estimated    #
#  to have between 500 and 4000 customers on a typical weekday and      #
#  between 100 and 2500 customers on a typical weekend day. The number  #
#  of customers a day will be completely random. Use Monte Carlo        #
#  simulation to determine 10,000 possible monthly customer totals for  #
#  next month, which will have 23 weekdays and 8 weekend days. What     #
#  are the mean and standard deviation of monthly customer totals?      # 
#  Were these values expected?                                          #



#  Additional example:                                                  #
#  The analyst also determines that during the winter months, 72% of    #
#  customers will order a hot drink (profit: $2.20) on a weekday and    #
#  the remaining will order a hot drink with a cookie (profit: $5.85).  #
#  On weekend days, 44% of customers will order a hot drink and the     #
#  remaining will order a hot drink with a cookie. Update your Monte    #
#  Carlo simulation to determine 10,000 possible monthly profit totals  #
#  for the same month. What are the mean and standard deviation of      #
#  these values?                                                        #



#  Additional example:                                                  #
#  The fixed operating costs for the coffee bar (employee wage, rent,   #
#  etc.) is $6,750 per month. Are the coffee bar's business model and   #
#  projections profitable?                                              #



###################
#  Bootstrapping  #
###################

#  Bootstrapping uses similar ideas as Monte Carlo simulations, but     #
#  instead of drawing samples from a given or pseudo- population,       #
#  repeated samples are taken from the available sampled data.          #
#  Bootstrapping uses with replacement sampling to create several       #
#  simulated samples that are the same size as the original sampled     #
#  data.                                                                #

#  Like with Monte Carlo simulations, there are many applications of    #
#  bootstrapping that evaluate the estimated sampling distribution      #
#  of the parameter of interest determined from the bootstrap samples.  #
#                                                                       #
#  It is important to know that there are assumptions that need to      #
#  hold for bootstrapping to work. One of these assumptions is that     #
#  the sampled data represent an independent, representative sample     #
#  from the population. Also, bootstrapping will not work as expected   #
#  if the underlying population has very heavy tails.                   #
#                                                                       #
#  Suppose that for budget purposes we are only able to draw a sample   #
#  of 7 from the unknown population distribution. In this case, the     #
#  sample size is too small to be able to reasonably use the Central    #
#  Limit Theorem. Thus, the sampling distribution is unknown. In this   #
#  case, bootstrapping can be used to estimate the variation in the     #
#  sampling distribution.                                               #

## Draw the sample of 7 from the unknown distribution
samp_data <- c(1.77, 10.48, 4.30, 0.96, 2.67, 2.76, 2.02)

## Plot the sample
samp_df <- data.frame(samp_data)
ggplot(samp_df, aes(x=samp_data)) + geom_histogram(binwidth=1.5,fill="white",color="black")

## Find the sample mean
samp_mean <- mean(samp_data)

## Determine the number of bootstrap samples
B<-10000

## Draw the bootstrap samples
boot_samp <- replicate(B, sample(samp_data, replace=T))
boot_samp[,1:5]

## Determine the sample mean from each bootstrap sample
boot_means <- apply(boot_samp,2,mean)

## Plot the sampling distribution
means_df <- data.frame(boot_means)
ggplot(means_df, aes(x=boot_means)) + geom_histogram(binwidth=1.5,fill="white",color="black")

## Estimate the mean and standard deviation of the sampling distribution
mean(boot_means)
sd(boot_means)

## Determine the 95% bootstrap confidence interval of the sample mean
boot_err <- boot_means - samp_mean
boot_err_sort <- sort(boot_err)
p2.5 <- B*0.025
p97.5 <- B*0.975
boot_ci <- samp_mean - boot_err_sort[c(p97.5,p2.5)]
boot_ci

#  Bootstrapping can also be used to estimate the variability of        #
#  parameters whose sampling distribution is difficult or impossible    #
#  to determine theoretically.                                          #

## Determine the median of the sampled data
samp_med <- median(samp_data)

## Determine the sample median from each bootstrap sample
boot_meds <- apply(boot_samp,2,median)

## Determine the 95% bootstrap confidence interval
boot_meds_err <- boot_meds - samp_med
boot_meds_err_sort <- sort(boot_meds_err)
boot_med_ci <- samp_med - boot_meds_err_sort[c(p97.5,p2.5)]
boot_med_ci


## In class ##

sampleinclass <- Vocab[sample(nrow(Vocab), 48), c(1,3,4)]
class(sampleinclass[1])
length(sampleinclass[1])
Vocab[sample(nrow(Vocab), 48), c(1,3,4)]
names(Vocab)
nrow(sampleinclass)
ncol(sampleinclass)

samplefordist <- replicate(10, Vocab[sample(nrow(Vocab), 48), c(1,3,4)])
samplefordist[,1]

samp_data <- rchisq(7,df=4)
samp_mean <- mean(samp_data)
boot_samp <- replicate(8, sample(samp_data, replace=T))
boot_means <- apply(boot_samp, 2, mean)
boot_err <- boot_means - samp_mean
boot_err_sort <- sort(boot_err)
boot_ci <- samp_mean - boot_err_sort[c(p97.5, p2.5)]
boot_ci

# DRaw and store 100 new random samples of 7 values #
# from the chi-squeard distribution with 4 degrees of #
# Freedoml Use 10,00bootstrap samples to deterimne a #
# 95% bootstrap confidence interval for the mean for #
# each of the 100 samples. What proportion of the #
# cofidence intervals contain the true mean of 4 #
samp.list <- lapply(1:100, function(x) rchisq(7, df=4))
smean.list <- lapply(samp.list, mean)
bmeans.list <- lapply(bootsamp.list, function(x) apply(x,2,mean))
berr.list <- lapply(1:100, function(x) bmeans.list[[x]] - smean.list[[x]])
ci.list <- lapply(1:100, function(x) smean.list[[x]] - berr.list[[x]][c(p97.5,p2.5)])
res <- sapply(ci.list, function(x) x[1] <= 4 & x[2] >=4)
sum(res)/100

# A No heavy tails
# B. Independent
# C. Representative


#  Note that the bootstrap confidence intervals are not symmetric       #
#  around the point estimate. In certain cases, the standard deviation  # 
#  of the bootstrapped estimates can be used in place of the standard   #
#  error in the usual normal confidence interval equation if you are    #
#  confident that approximate normality holds.                          #

#  Additional example:                                                  #
#  The number of customers the coffee bar served in each of three       #
#  months is given below (assume for simplicity that each month has     #
#  the same weekday/weekend day structure). Determine a bootstrap       #
#  confidence interval for the mean and for the median number of        #
#  monthly customers that the coffee bar can expect during similar      #
#  quarters.                                                            # 
#     69064 55526 63447                                                 #



#  Additional example:                                                  #
#  During another quarter consisting of similar months, the number of   #
#  customers that the coffee bar served is given below (assume for      #
#  simplicity that each month has the same weekday/weekend day          #
#  structure). Determine a bootstrap confidence interval for the mean   #
#  and for the median number of monthly customers that the coffee bar   #
#  can expect during similar quarters.                                  #   
#     67329 69610 63436                                                 #



#  Additional example:                                                  #
#  Using the two quarters of data combined, determine a bootstrap       #
#  confidence interval for the mean and for the median number of        #
#  monthly customers that the coffee bar can expect during similar      #
#  times.                                                               #   



#  Suppose that we would like to use the sample of 7 observations       #
#  from the unknown population to test if the mean of the unknown       #
#  population is greater than 3. In this case, bootstrapping can be     #
#  used to estimate the sampling distribution of the test statistic     #
#  under the null hypothesis.                                           #

## Determine the test statistic 
samp_mean 

## Determine the sampling distribution of the test statistic under the null hypothesis
mu0 <- 3
boot_means_null <- boot_means - mean(boot_means) + mu0

## Plot the null hypothesis sampling distribution
means_df <- data.frame(boot_means_null)
ggplot(means_df, aes(x=boot_means_null)) + geom_histogram(binwidth=1.5,fill="white",color="black")

## Determine the p-value
sum(boot_means_null >= samp_mean)/B

#  Additional example:                                                  #
#  The number of customers that the coffee bar served in each of eight  #
#  similar weeks is given below. Is there evidence that the coffee bar  #
#  is serving different than 13,850 customers each week on average?     #
#     13544 13567 16999 16525 19503 14779 16897 15947                   #



#  Additional example:                                                  #
#  The number of customers that the coffee bar served in each of eight  #
#  similar weeks from a different season is given below. Is there       #
#  evidence that the coffee bar serves a different number of customers  #
#  in these two seasons on average?                                     #
#     14758 14212 11173 16366 13318 13530 12520 16071                   #



#  Additional example:                                                  #
#  The number of customers that a different Corner coffee shop served   #
#  during the same eight weeks of the first season is given below.      #
#  This other coffee shop has a much more extensive menu, but is also   #
#  fairly new to the area. Is there evidence that the simplified menu   #
#  attracts customers?                                                  #
#     14815 13954 16350 12545 13233 13592 15656 13139                   #



#########################################################################
