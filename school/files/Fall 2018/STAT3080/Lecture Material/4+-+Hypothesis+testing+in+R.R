
#########################################################################
#                                                                       #
#  Hypothesis testing in R                                              #
#                                                                       #
#########################################################################

#install.packages("BSDA")
#install.packages("UsingR")
#install.packages("OpenMx")
#install.packages("pwr")

library(BSDA)
library(UsingR)
library(OpenMx)
library(ggplot2)
library(pwr)

#  Statistical inference is used to make decisions or draw conclusions  #
#  regarding a population. Hypothesis testing is a common method of     #
#  statistical inference. There are three major types of hypothesis     #
#  testing - parametric, non-parametric, and categorical.               #
#                                                                       #
#  Parametric hypothesis testing assumes that the population follows a  #
#  particular distribution with an unknown parameter, non-parametric    #
#  hypothesis testing does not require the population distribution      #
#  to be known, and categorical hypothesis testing allows conclusions   #
#  to be drawn using qualitative data.                                  #

###################################
#  Parametric hypothesis testing  #
###################################

#  Parametric hypothesis testing assumes that the data come from a      #
#  defined distribution about which a parameter is unknown, but enough  #
#  information is available to know or approximate the sampling         #
#  distribution of the appropriate sample statistic under the null      #
#  hypothesis.                                                          #
#                                                                       #
#  The general process of the parametric testing process is:            #
#   1. Identify the parameter of interest.                              #
#   2. Define the null and alternative hypotheses regarding the         #
#      parameter.                                                       #
#   3. Determine the appropriate test statistic and compute its value.  #
#   4. Determine the corresponding p-value.                             #
#   5. State the conclusions.                                           #
#                                                                       #
#  Parametric hypothesis testing uses the known or assumed population   #
#  distribution to define the sampling distribution of the test         #
#  statistic, which is used to determine the p-value and draw           #
#  conclusions. If the objective of the inference is to estimate the    #
#  value of the unknown parameter, the sampling distribution can be     #
#  used to determine an appropriate confidence interval. Each           #
#  confidence interval has a corresponding confidence level, which      #
#  determines the probability that the interval contains the parameter  #
#  of interest.                                                         #
#                                                                       #
#  Some common parametric hypothesis tests are the one-sample z-test,   #
#  two-sample z-test, one-sample t-test, paired t-test, and two-sample  #
#  t-test. All of these tests are testing the mean of the single        #
#  population or the difference of the means of two populations.        #

#######################
#  One-sample z-test  #
#######################

#  The one-sample z-test requires the knowledge of the population       #
#  standard deviation and either a normal population distribution or    #
#  a large enough sample such that the Central Limit Theorem holds.     #
#                                                                       #
#  The one-sample z-test can be conducted by using the z.test()         #
#  function in the BSDA package (Basic Statistics and Data Analysis).   #
#  This function takes as inputs the vector of sample data points, the  #
#  null value of the population mean, the standard deviation of the     #
#  population, the type of test to be conducted, and the confidence     #
#  level for the corresponding confidence interval if different than    #
#  95%.                                                                 #
#                                                                       #
#  Example: It is known that weights of U.S. boys ages 1-6 is normally  #
#  distributed with a mean of 33.7 pounds and standard deviation of     #
#  8.7 pounds. A random sample of 65 boys aged 1-6 were drawn from      #
#  the U.S. population and their weights were recorded (along with      #
#  others). Is there evidence that the U.S. boys weight averages need   #
#  to be updated?                                                       #

## Isolate sample data
b <- which(kid.weights$age>12 & kid.weights$age<72 & kid.weights$gender=="M")
boywt <- kid.weights$weight[b]

## Conduct hypothesis test
z.test(boywt, mu=33.7, sigma.x=8.7, alternative="two.sided", conf.level=0.90)

#  If the sample mean is given instead of the sample data, you will     #
#  need to create a vector of sample data to use as the input that      #
#  has the appropriate mean and number of values.                       #

## Create sample data and conduct hypothesis test
boywt.avg <- rep(mean(boywt), length(boywt))
z.test(boywt.avg, mu=33.7, sigma.x=8.7, alternative="two.sided", 
       conf.level=0.90)

#  The values produced by the z.test() function can be retrieved and    #
#  saved as objects themselves.                                         #

boy.test <- z.test(boywt.avg, mu=33.7, sigma.x=8.7, alternative="two.sided", 
                   conf.level=0.90)
boy.test$statistic
boy.test$p.value
boy.test$estimate
boy.test$conf.int
boy.test$conf.int[1:2]
attr(boy.test$conf.int, "conf.level")

####################################
#  Confidence interval simulation  #
####################################

#  A common misinterpretation of the confidence interval is that there  #
#  is a certain percentage confidence that the true mean is between     #
#  the two endpoints of the calculated interval. However, the true      #
#  mean never changes. Instead it is the endpoints of the interval      #
#  that will change with the drawing of a new sample.                   #

## Generate 100 samples from the boys weight population
boy.samps <- replicate(100, round(rnorm(65, mean=33.7, sd=8.7)))
boy.samps[,1:5]

## Determine the mean for each sample
boy.means <- apply(boy.samps, 2, mean)

## Determine the endpoints of the CI for each sample
boy.LB <- boy.means - qnorm(0.975)*8.7/sqrt(65)
boy.UB <- boy.means + qnorm(0.975)*8.7/sqrt(65)

## Determine how many samples contain the true mean boy weight
boy.inCI <- boy.LB<33.7 & 33.7<boy.UB
sum(boy.inCI)
sum(boy.inCI)/100

## Plot the confidence intervals around the mean
boy.data <- data.frame(obs=1:100, LB=boy.LB, UB=boy.UB)
ggplot(boy.data, aes(x=obs)) + geom_linerange(aes(ymin=LB, ymax=UB)) + 
  geom_abline(intercept=33.7, slope=0)

#######################
#  Two-sample z-test  #
#######################

#  The two-sample z-test requires the knowledge of the both population  #
#  standard deviations and either two normal population distribution    #
#  or large enough samples such that the Central Limit Theorem holds.   #
#                                                                       #
#  The two-sample z-test can also be conducted using the z.test()       #
#  function. In order to indicate that a two-sample test should be      #
#  conducted, the optional inputs for the second vector of data and     #
#  the standard deviation of that population are used.                  #
#                                                                       #
#  Example: It is known that weights of U.S. girls ages 1-6 is normally #
#  distributed with a mean of 33.1 pounds and standard deviation of     #
#  7.7 pounds. A random sample of 62 girls aged 1-6 were drawn from     #
#  the U.S. population and their weights were recorded (along with      #
#  others). Is there evidence that the U.S. boys average weight is      #
#  more than 0.6 pounds heavier than the U.S. girls average weight?     #

## Isolate sample data
g <- which(kid.weights$age>12 & kid.weights$age<72 & kid.weights$gender=="F")
girlwt <- kid.weights$weight[g]

## Conduct hypothesis test
z.test(boywt, girlwt, mu=0.6, sigma.x=8.7, sigma.y=7.7, 
       alternative="greater", conf.level=0.99)

#######################
#  One-sample t-test  #
#######################

