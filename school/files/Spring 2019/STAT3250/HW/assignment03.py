##
## File: assignment03.py (STAT 3250)
## Topic: Assignment 3
##
import pandas as pd
import numpy as np
absent = pd.read_csv('/Users/maxryoo/Documents/Spring 2019/STAT3250/HW/absent.csv')


##  The questions in this assignment refer to the data in the
##  file 'absent.csv'.  The data contains 740 records from an
##  employer, with 21 columns of data for each record.  (There
##  are a few missing values indicated by zeros where zeros 
##  are clearly not appropriate.)  The file 'absent.pdf' has
##  a summary of the meanings for the variables.

##  Questions 1 and 2 can be completed without loops.  You should
##  try to do them this way, grading will take this into account.

## 1.  All questions refer to the data set 'absent.csv'.

## 1(a) Find the mean absent time among all records.
absenttime = absent["Absenteeism time in hours"]#Get the column of absent time
mean = absenttime.mean() #get the mean
print(mean)
"""
1a.

ans = 6.924324324324324
"""


## 1(b) Determine the number of records corresponding to
##      being absent on a Thursday.
group1 = absent['Day of the week'] #get the days of week column
num_thurs = np.sum(group1 == 5) #get where days of week is a thursday and sum up entries
print(num_thurs) #print number of thursdays

"""
1b. 

ans = 125
"""

## 1(c) Find the number of different employees represented in 
##      this data.
num_emp = len(np.unique(absent["ID"])) #get unique ids and count how many there are
print(num_emp) #print the number of unique ids
"""
1c.

ans = 36
"""
## 1(d) Find the transportation expense for the employee with
##      ID = 34.

id34 = absent.loc[absent['ID'] == 34,:] #Get the entries where id == 34
sum_transportation = np.mean(id34["Transportation expense"]) #get the mean of transportation expense
print(sum_transportation) #print(expense)
"""
1d. 

ans = 118.0
"""

## 1(e) Find the mean number of hours absent for the records
##      for employee ID = 11.
id11 = absent.loc[absent['ID'] == 11,:] #subset where id == 11
mean_hours = np.mean(id11["Absenteeism time in hours"]) #average the absentteism time in hours
print(mean_hours) #print the hours

"""
1c.

ans = 11.25
"""
## 1(f) Find the mean number of hours absent for the records of those who 
##      have no pets, then do the same for those who have more than one pet.
nopets = absent.loc[absent['Pet'] == 0,:] #Group by pet
mean_numhours_nopets = np.mean(nopets["Absenteeism time in hours"]) #get the mean of hours

more_pet = absent.loc[absent['Pet'] > 1,:] #Group by pet greater than 1
mean_numhours_pets = np.mean(more_pet["Absenteeism time in hours"]) #get the mean of hours

print(str(mean_numhours_nopets) +  " vs " +  str(mean_numhours_pets)) #print result

"""
1f.

ans = 6.828260869565217 and 5.21830985915493
"""
## 1(g) Find the percentage of smokers among the records for absences that
##      exceeded 8 hours, then do the same for absences of no more then 4 hours.

smoke_8 = absent.loc[absent['Absenteeism time in hours'] > 8,:] #get the people that exceed 8
smoke_8_hours = np.sum(smoke_8["Social smoker"] == 1) #get the smokers from previous group
percentage = 100*smoke_8_hours/len(smoke_8) #get percentage
print(percentage) #print percentage

list(absent)
smoke_8 = absent.loc[absent['Absenteeism time in hours'] <= 4,:] #get the people that exceed 4
smoke_8_hours = np.sum(smoke_8["Social smoker"] == 1) #get the smokers from previous group
percentage = 100*smoke_8_hours/len(smoke_8) #get percentage
print(percentage) #print percentage
"""
1g.

ans = 6.34920634921 and 6.29067245119
"""

## 1(h) Repeat 1(g), this time for social drinkers in place of smokers.
drink_8 = absent.loc[absent['Absenteeism time in hours'] > 8,:] #get the people that exceed 8
drink_8_hours = np.sum(drink_8["Social drinker"] == 1) #get the smokers from previous group
percentage = 100*drink_8_hours/len(drink_8) #get percentage
print(percentage) #print percentage

