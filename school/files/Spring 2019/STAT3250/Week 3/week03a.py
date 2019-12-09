##
## File: week03a.py (STAT 3250)
## Topic: Simulating confidence intervals
##

import numpy as np # load "numpy"

# Suppose that a large city has 500,000 voters that
# are evenly divided on an upcoming ballot issue.  The
# code below will simulate the population, assigning
# 0 (does not support) or 1 (supports) at random with
# equal probability to each voter.
pop = np.random.choice([0,1], size=500000, p=[0.5,0.5])

# According to the American Research Group online
# calculator (http://americanresearchgroup.com/sams.html)
# a sample of size 1067 is required to obtain an estimate 
# of the true population proportion within a margin of
# error of 3% for 95% of samples.  We can test the 95% figure 
# with simulation on our population.

# We use the "choice" function again, this time to choose
# a random sample from the population array pop.
s = np.random.choice(pop, size=1067)
s[0:20] # View the first 20 values in the random sample s

# Remark: The default sampling method for "choice" is
# with replacement.  Typically for surveys sampling is
# without replacement, but the simulation runs much
# slower when sampling is without replacement, and the
# large population makes repeats unlikely, so we use
# the default.

# The function "mean" adds up the entries in a list and
# divides by the length of the list, which (for this list)
# is exacly the proportion sampled who support the ballot
# issue
np.mean(s)

# A margin of error of 3% means a sample proportion between
# 0.47 and 0.53.  We can generate a lot of samples, then 
# determine if approximately 95% yield proportions between
# 0.47 and 0.53, as claimed.
ct = 0  # Counter of "successful" samples between 0.47 and 0.53
for i in range(100000):
    s = np.random.choice(pop, size=1067)
    prop = np.mean(s)  # Prop. sampled that support issue
    if prop >= 0.47 and prop <= 0.53: # True if 0.47<= prop <=0.53
        ct += 1  # Increment counter if 0.47<= prop <=0.53
ct/100000  # Proportion of samples that have 0.47<= prop <=0.53
           # Is this close to 95%?

# We can reduce the margin of error, but doing so also 
# reduces the probability that the sample proportion
# will be within the margin of error.  Here's the
# percentage for a 2% margin of error.
ct = 0  # Counter of "successful" samples between 0.48 and 0.52
for i in range(100000):
    s = np.random.choice(pop, size=1067)
    prop = np.mean(s)  # Prop. sampled that support issue
    if prop >= 0.48 and prop <= 0.52: # True if 0.48<= prop <=0.52
        ct += 1  # Increment counter if 0.48<= prop <=0.52
ct/100000  # Proportion of samples that have 0.48<= prop <=0.52

# Suppose that we want a margin of error large enough 
# so that 90% of samples are within the margin of error.
# This time we record all sample proportions, sort
# them, and find the 5th and 95th percentiles.  Then
# approximately 90% of proportions are between these
# values, giving us an approximate 90% confidence interval.
props = np.zeros(100000)  # Array to hold proportions
for i in range(100000):
    s = np.random.choice(pop, size=1067)
    props[i] = np.mean(s)  # Prop. sampled that support issue

np.percentile(props,5)  # 5th percentile
np.percentile(props,95)  # 95th percentile

# We can pull these together for the approximate 90% confidence 
# interval for the population proportion.
[np.percentile(props,5),np.percentile(props,95)]

# We can try the same thing for a 95% confidence interval, and
# compare to the results from earlier.
props = np.zeros(100000)  # Array to hold proportions
for i in range(100000):
    s = np.random.choice(pop, size=1067)
    props[i] = np.mean(s)  # Prop. sampled that support issue

np.percentile(props,2.5)  # 2.5th percentile
np.percentile(props,97.5)  # 97.5th percentile
[np.percentile(props,2.5),np.percentile(props,97.5)]

# In practice we only get one sample, and 95% confidence intervals 
# for proportions are found using the formula
#
#  [phat - 1.96*sqrt(phat*(1-phat)/n), phat + 1.96*sqrt(phat*(1-phat)/n)]
#
# where "phat" ("p-hat") is the sample proportion and "n" is the sample size.
# This formula can be used with just one sample.  Both the center and
# the margin of error (length) of the interval are influenced by
# the value of phat.  Let's test out this kind of interval, to see if
# it has a 95% confidence interval.  We'll take a sample size of
# n = 500.
ct = 0  # counter for successes
n = 500 # the sample size
p = np.mean(pop)  # The true mean of our population; close to 0.5
for i in range(100000):
    s = np.random.choice(pop, size=500) # Generate a random sample
    phat = np.mean(s)  # compute sample proportion
    lcl = phat - 1.96*np.sqrt(phat*(1-phat)/n) # lower conf. limit
    ucl = phat + 1.96*np.sqrt(phat*(1-phat)/n) # upper conf. limit
    if lcl <= p and ucl >= p:
        ct += 1
ct/100000  # We get a value fairly close to 95%
    