#  The one-sample t-test requires either a normal population            #
#  distribution or a large enough sample such that the Central Limit    #
#  Theorem holds, but drops the requirement to know the population      #
#  standard deviation. Thus, the t-tests tend to be more common in      #
#  practice.                                                            #
#                                                                       #
#  The one-sample t-test is conducted by using the t.test() function.   #
#  This function takes as inputs the vector of sample data points,      #
#  the null value of the population mean, the type of test to be        #
#  conducted, and the confidence level for the corresponding confidence #
#  interval if different than 95%.                                      #
#                                                                       #
#  Example: A university bookstore claims that, on average, a student   #
#  will pay $ 101.75 per class for textbooks. The student newspaper     #
#  suspects that the claimed average is too low and investigates by     #
#  randomly selecting 9 courses from the current semester offerings     #
#  and finding the textbook costs for each. The students conducting     #
#  the investigation reason that with the collection of courses being   #
#  offered courses, the textbook prices are normally distributed.       #

## Record sample data collected
news.samp <- c(140, 125, 150, 87, 170, 195, 94, 127, 53)

## Conduct hypothesis test
t.test(news.samp, mu=101.75, alternative="greater")

#  The values produced by the t.test() function can be retrieved and    #
#  saved as objects themselves.                                         #

text.test <- t.test(news.samp, mu=101.75, alternative="greater")
text.test$statistic
text.test$parameter
text.test$p.value
text.test$estimate
text.test$conf.int
text.test$conf.int[1:2]
attr(text.test$conf.int, "conf.level")

###################
#  Paired t-test  #
###################

#  The paired t-test is a special case of the one-sample t-test where   #
#  instead of testing the mean of one population, you are testing the   #
#  difference of two means by using the differences in pairs of data    #
#  points that are dependent. As this is a special case, the same       #
#  assumptions are required: either the differences of the paired       #
#  values are normally distributed or there are enough pair differences #
#  that the Central Limit Theorem holds.                                #
#                                                                       #
#  In order to conduct a paired t-test, the optional t.test() input     #
#  paired should be designated as true. When conducting a paired        #
#  t-test, the data is either given in two vectors (the second will     #
#  be subtracted from the first position-by-position) or in a single    #
#  vector with an additional vector specifying how the data should be   #
#  separated.                                                           #
#                                                                       #
#  If your data includes any missing values, the pairs will be removed  #
#  automatically if the data are given in two vectors. However, if      #
#  your single vector contains missing values for one value of certain  #
#  pairs, they will be removed before the pairs are matched leaving an  #
#  unequal number of values and causing an error when the t-test is     #
#  run. To leave the missing values in the data until the pairs are     #
#  matched, the na.option should be set to na.pass.                     #
#                                                                       #
#  Example: A weight study was conducted on twins in Australia. Is      #
#  there evidence that identical twins have significantly different     #
#  weights?                                                             #

## Isolate the data
a <- which(twinData$zygosity == "MZFF" | twinData$zygosity == "MZMM")
wt1 <- twinData$wt1[a]
wt2 <- twinData$wt2[a]

## Conduct the hypothesis test
t.test(wt1, wt2, mu=0, alternative="two.sided", paired=TRUE)

## Combine the data
wt1.data <- cbind(wt=wt1,twin=1)
wt2.data <- cbind(wt=wt2,twin=2)
wt.data <- rbind(wt1.data,wt2.data)

## Conduct the hypothesis test
t.test(wt~twin, data=wt.data, na.action=na.pass, mu=0, 
       alternative="two.sided", paired=TRUE)

#######################
#  Two-sample t-test  #
#######################

#  The two-sample t-test requires either two independent normal         #
#  populations or two large enough independent samples such that the    #
#  Central Limit Theorem holds.                                         #
#                                                                       #
#  The two-sample t-test can also be conducted using the t.test()       #
#  function, using two sample data inputs or one combined input with    #
#  details for how the values should be separated.                      #
#                                                                       #
#  If the user is confident that the variances of the two populations   #
#  are equal, the pooled standard error can be used by specifying TRUE  #
#  in the var.equal option.                                             #
#                                                                       #
#  Example: A biologist is interested in whether different species of   #
#  iris have different sepal widths. He is particularly interested in   #
#  the Versicolor and Virginica species. Is there evidence that there   #
#  is a significant difference between these two species?               #

## Look at the iris data
iris[1:5,]
levels(iris$Species)

## Conduct the hypothesis test
t.test(Sepal.Width~Species, data=iris, 
       subset=Species %in% c("versicolor", "virginica"), mu=0,
       alternative="two.sided")

## Separate the data
width1 <- iris$Sepal.Width[iris$Species=="versicolor"]
width2 <- iris$Sepal.Width[iris$Species=="virginica"]

## Conduct the hypothesis test
t.test(width1, width2, mu=0, alternative="two.sided")

#########################################################################

library(BSDA)
library(UsingR)
library(OpenMx)
library(ggplot2)
library(pwr)

###########
#  Power  #
###########

#  The power of a hypothesis test is the probability that the null      #
#  hypothesis will be rejected when the alternative hypothesis is true. #
#  Several factors play together to determine the power - the sample    #
#  size, the significance level, and the effect size. A desired power   #
#  can be used with the other factors to determine the needed sample    #
#  size.                                                                #
#                                                                       #
#  There are several power functions corresponding to the various       #
#  types of parametric tests that use three of the quantities as        #
#  inputs to determine the fourth quantity. In all of these functions,  #
#  the alternative input can be used to specify the type of test.       #
#                                                                       #
#  The function pwr.norm.test() is used to determine the power for the  #
#  one-sample z-test. The effect size for the one-sample z-test is the  #
#  difference between the null value and alternate value                #
#  (alternate-null) for the true mean divided by the standard           #
#  deviation.                                                           #
#                                                                       #
#  Example: It is known that weights of U.S. boys ages 1-6 is normally  #
#  distributed with a mean of 33.7 pounds and standard deviation of     #
#  8.7 pounds. A random sample of 65 boys aged 1-6 were drawn from      #
#  the U.S. population and their weights were recorded (along with      #
#  others). What is the power of the test if the U.S. boys weight       #
#  average is actually 36 pounds?                                       #

## Determine effect size
efs <- (36-33.7)/8.7

## Calculate the power
pwr.norm.test(d=efs, n=65, sig.level=0.05, alternative="two.sided")

## Determine the sample size required for power of 0.8
pwr.norm.test(d=efs, sig.level=0.05, power=0.8, alternative="two.sided")

#  The function pwr.norm.test() can also be used to determine the       #
#  power for the two-sample z-test when the two sample sizes are equal. #
#  In this case, the effect size is the alternate difference between    #
#  the population means less the assumed difference between the means   #
#  divided by the square root of the summed population variances. When  #
#  using this function in this case to yield a needed sample size, the  #
#  number of observations given is required for both populations.       #
#                                                                       #
#  Example: It is known that weights of U.S. girls ages 1-6 is normally #
#  distributed with a mean of 33.1 pounds and standard deviation of     #
#  7.7 pounds. A random sample of 65 girls aged 1-6 were drawn from     #
#  the U.S. population and their weights were recorded (along with      #
#  others). The test will determine if is there evidence that the U.S.  #
#  boys average weight is more than 0.6 pounds heavier than the U.S.    #
#  girls average weight. What is the power of this test if the U.S.     #
#  boys average weight is 2 pounds heaver than the U.S. girls average   #
#  weight?                                                              #