drink_8 = absent.loc[absent['Absenteeism time in hours'] <= 4,:] #get the people that exceed 4
drink_8_hours = np.sum(drink_8["Social drinker"] == 1) #get the smokers from previous group
percentage = 100*drink_8_hours/len(drink_8) #get percentage
print(percentage) #print percentage

"""
1h.

ans = 73.0158730159 and 53.3622559653
"""


## 2.  All questions refer to the data set 'absent.csv'.

## 2(a) Find the top-5 employee IDs in terms of total hours absent.  List
##      the IDs and corresponding total hours absent.

sortbyhours = absent.sort_values(by = 'Absenteeism time in hours',ascending=False) # Sort by hours
top5_hours = sortbyhours.loc[:,['ID','Absenteeism time in hours']] # get the two columsn and get the first 5 entries
ansmatrix = top5_hours.groupby("ID").sum().sort_values(by="Absenteeism time in hours", ascending=False)[0:5]
## group by id and sum the hours then sort by the hours from top to bottom for the top5
print(ansmatrix)
"""
2a.

ans =
ID                        Absenteeism time in hours
3                         482
14                        476
11                        450
28                        347
34                        344
"""

## 2(b) Find the average hours absent per record for each day of the week.
##      Print out the day number and average.
hours_day = absent.loc[:, ['Day of the week','Absenteeism time in hours' ]] #get the two rows
ans_matrix2b = hours_day.groupby("Day of the week").mean() #get the mean after grouping by the day of the week!
print(ans_matrix2b) #print df
"""
2b.

ans =                  
Day of the week                   Absenteeism time in hours
2                                 9.248447
3                                 7.980519
4                                 7.147436
5                                 4.424000
6                                 5.125000
"""

## 2(c) Repeat 2(b) replacing day of the week with month.
hours_month = absent.loc[:, ['Month of absence','Absenteeism time in hours' ]] #get the two rows
ans_matrix2c = hours_month.groupby("Month of absence").mean() #get the mean after grouping by the month!
print(ans_matrix2c) #print df

"""
2c.

ans = 
                  Absenteeism time in hours
Month of absence                           
0                                  0.000000
1                                  4.440000
2                                  4.083333
3                                  8.793103
4                                  9.094340
5                                  6.250000
6                                  7.611111
7                                 10.955224
8                                  5.333333
9                                  5.509434
10                                 4.915493
11                                 7.507937
12                                 8.448980
"""

## 2(d) Find the top 3 most common reasons for absence for the social smokers,  
##      then do the same for the non-smokers. (If there is a tie for 3rd place,
##      include all that tied for that position.)
smoker = absent.loc[absent['Social smoker'] == 1] #get the smokers
smoker_absence = smoker['ID'].groupby(smoker['Reason for absence']).count().sort_values(ascending=False)
#group by reason for absence and count, then from this we should sort
print(smoker_absence[0:7]) #get the top 3 most common. 

smoker_non = absent.loc[absent['Social smoker'] == 0] #get th non smokers
smoker_absence_non = smoker_non['ID'].groupby(smoker_non['Reason for absence']).count().sort_values(ascending=False)
#group by reason for absence and count, then from this we should sort
print(smoker_absence_non[0:3]) #get the top 3 most common

"""
2d.

ans=
Reason for absence
0     8
25    7
19    4
18    4
28    4
22    4
23    4

and 

Reason for absence
23    145
28    108
27     69
"""

## 2(e) Suppose that we consider our data set as a sample from a much
##      larger population.  Find a 95% confidence interval for the 
##      proportion of the records that are from social drinkers.  Use
##      the formula 
##
##  [phat - 1.96*sqrt(phat*(1-phat)/n), phat + 1.96*sqrt(phat*(1-phat)/n)]
##
## where "phat" is the sample proportion and "n" is the sample size.

phat = len(absent.loc[absent["Social drinker"] == 1])/len(absent) #get the phat
lcl = phat - 1.96*(phat*(1-phat)/len(absent))**0.5 #get the lowe level
ucl = phat + 1.96*(phat*(1-phat)/len(absent))**0.5 #get the higher level
print("[" + str(lcl) + " , " + str(ucl) + "]")  #print
 
"""
2e.

ans = 
[0.5318725067607831 , 0.603262628374352]
"""