## Determine effect size
efs <- (2-0.6)/sqrt(8.7^2 + 7.7^2)

## Calculate the power
pwr.norm.test(d=efs, n=65, sig.level=0.05, alternative="greater")

## Determine the sample size per group required for power of 0.8
pwr.norm.test(d=efs, sig.level=0.05, power=0.8, alternative="greater")

#  The function pwr.t.test() is used to determine the power for the     #
#  one-sample t-test, the paired t-test, and the two-sample t-test      #
#  when the sample sizes in the two groups are equal. Since the         #
#  population standard deviation(s) is(are) unknown, the effect size    #
#  cannot be calculated exactly. Since the effect size is a             #
#  standardized difference, the absolute values 0.2, 0.5, and 0.8 can   #
#  be used to denote small, medium, and large effect sizes,             #
#  respectively. The sign of the effect size should reflect the         #
#  relative sizes of the alternate value and assumed value. If the      #
#  alternate value is greater than the assumed value, then the effect   #
#  size should be positive and vice versa. This function requires an    #
#  input to denote whether the test is one-sample, paired, or           #
#  two-sample.                                                          #
#                                                                       #
#  Example: A university bookstore claims that, on average, a student   #
#  will pay $ 101.75 per class for textbooks. The student newspaper     #
#  suspects that the claimed average is too low and plans to            #
#  investigate by randomly selecting 9 courses from the current         #
#  semester offerings and finding the textbook costs for each. The      #
#  students conducting the investigation reason that with the           #
#  collection of courses being offered courses, the textbook prices     #
#  are normally distributed. What is the power of their planned test    #
#  to identify a significant difference when the true cost per          #
#  textbook is moderately higher?                                       #

## Calculate the power
pwr.t.test(d=0.5, n=9, sig.level=0.05, type="one.sample", alternative="greater")

## Determine the sample size required for power of 0.8
pwr.t.test(d=0.5, sig.level=0.05, power=0.8, type="one.sample", alternative="greater")

#  Example: A weight study was conducted on 1728 set of twins in        #
#  Australia to determine if there is evidence that identical twins     #
#  have significantly different weights. What is the power if the true  #
#  difference is small?                                                 #

## Calculate the power
pwr.t.test(d=0.2, n=1728, sig.level=0.05, type="paired", alternative="two.sided")

## Determine the sample size required for power of 0.8
pwr.t.test(d=0.2, sig.level=0.05, power=0.8, type="paired", alternative="two.sided")

#  Example: A biologist is interested in whether different species of   #
#  iris have different sepal widths. He is particularly interested in   #
#  whether the Versicolor and Virginica species are significantly       #
#  different. With random samples of 150 flowers from each species,     #
#  what is the power of the biologist's test when the true difference   #
#  is small?                                                            #

## Calculate the power
pwr.t.test(d=0.2, n=150, sig.level=0.05, type="two.sample", alternative="two.sided")

## Determine the sample size required for power of 0.8
pwr.t.test(d=0.2, sig.level=0.05, power=0.8, type="two.sample", alternative="two.sided")

#  The function pwr.t2n.test() is used to determine the power for the   #
#  two-sample t-test when the sample sizes in the two groups are        #
#  unequal. This function requires two inputs for sample size. To       #
#  determine a sample size using this function, one of the two sample   #
#  size inputs must have a value.                                       #
#                                                                       #
#  Example: The biologist conducting the experiment to identify         #
#  differences in sepal widths between iris species has planted the     #
#  irises, but 5 of the Versicolor plants have died as have 9 of the    #
#  virginica plants. What is the power of the biologist's updated test  #
#  when the true difference is small?                                   #

## Calculate the power
pwr.t2n.test(d=0.2, n1=145, n2=141, sig.level=0.05, alternative="two.sided")

#  Example: The biologist decides that it is possible to plant          #
#  additional virginica irises for the study. How many more should the  #
#  biologist plant for 50% power?                                       #

## Determine the sample size required for power of 0.5
pwr.t2n.test(d=0.2, n1=145, sig.level=0.05, power=0.5, alternative="two.sided")

#  One of the benefits of using R to calculate power for hypothesis     #
#  tests is the ability to calculate the power over several different   #
#  values quickly. These values are often displayed in a power curve.   #
#  Either the effect size, sample size, or significance level can be    #
#  displayed on the x-axis and the power associated with those values   #
#  are displayed on the y-axis, holding the other two values constant.  #
#                                                                       #
#  Example: A university bookstore claims that, on average, a student   #
#  will pay $ 101.75 per class for textbooks. The student newspaper     #
#  suspects that the claimed average is too low and plans to            #
#  investigate by randomly selecting 9 courses from the current         #
#  semester offerings and finding the textbook costs for each. The      #
#  students conducting the investigation reason that with the           #
#  collection of courses being offered courses, the textbook prices     #
#  are normally distributed. What is the power of their planned test    #
#  to identify a significant difference over various effect sizes?      #
#  What is the power over various sample sizes for a moderate effect    #
#  size?                                                                #

## Determine the power values
esizes <- seq(0,1,0.01)
epowervals <- pwr.t.test(d=esizes, n=9, sig.level=0.05, type="one.sample", alternative="greater")$power

## Plot the power values against the effect sizes
Pdata <- data.frame(esizes,epowervals)
ggplot(Pdata, aes(x=esizes, y=epowervals)) + geom_line()

#  Example: What is the power over various sample sizes for a moderate  #
#  effect size for the textbook price study?                            #

## Determine the power values
ssizes <- seq(5,100,1)
spowervals <- pwr.t.test(d=0.5, n=ssizes, sig.level=0.05, type="one.sample", alternative="greater")$power

## Plot the power values against the effect sizes
Pdata <- data.frame(ssizes,spowervals)
ggplot(Pdata, aes(x=ssizes, y=spowervals)) + geom_line()

#######################################
#  Non-parametric hypothesis testing  #
#######################################

#  In general, non-parametric hypothesis tests do not require           #
#  population distribution information to be known. This collection     #
#  of tests does not use the sampling distribution of the sample        #
#  statistic. Instead, each sampled data point is given a sign and/or   #
#  a rank and these are used to make determinations. All of these       #
#  particular hypothesis tests assume that the data are sampled from    #
#  continuous distributions and test the median of the distribution or  #
#  the difference of two medians.                                       #

###############
#  Sign test  #
###############

#  The sign test enables users to draw conclusions regarding the        #
#  median of a continuous distribution. Like the parametric tests,      #
#  the null hypothesis will be assumed true throughout the test. For    #
#  this test, the null hypothesis is that the median (M) is equal to    #
#  the null value (m). The alternative hypothesis can be either         #
#  right-tailed, left-tailed, or two-tailed. The three possible sets    #
#  of hypotheses are:                                                   #
#   Ho: M=m vs. Ha: M<m                                                 #
#   Ho: M=m vs. Ha: M>m                                                 #
#   Ho: M=m vs. Ha: M!=m                                                #
#                                                                       #
#  Since the median is the center of the data, the number of data       #
#  points above and below the true value of the median should be        #
#  roughly equal. Since the null hypothesis is assumed to be true,      #
#  the null value is assumed to be the center of the data. The test     #
#  statistic is the number of sampled data points greater than the      #
#  null value, which follows a binomial distribution with the sample    #
#  size as the number of trials and 0.5 as the probability of success.  #
#  The p-value is found by determining the probability of obtaining a   #
#  test statistic at least as extreme as the one found in the same      #
#  direction as the test. For two-tailed tests, the probability to the  #
#  left of a small number (less than half) or to the right of a large   #
#  number (more than half) is multiplied by two.                        #
#                                                                       #
#  The test statistic for the sign test is found by comparing each      #
#  sampled point to the null value and summing the resulting logical    #
#  vector. The p-value can be found by using the pbinom() function or   #
#  by using the binom.test() function.                                  #
#                                                                       #
#  Example: Consider the sample data below drawn from a cell phone      #
#  record that represent the number of minutes spent per call. Is       #
#  there evidence that the median call length is less than 5 minutes?   #                 

## Sampled data
calls1 <- c(2,1,3,3,3,3,1,3,16,2,2,12,20,3,1)

## Histogram of sampled data
ggplot(data.frame(calls1),aes(x=calls1)) + 
  geom_histogram(binwidth=5,color="black",fill="white")

## Determine test statistic
v <- sum(calls1>5)
v

## Determine sample size
n <- length(calls1)

## Determine p-value
pbinom(v,n,0.5)
binom.test(v,n,alternative="less")

#  Example: Consider the sample data drawn from another user's cell     #
#  phone record. Is there evidence that the median call length is more  #
#  than 30 minutes?                                                     #

## Sampled data
calls2 <- c(22,35,31,41,36,1,21,37,1,42,32,33,28,41,44)

## Histogram of sampled data
ggplot(data.frame(calls2),aes(x=calls2)) + 
  geom_histogram(binwidth=10,color="black",fill="white")

## Determine test statistic
v <- sum(calls2>30)
v

## Determine sample size
n <- length(calls2)

## Determine p-value
1-pbinom(v-1,n,0.5)
binom.test(v,n,alternative="greater")

#  Example: Consider the sample data drawn from the second user's cell  #
#  phone record. Is there evidence that the median call length is 25    #
#  minutes?                                                             #

## Determine test statistic
v <- sum(calls2>25)
v

## Determine p-value
2*(1-pbinom(v-1,n,0.5))
binom.test(v,n,alternative="two.sided")

#############################
#  Wilcoxon sign-rank test  #
#############################

#  The Wilcoxon sign-rank test is another way to test the median of a   #
#  continuous distribution and uses the same hypotheses. It has one     #
#  additional assumption that the distribution be symmetric.            #
#                                                                       #
#  The Wilcoxon sign-rank test works in a similar way to the sign       #
#  test. Instead of each value being compared directly to the null      #
#  value, first, the null value is subtracted from each sampled value,  #
#  which will yield a positive difference if the sampled value is       #
#  above the assumed median and a negative difference if the sampled    #
#  value is below the assumed median. Next, the absolute values of      #
#  the differences are ranked and any tied values receive a rank that   #
#  is the average of the would-be ranks of all the tied values.         #
#  Finally, the ranks of the positive differences are summed to find    #
#  the test statistic.                                                  #
#                                                                       #
#  The p-value is found in one of two ways - exactly or approximately.  #
#  The exact method uses Monte Carlo simulation to generate repeated    #
#  values of the test statistic and the p-value is determined to be     #
#  the proportion of generated test statistics that are at least as     #
#  large as the calculated test statistic. The approximate method       #
#  uses a normal approximation for the distribution of the test         #
#  statistic. The approximation method is typically used when there     #
#  are tied ranks or when the sample size is large. When the            #
#  approximation method is used, users have the option to include a     #
#  continuity correction to adjust the integer-based test statistics    #
#  to the continuous normal scale.                                      #
#                                                                       #
#  The function wilcox.test() will conduct this test. The required      #
#  inputs are the sampled data, the null value of the median (using     #
#  the mu option), and the type of test to be conducted. Users can      #
#  also specify whether to generate the exact p-value and whether to    #
#  ignore the continuity correction.                                    #
#                                                                       #
#  Example: The distribution of hunter-gatherer population densities    #
#  across all forest ecosystems worldwide is skewed to the right and    #
#  non-normal, which makes the median the most reliable measure of the  #
#  center of the distribution. The median population density (per 100   #
#  km) of all forest hunter-gatherers is 7.38. Is this value accurate   #
#  for the hunter-gatherer groups of northern Australian forests?       #
ts <- sum(aus$sign * aus$rank)
ts
### IN CLASSS
library(gtools)
signs <- permutations(2,13,c(1,0), repeats.allowed=TRUE)
## My way
sapply(1:(length(signs)/13), function(x) sum(which(signs[x,] == 1)))
## her way
ts <- apply(t(signs)*ranks, 2, sum)

## IN CLASS. What is the p-value for a set of data points that has a test statistics of 89?
length(which(ts >= 89))/length(ts)
library(ggplot2)
ggplot(aes(ts)) + geom_histogram(data = ts)
hist1 <- ggplot(as.data.frame(ts), aes(x=ts))
hist1 + geom_histogram(binwidth=2, fill="white", colour="black")


## Austrlian group densities
aus.names <- c("jeidji","kuku","mamu","ngatjan","undanbi","jinibarra",
               "ualaria","barkindji","wongaibon","jaralde","tjapwurong",
               "tasmanians","badjalang")
aus.den <- c(17, 50, 45, 59.8, 21.74, 16, 9, 15.43, 5.12, 40, 35, 
             13.35, 13.4)

## Conduct the test
wilcox.test(aus.den, mu=7.38, alternative="two.sided")
wilcox.test(aus.den, mu=7.38, alternative="two.sided", exact=FALSE)
wilcox.test(aus.den, mu=7.38, alternative="two.sided", exact=FALSE,
            correct=FALSE)

## Test statistic calculation
aus <- data.frame(names=aus.names, den=aus.den)
aus$diff <- aus$den - 7.38
aus$sign <- ifelse(aus$diff > 0, 1, 0)
aus$rank <- rank(abs(aus$diff))
aus



#  The Wilcoxon sign-rank test can also be used to test the difference  #
#  of the medians of two continuous distributions with the same shape   #
#  when the sampled data from the two populations are dependent.        #
#                                                                       #
#  In this case, the procedure for determining the test statistic is    #
#  similar to the one-sample case. First, the difference between each   #
#  pair of observations is calculated. The absolute values of these     #
#  differences are ranked, ignoring any differences of zero and         #
#  adjusting ranks for any ties. Since the order of the pairs changes   #
#  the signs of the differences, the sum of the positive ranks and the  #
#  sum of the negative ranks are calculated. The test statistic is the  #
#  smaller of the two sums.                                             #
#                                                                       #
#  The wilcox.test() function is used for this version of the sign-rank #
#  test as well by using the optional paired input. As with the         #
#  two-sample parametric tests, the data can be provided either in      #
#  two vectors or in one vector with an accompanying vector to          #
#  distinguish the samples.                                             #
#                                                                       #
#  Example: A study is conducted to test whether people's ability to    #
#  report words accurately is affected by the ear in which the words    #
#  are heard. Each participant in the study heard a series of words     #
#  randomly delivered to either their right or left ear and report the  #
#  word if they could. The number of words correctly reported from      #
#  each ear was recorded for each participant. Is there evidence that   #
#  words are reported more accurately from one ear over the other?      #
###