## 3.  For this problem we return to simulations one more time.  Our
##     topic is "bias" of estimators, more specifically the "percentage
##     relative bias" (PRB) which we take to be
##
##        100*((mean of estimated values) - (exact value))/(exact value)
##
##     For instance, to approximate the bias of the sample mean in 
##     estimating the population mean, we would computer
##
##        100*((mean of sample means) - (population mean))/(population mean)
##
##     For estimators that are "unbiased" we expect that the average
##     value of all the estimates will be close to the value of the
##     quantity being estimated.  In these problems we will approximate
##     the degree of bias (or lack of) by simulating.  In all parts we
##     will be sampling from a population of 10,000,000 values randomly
##     generated from an exponential distribution with scale = 10 using
##     the code below.

pop = np.random.exponential(scale = 10, size = 10000000)

## 3(a) Compute and report the mean for all of "pop".  Simulate 100,000
##      samples of size 10, compute the sample mean for each of the samples,
##      compute the mean of the sample means, and then compute the PRB.
list_mean = np.zeros(100000) #make array of all zeros
for i in range(100000): #do 100,000 iterations
    pops = np.random.choice(pop, size = 10) #select from pop of size 10
    mean = np.mean(pops) #get the mean
    list_mean[i] = mean #insert into array
mean_list = np.mean(list_mean) #get the mean of the array
prb = 100*( (mean_list-np.mean(pop))  /np.mean(pop)) #find the prb 
print(mean_list, "samp mean") #print
print(pop.mean(), "population mean") #print
print(prb, "prb") #print
"""
3a.

ans =
10.0085963409 samp mean
10.003345876 population mean
0.0524870875017 prb
"""

## 3(b) Compute and report the variance for all of "pop" using "np.var(pop)".  
##      Simulate 100,000 samples of size 10, then compute the sample variance 
##      for each sample using "np.var(samp)" (where "samp" = sample).  Compute 
##      the mean of the sample variances, and then compute the PRB.
##      Note: Here we are using the population variance formula on the samples
##      in order to estimate the population variance.  This should produce
##      bias, so expect something nonzero for the PRB.
var_list = np.zeros(100000) #make array of all zeros
for i in range(100000): #do 100,000 iterations
    pops = np.random.choice(pop, size = 10) #select from pop of size 10
    var = np.var(pops) #get the var
    var_list[i] = var #insert into array
var = np.mean(var_list) #get the mean of the array
prbvar = 100*( (var-np.var(pop))  /np.var(pop)) #find the prbvar
print(var, "samp var") #print
print(np.var(pop), "population var") #print
print(prbvar, "prb var") #print

"""
3b.

ans = 
90.4660948833 samp var
99.9666515291 population var
-9.50372599305 prb var
"""

## 3(c) Repeat 3(b), but this time use "np.var(samp, ddof=1)" to compute the
##      sample variances.  (Don't change "np.var(pop)" when computing the
##      population variance.)

var_list = np.zeros(100000) #make array of all zeros
for i in range(100000): #do 100,000 iterations
    pops = np.random.choice(pop, size = 10) #select from pop of size 10
    var = np.var(pops, ddof=1) #get the var
    var_list[i] = var #insert into array
var = np.mean(var_list) #get the mean of the array
prbvar = 100*( (var-np.var(pop))  /np.var(pop)) #find the prbvar
print(var, "samp var") #print
print(np.var(pop), "population var") #print
print(prbvar, "prb var") #print

"""
3c.

ans = 
99.7722084063 samp var
99.9666515291 population var
-0.194507988229 prb var
"""
## 3(d) Compute and report the median for all of "pop".  Simulate 100,000
##      samples of size 10, compute the sample median for each of the samples,
##      compute the mean of the sample medians, and then compute the PRB.
##      Note: For nonsymmetric distributions (such as the exponential) the
##      sample median is a biased estimator for the population median.  The
##      bias gets decreases with larger samples, but should be evident with 
##      samples of size 10.

median_list = np.zeros(100000) #make an empyt list
for i in range(100000):
    pops = np.random.choice(pop, size = 10) #select from pop of size 10
    median = np.median(pops) #get the median
    median_list[i] = median #insert into array
medmean = np.mean(median_list) #get the mean of the medians
prb = 100*( (medmean - np.median(pop))/np.median(pop)) #get the prb
print(medmean, "samp mean") #print
print(np.median(pop), "pop median") #print
print(prb, "prb") #print
"""
3d.

ans =
7.46138718463 samp mean
6.93796219541 pop median
7.54436208321 prb
"""
    
    
    
    
    
    