## Correct word counts
left <- c(25, 29, 10, 31, 27, 24, 27, 29, 30, 32, 20, 5)
right <- c(32, 30, 7, 36, 20, 32, 26, 33, 32, 32, 30, 32)

## Conduct the test
wilcox.test(left, right, alternative="two.sided", paired=TRUE, exact=TRUE)
wilcox.test(left, right, alternative="two.sided", paired=TRUE, exact=FALSE)
wilcox.test(left, right, alternative="two.sided", paired=TRUE, exact=FALSE, 
            correct=FALSE)

## Test statistic calculation
words <- data.frame(left, right)
words$diff <- words$left - words$right
words$diff <- ifelse(words$diff==0, NA, words$diff)
words$signP <- ifelse(words$diff > 0, 1, 0)
words$signN <- ifelse(words$diff < 0, 1, 0)
words$rank <- rank(abs(words$diff))
words

tsP <- sum(words$signP * words$rank, na.rm=TRUE)
tsN <- sum(words$signN * words$rank, na.rm=TRUE)
min(tsP,tsN)

############################
#  Wilcoxon rank-sum test  #
############################

#  The Wilcoxon rank-sum test compares the medians of two continuous    #
#  populations that are assumed to have the same shape and are          #
#  independent. The three possible sets of hypotheses are:              #
#    Ho: M1=M2 vs. Ha: M1 < M2                                          #
#    Ho: M1=M2 vs. Ha: M1 > M2                                          #
#    Ho: M1=M2 vs. Ha: M1 != M2                                         #
#                                                                       #
#  For the Wilcoxon rank-sum test, the test statistic determination     #
#  begins by combining both samples and ranking all of the values       #
#  together. If the null hypothesis is true, then the sums of the       #
#  ranks in both groups should be roughly equal. Thus, the ranks are    #
#  summed for each group. An adjustment is made to each sum to account  #
#  for any difference in sample size between the two groups. The test   #
#  statistic is the smaller adjusted sum.                               #
#                                                                       #
#  As with the Wilcoxon sign-rank test, the p-value is determined       #
#  using either the exact method or the approximate method.             #
#                                                                       #
#  The wilcox.test() function is also used for this test by providing   #
#  two samples either in two vectors or with a distinguishing factor    #
#  and leaving the optional paired input set to false.                  #
#                                                                       #
#  Example: A grocery store's manager decides to compare the register   #
#  personnel to determine if there is a difference in the speed with    #
#  which they checkout customers. Is there evidence that there is a     #
#  difference in checkout times of the two selected employees?          #

## Register data
rpA <- c(5.8, 1, 1.1, 2.1, 2.5, 1.1, 1, 1.2, 3.2, 2.7)
rpB <- c(1.5, 2.7, 6.6, 4.6, 1.1, 1.2, 5.7, 3.2, 1.2, 1.3)

## Conduct the test
wilcox.test(rpA, rpB, alternative="two.sided")
wilcox.test(rpA, rpB, alternative="two.sided", exact=FALSE)
wilcox.test(rpA, rpB, alternative="two.sided", exact=FALSE, correct=FALSE)

## Test statistic calculation
rpA.data <- data.frame(time=rpA, person="A")
rpB.data <- data.frame(time=rpB, person="B")
rp.data <- rbind(rpA.data, rpB.data)
rp.data$rank <- rank(rp.data$time)
rp.data

sums <- tapply(rp.data$rank, rp.data$person, sum)
sums

nA <- length(rpA)
nB <- length(rpB)

tsA <- nA*nB + (nA*(nA+1)/2) - sums[1]
tsB <- nA*nB + (nB*(nB+1)/2) - sums[2]
min(tsA,tsB)

####################################
#  Categorical hypothesis testing  #
####################################

#  Categorical hypothesis testing enables users to make conclusions     #
#  regarding the proportions of characteristics of interest found in    #
#  populations. Common categorical hypothesis tests are the chi-squared #
#  test for two way tables, the goodness-of-fit test, the one-sample    #
#  z-test for proportions, and the two-sample z-test for proportions.   #

#########################################
#  Chi-squared test for two-way tables  #
#########################################

#  The chi-squared test for two-way tables determines whether the       #
#  distribution of proportions of one category is the same over         #
#  different levels of the other category. Thus, the null hypothesis    #
#  for this test is that there is no association between the two        #
#  categories. The alternative hypothesis is that the two categories    #
#  have some sort of relationship.                                      #
#                                                                       #
#  The data for the chi-squared test is usually shown in a two-way      #
#  table. Two-way tables can have any number of levels in each          #
#  category.                                                            #

## Create two-way table for 114 individuals' hair and eye color
M <- matrix(c(38,14,11,51), nrow=2, ncol=2)
dimnames(M) <- list(Hair=c("Fair","Dark"), Eye=c("Blue","Brown"))
M

## Create a two-way table for 400 individuals' gender and education
L <- matrix(c(63,42,54,44,46,53,41,57), nrow=2, ncol=4)
dimnames(L) <- list(Gender=c("Female","Male"), 
                    Education=c("HS","BA","MA","PhD"))
L
sum(L)

#  Two-way tables can either show counts or proportions and can         #
#  express either the joint or conditional distributions.               #

## Joint distribution in proportions
Lp <- prop.table(L)
sum(Lp)

## Conditional distributions of education levels
L.cond.edu <- prop.table(L,2)
L.cond.edu
apply(L.cond.edu,2,sum)

#  In order to use the chi-squared for two-way tables test, two main    #
#  assumptions must hold: 1) no cells contain zero individuals and      #
#  2) no more than 20% of the cells can expect to see fewer than 5      #
#  individuals under the null hypothesis.                               #
#                                                                       #
#  In order to determine the test statistic, first the expected cell    #
#  counts are determined from the associated row and column totals.     #
#  Next the difference between each observed and expected cell count    #
#  is determined, squared, and scaled by the expected cell count.       #
#  Finally, all of the scaled squared differences are summed to yield   #
#  the test statistic. The p-value is determined by comparing the test  #
#  statistic to the chi-squared distribution with (r-1)(c-1) degrees    #
#  of freedom, where r is the number of levels in the row category and  #
#  c is the number of levels in the column category.                    #
#                                                                       #
#  The function chisq.test() can be used to conduct the chi-squared     #
#  test for two-way tables. The required inputs are the two-way table   #
#  containing the observed counts and whether or not to use the         #
#  continuity correction.                                               #

## Conduct test for gender and education level
test1 <- chisq.test(L, correct=FALSE)
test1

#  If the chi-squared test output is saved, several quantities can      #
#  be isolated, such as the test statistic, p-value, and table of       #
#  expected counts.                                                     #

test1$statistic
test1$parameter
test1$p.value
test1$expected

##########################
#  Goodness-of-fit test  #
##########################

#  The goodness-of-fit test is similar to the chi-squared test for      #
#  two-way tables. Typically the goodness-of-fit test is used to test   #
#  the distribution of proportions across one category. The null        #
#  hypothesis can assume either that all of the levels of the category  #
#  have equal proportions in the population or that the list of         #
#  proportions provided by the user represent the true population       #
#  proportions.                                                         #
#                                                                       #
#  The test statistic and p-value are calculated in a similar way to    #
#  the chi-squared test for two-way tables except that the expected     #
#  counts are determined using the assumed population proportions. The  #
#  test statistic is compared to the chi-squared distribution with      #
#  r-1 degrees of freedom.                                              #
#                                                                       #
#  The function chisq.test() can be used to conduct the goodness-of-fit #
#  test. This function requires a vector containing the counts in       #
#  each level of the category, a vector of the assumed population       #
#  proportions, and whether or not the continuity correction should     #
#  be used.                                                             #
#                                                                       #
#  Example: It is thought that when given a standard treatment, 50% of  #
#  individuals with hypertension will show a marked decrease in blood   #
#  pressure, 25% of individuals with hypertension will show a moderate  #
#  decrease in blood pressure, 10% of individuals with hypertension     #
#  will show a slight decrease in blood pressure, and 15% of            #
#  individuals with hypertension will show no change in blood pressure. #
#  A random sample of 200 individuals with hypertension is selected     #
#  and each is given a new treatment. The observed counts are 108, 63,  #
#  9, and 11, respectively. Is there evidence that individuals react    #
#  differently to this treatment than to the standard treatment?        #

## Conduct the test
resp <- c(108,63,13,16)
sp <- c(0.5,0.25,0.1,0.15)
chisq.test(resp, p=sp, correct=FALSE)

#######################################
#  One-sample z-test for proportions  #
#######################################

#  The one-sample z-test for proportions tests the proportion of a      #
#  certain characteristic in one population. As such, the three sets    #
#  of possible hypotheses are defined in terms of the population        #
#  proportion parameter, p. The test statistic is calculated using      #
#  the sample proportion, which is found using the count of             #
#  individuals with the characteristic of interest in the sample.       #
#                                                                       #
#  The function prop.test() can give the results from a one-sample      #
#  z-test for proportions. However, this function conducts a            #
#  chi-squared test for whether the proportion of successes are the     #
#  same across populations, so users need to adjust the output from     #
#  this function to yield the one-sample z-test quantities. To conduct  #
#  a one-sample z-test for proportions using the prop.test() function,  #
#  the inputs required are the number of successes in the sample, the   #
#  size of the sample, the null value, which test to conduct, and       #
#  whether to include a continuity correction.                          #
#                                                                       #
#  Example: A student hears that 10% of the U.S. population is          #
#  left-handed and wants to determine if his school has the same        #
#  proportion as the general population. To investigate, he randomly    #
#  samples 100 of his fellow students and finds 5 of them to be         #
#  left-handed. Is there evidence that the student population           #
#  proportion differs from the general population proportion?           #

## Conduct the test
z.prop <- prop.test(5, 100, p=0.1, alternative="two.sided", correct=FALSE)
z.prop

## Determine test statistic
phat <- 5/100
z <- (phat-0.1)/sqrt(0.1*0.9/100)
z

## Determine p-value
p.value <- 2*pnorm(z)
p.value

## Compare test statistic and p-value to output
sqrt(z.prop$statistic)
z.prop$p.value

#  Example: A student hears that 10% of the U.S. population is          #
#  left-handed and wants to determine if his school has a lower         #
#  proportion than the general population. To investigate, he randomly  #
#  samples 100 of his fellow students and finds 5 of them to be         #
#  left-handed. Is there evidence that the student population           #
#  proportion is significantly lower than the general population        #
#  proportion?                                                          #

## Conduct the test
z.prop2 <- prop.test(5, 100, p=0.1, alternative="less", correct=FALSE)
z.prop2

## Determine test statistic
phat <- 5/100
z <- (phat-0.1)/sqrt(0.1*0.9/100)
z

## Determine p-value
p.value2 <- pnorm(z)
p.value2

## Compare test statistic and p-value to output
sqrt(z.prop2$statistic)
z.prop2$p.value

#  While the test statistic and p-value can be determined from the      #
#  output of the prop.test() function, the confidence interval          #
#  reported is calculated in a different way and is different from      #
#  the standard one-sample z-confidence interval for proportions.       #

## Determine two-sided confidence interval
se <- sqrt(phat*(1-phat)/100)
z.star <- qnorm(0.975)
ci <- c(phat - z.star*se, phat + z.star*se)
ci

## Compare confidence interval to output
z.prop$conf.int[1:2]

#######################################
#  Two-sample z-test for proportions  #
#######################################

#  The two-sample z-test for proportions tests the difference of the    #
#  proportions of a certain characteristic across two independent       #
#  populations. The null hypothesis for all three sets of possible      #
#  hypotheses is that the two population proportions are equal. The     #
#  test statistic is calculated using the sample proportions from the   #
#  two independent samples.                                             #
#                                                                       #
#  The function prop.test() can be used to conduct the two-sample       #
#  z-test for proportions if the user understands the appropriate       #
#  adjustments from the chi-squared test. For the two-sample z-test     #
#  for proportions, the inputs are the same as when conducting the      #
#  one-sample z-test for proportions except that the inputs for the     #
#  number of successes and sample size must be a vector containing the  #
#  two appropriate values. Additionally, the null value should not be   #
#  specified so that the proportions are compared to each other.        #
#                                                                       #
#  Example: The sample poverty rate in 2001 was found to be 11.7%       #
#  using a sample of 50,000 individuals. The sample poverty rate in     #
#  2002 was found to be 12.1% using a sample of 60,000 individuals. Is  #
#  there significant evidence that the U.S. poverty rate changed from   #
#  2001 to 2002?                                                        #

## Conduct the test
phat <- c(0.117, 0.121)
n <- c(50000, 60000)
x <- phat*n

z2.prop <- prop.test(x, n, alternative="two.sided", correct=FALSE)
z2.prop

z1.prop <- prop.test(x, n, alternative="less", correct=FALSE)

## Determine test statistic
comb.phat <- sum(x)/sum(n)
z <- diff(phat)/sqrt(comb.phat*(1-comb.phat)*(1/n[1]+1/n[2]))
z

## Determine p-value
p.value <- 2*(1-pnorm(z)) 
p.value

## Compare test statistic and p-value to output
sqrt(z2.prop$statistic)
z2.prop$p.value

z1.prop$p.value
#  As with the one-sample z-test, the confidence interval reported      #
#  in the prop.test() function output does not match the standard       #
#  two-sample z-confidence interval for proportions.                    #

###########
#  Power  #
###########

#  Recall that the power of a hypothesis test is the probability that   #
#  the null hypothesis will be rejected when the alternative hypothesis #
#  is true and that the sample size, significance level, and effect     #
#  size are used together to determine its value. There are power       #
#  functions corresponding to the various types of categorical tests.   #
#                                                                       #
#  The function pwr.chisq.test() is used to determine the power for     #
#  chi-squared tests for two-way tables and the goodness-of-fit tests.  #
#  Since the chi-squared distribution is used for the tests, an         #
#  additional input for the degrees of freedom is required. Since the   #
#  effect size is measuring a different quantity than in the normal     #
#  and t distribution based tests, the scale for small, medium, and     #
#  large effect sizes differ -- 0.1, 0.3, and 0.5, respectively.        #
#                                                                       #
#  Example: A sample of 400 individuals is to be randomly drawn to      #
#  determine whether there is a significant association between gender  #
#  and education level. The individuals will be classified into two     #
#  genders and four education levels. What is the power for this test   #
#  when there is a moderate association?                                #

## Calculate the power
library(pwr)
pwr.chisq.test(w=0.3, N=400, df=3, sig.level=0.05) 

## Determine the sample size required for power of 0.8
pwr.chisq.test(w=0.3, df=3, sig.level=0.05, power=0.8)

#  Example: It is thought that when given a standard treatment, 50% of  #
#  individuals with hypertension will show a marked decrease in blood   #
#  pressure, 25% of individuals with hypertension will show a moderate  #
#  decrease in blood pressure, 10% of individuals with hypertension     #
#  will show a slight decrease in blood pressure, and 15% of            #
#  individuals with hypertension will show no change in blood pressure. #
#  A random sample of 200 individuals with hypertension will be         #
#  selected and each will be given a new treatment to test if there is  #
#  evidence that individuals react differently to this treatment than   #
#  to the standard treatment. What is the power if there is a slight    #
#  difference between the treatments?                                   #

## Calculate the power
pwr.chisq.test(w=0.1, N=200, df=3, sig.level=0.05)

## Determine the sample size required for power of 0.8
pwr.chisq.test(w=0.1, df=3, sig.level=0.05, power=0.8)

#  The function pwr.p.test() is used to determine the power for the     #
#  one-sample z-test for proportions. Since the standard deviation is   #
#  dependent on the true value of the proportion, the effect size       #
#  cannot be calculated exactly. Since the effect size is a             #
#  standardized difference, the absolute values 0.2, 0.5, and 0.8 can   #
#  be used to denote small, medium, and large effect sizes,             #
#  respectively. The sign of the effect size should reflect the         #
#  relative sizes of the alternate value and assumed value. If the      #
#  alternate value is greater than the assumed value, then the effect   #
#  size should be positive and vice versa.                              #
#                                                                       #
#  Example: A student hears that 10% of the U.S. population is          #
#  left-handed and wants to determine if his school has a lower         #
#  proportion than the general population. To investigate, he plans to  #
#  randomly sample 100 of his fellow students. What is the power of     #
#  the student's test when the true proportion is slightly lower?       #

## Calculate the power
pwr.p.test(h=-0.2, n=100, sig.level=0.05, alternative="less")

## Determine the sample size required for power of 0.8
pwr.p.test(h=-0.2, sig.level=0.05, power=0.8, alternative="less")

#  The function pwr.2p.test() is used to determine the power for the    #
#  two-sample z-test for proportions when the sample sizes in the two   #
#  groups are equal.                                                    #
#                                                                       #
#  The function pwr.2p2n.test() is used to determine the power for the  #
#  two-sample z-test for proportions when the samle sizes in the two    #
#  groups vary. This function requires two inputs for the two sample    #
#  sizes.                                                               #
#                                                                       #
#  Example: The sample poverty rate in 2001 is to be measured using a   #
#  sample of 5,000 individuals. The sample poverty rate in 2002 is to   #
#  be measured using a sample of 6,000 individuals. What is the power   #
#  of the test for whether there is significant evidence that the U.S.  #
#  poverty rate changed from 2001 to 2002 when the effect size is       #
#  relatively small?                                                    #

## Calculate the power
pwr.2p2n.test(h=0.1, n1=5000, n2=6000, sig.level=0.05, alternative="two.sided")

#  Example: If the sample size from 2001 remains 5,000, what does the   #
#  sample size for 2002 need to be to yield a power of 80%?             #

## Determine the sample size required for power of 0.8
pwr.2p2n.test(h=0.1, n1=5000, sig.level=0.05, power=0.8, alternative="two.sided")

#################################
#  Hypothesis testing examples  #
#################################

#  Additional example:                                                  #
#  A certain dietary supplement promotes weight loss. To estimate the   #
#  weight loss due to the supplement, a random sample of 12 people      #
#  taking the supplement was selected. Each participant's weight loss   #
#  was rounded to the nearest pound and recorded.                       #
#     0 2 0 1 0 2 5 1 3 1 1 6                                           #
#  Is there evidence that the dietary supplement significantly          #
#  increases weight loss?                                               #



#  Additional example:                                                  #
#  The USDA uses sample surveys to estimate important economic values.  #
#  One of the quanities estimated by the USDA is the price of wheat     #
#  per bushel. Suppose that once per month, the USDA takes a random     #
#  sample of 8 producers for a quick check on the wheat prices between  #
#  the larger, more comprehensive surveys. The prices obtained in July  #
#  and September are given below. Is there evidence that the prices     #
#  changed significantly in that time?                                  #
#     July       $6.83 $7.30 $7.03 $7.09 $7.30 $7.12 $7.07 $7.26        #
#     September  $7.33 $7.55 $7.31 $7.36 $7.56 $7.59 $7.44 $7.51        #



#  Additional example:                                                  #
#  Many journal articles reference websites. Some domains are           #
#  considered to be more trustworthy than others, so a study was        #
#  conducted to determine the domain source of these references. A      #
#  selection of articles found in the journal, Science, was examined    #
#  and the number of references of each domain was recorded. The        #
#  standard domain distribution is 5% for both .com and other domains   #
#  and 30% each for .gov, .org, and .edu domains. Does Science follow   #
#  the standard domain distribution for its references?                 #



#  Additional example:                                                  #
#  The Survey of Study Habits and Attitude (SSHA) is a psychological    #
#  test designed to measure the motivation, study habits, and           #
#  attitudes toward learning of college students. The potential scores  #
#  range from 0 to 200. A selective private college selects a random    #
#  sample of men and women to complete the SSHA. Most studies using     #
#  the SSHA find that women typically score higher than men. Is this    #
#  the case at this college?                                            #
#     Men:   118 140 114  91 180 115 126  92 169 139 121 132  75  88    #
#            113 151  70 115 187 114                                    #
#     Women: 156 109 137 115 152 140 154 178 111 123 126 126 137 165    #
#            165 129 200 150                                            #



#  Additional example:                                                  #
#  A company that builds machines to cut eyeglass lenses for opticians  #
#  designs their machines to cut lenses with an average thickness of    #
#  3.20 millimeters (mm) with a standard deviation of 0.34 mm. A        #
#  technician at a lab that has been using this company's machines      #
#  thinks that the lenses seem to be thinner recently. The lab          #
#  technician cuts a random sample of 10 lenses, which yields a mean    #
#  of 3.05 mm and a standard deviation of 0.27mm. Is the technician     #
#  onto something?                                                      #



#  Additional example:                                                  #
#  Power companies spend a great deal of time and money trimming large  #
#  trees with branches that could damage power lines during a storm.    #
#  To this end, researchers are developing hormone and chemical         #
#  treatments that will stunt or slow tree growth. In an experiment on  #
#  216 sycamore trees, 175 of the trees were stunted while the          #
#  remaining trees died because the treatment was too severe. If more   #
#  than 15% of treated trees die, the treatment will not be used. What  #
#  should the power company do?                                         #



#  Additional example:                                                  #
#  A consulting firm has been hired by a business association to        #
#  determine characteristics of companies that succeed and companies    #
#  that fail. The consulting team selected a sample from each           #
#  classification of company and requested several pieces of            #
#  information, including the latest ratio of assets to liabilities.    #
#  Could this ratio be a factor in the success of the future of the     #
#  company?                                                             #
#     Successful: 1.50 2.08 2.23 0.89 1.91 0.93 1.95 2.73 1.62 1.71     #
#                 1.03 1.96 0.10 1.43 2.50 0.23 1.67 2.17 2.61 1.56     #
#                 1.76 1.02 1.80 1.81 1.76 0.68 2.02 1.20 1.87 2.61     #
#                 1.11 2.73 2.22 2.50 0.67 1.14 3.15 1.44 2.16 1.21     #
#                 3.05 0.95 0.90 2.80 1.55 2.44                         #
#         Failed: 0.82 0.05 1.68 0.91 1.16 0.42 0.88 1.11 2.03 0.92     #
#                 0.13 0.89 0.83 0.99 0.52 1.32 0.48 1.10 0.19 0.51     #
#                 0.26 0.88 1.31 0.90 0.62 1.45 1.17 0.93 0.23 0.13     #
#                 1.12 1.15 0.09                                        #



#  Additional example:                                                  #
#  A new type of lightbulb that is significantly cheaper than its       #
#  competitors advertises that the average lifetime of these bulbs is   #
#  750 hours. The manager of a large office has decided to enter into   #
#  a purchase agreement unless there is significant evidence that the   #
#  typical lifetime is less than advertised. A random sample of 50      #
#  bulbs is selected. Should the manager go forward with the purchase   #
#  agreement?                                                           #
#     766 763 708 746 746 775 729 703 707 740 738 757 702 746 702 767   #
#     727 731 729 763 740 770 737 767 756 745 753 776 725 734 723 730   #
#     721 753 727 739 716 748 703 772 720 776 734 726 703 749 746 760   #
#     767 705                                                           #



#  Additional example:                                                  #
#  The average final grade in a larger physics class has consistently   #
#  been 74% over the past several years. The professor decided to       #
#  incorporate different activities into the course this past semester  #
#  and is curious if the higher engagement during class led to a        #
#  higher class average. This semester, the final grades for the 123    #
#  students enrolled in his class averaged 77% with a standard          #
#  deviation of 11%. What should the professor conclude?                #



#  Additional example:                                                  #
#  A survey has been repeated over several years to study the use of    #
#  Internet over time. A random sample of the same number of households #
#  was taken in 2001, 2004, 2007, and 2008. Has the use of Internet     #
#  changed over this time period?                                       #
#                 2001  2004  2007  2008                                #
#     Broadband:   113   540  1080  1238                                #
#       Dial-up:   922   675   360   270                                #
#          None:  1215  1035   810   742                                #



#  Additional example:                                                  #
#  A researcher draws a sample of 13 local businesses and records the   #
#  number of customers served in a particular time period to test       #
#  whether the number of customers served by this type of local         #
#  business is typically less than 120 per day. What should the         #
#  researcher conclude?                                                 #
#     131 68 183 141 127 122 111 89 65 133 48 109 97                    #



#  Additional example:                                                  #
#  A professor from the Women, Gender, and Sexuality department and     #
#  from the Statistics department are collaborating on a study to       #
#  determine if STEM textbooks contain gender bias. One engineering     #
#  textbook was chosen for a pilot study to determine if a wider study  #
#  should be conducted. A random sample of sentences was drawn from     #
#  the textbook and the number of female and male references were       #
#  counted: 60 female (population 1) and 132 male (population 2). The   #
#  professors then classified these references into juvenile (boy,      #
#  girl) and adult (man, woman) references. Of the female references,   #
#  37 were classified as juvenile and, of the male references, 52 were  #
#  classified as juvenile. Is there evidence that this engineering      #
#  textbook uses juvenile references for females more often than it     #
#  does for males?                                                      #



#  Additional example:                                                  #
#  A consumer wonders how many highway miles per gallon (mpg) her car   #
#  gets. The manufacturer advertises a highway mileage of 31 mpg. This  #
#  consumer drives on an interstate that does not have much traffic     #
#  during her morning commute, so she is able to set her cruise         #
#  control to 60 miles per hour. She takes a random sample of 17 days   #
#  and records her car's calculation of mpg during the time that her    #
#  car is set to cruise control. Is the consumer's car in line with     #
#  the manufacturer's advertised mileage?                               #
#     36.1 21.5 23.9 29.6 21.9 28.4 30.3 22.5 19.4 15.3 20.2 24.7 
#     37.9 20.3 33.5 21.5 14.7



#  Additional example:                                                  #
#  In economic downturns, companies may undertake a reduction in the    #
#  size of their workforce by laying off employees. Federal law         #
#  requires that employees be treated the same regardless of age.       #
#  Below is the data for a round of lay-offs at one company. Is there   #
#  evidence of discrimination?                                          #
#                     16-25   26-35   36-45   46-55   55+               #
#     Laid-off            7      10       9      27     2               #
#     Not laid-off      321     296     268     451   104               #



#  Additional example:                                                  #
#  Two random samples are taken independently from among high school    #
#  students, one from female students and another from male students.   #
#  Both groups are asked if they plan to attend college. Of the 100     #
#  female students selected, 75 reported planning to attend college.    #
#  Of the 140 male students selected, 91 reported planning to attend    #
#  college. Are males more likely to attend college than females?       #



#  Additional example:                                                  #
#  Remote deposit capture (RDC) is the service that allows users to     #
#  transmit an image of a check for deposits. The American Bankers      #
#  Association (ABA) takes an annual random survey of community banks.  #
#  This year, the survey collected information on availability of RDC.  #
#  The ABA assumes that the availability of RDC is equal over the       #
#  various regions of the country. Of the 289 selected banks that       #
#  offer RDC, 28 are in the Northeast, 57 are in the Southeast, 53 are  #
#  in the Central US, 63 are in the Midwest, 27 are in the Southwest,   #
#  and 61 are in the West. Does the survey support the ABA's            #
#  assumption?                                                          #



#  Additional example:                                                  #
#  Insurance adjusters are concerned about the high repair estimates    #
#  that they are receiving from Buddy's Car Repair. To investigate,     #
#  they enlisted 10 customers to take their car to Buddy's and to a     #
#  trusted shop and report the estimates of each. Is there evidence     #
#  that Buddy's is inflating their prices?                              #
#     Buddy's  500  1550  1250  1300  750  1000  1210  1300  800  2500  #
#     Other    430  1500  1300  1280  780   870  1120  1140  650  2290  #



#########################################################################

### IN CLAS ###
library(ggplot2)
k <- 10000
n <-70
ps <- 0.1
mu <- n * ps
sigma <- sqrt(n*ps*(1-ps))
df <- data.frame(samps=rbinom(n=k, size=n, prob=ps))
ggplot(df, aes(x=samps)) + 
  geom_histogram(binwidth = 1, aes(y=..density..), colour="black", fill="white") + 
  stat_function(fun=dnorm, args=list(mean=mu, sd=sigma))

