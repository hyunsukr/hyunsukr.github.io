#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan 29 15:35:06 2019

@author: maxryoo
"""

##
## File: assignment02.py (STAT 3250)
## Topic: Assignment 2
## Name: Max Ryoo
## Computing ID: hr2ee

## 1.
##
## 1(a) Generate an array x of 10000 random values from 
##      a uniform distribution on the interval [0,50],
##      then use a for loop to determine the percentage     
##      of values that are in the interval [8,27].

import numpy as np # "as np" lets us use "np"; only run once
x = np.random.uniform(low=0,high=50,size=10000) #get 10000 random values 
counter1a = 0 #set up a counter variable
for i in x: #for everything in samp
    if 8 <= i <= 27: #check if the value is between 8 and 27
        counter1a = counter1a + 1 #add 1 to the counter variable if it is in the range
percentage = counter1a / 10000 #get the percentage that is in the range
print(percentage * 100) #print the percentage

"""
1a.

ans = 38.04
"""

## Note: 1(a) asks for a percentage, not a count and not
##       a proportion.

## 1(b) Repeat 1(a) 1000 times, then compute the average
##      of the 1000 percentages found.
totalsum = 0
for i in range(0,1000): #for index i that takes value between 0 and length of list
    counter1b = 0 #set up a counter variable
    samp = np.random.uniform(low=0, high=50, size=10000) #get a uniform dist same as 1a
    for j in samp: #for thing in samp
        if 8<= j <= 27: #check if the value is bewteen 8 and 27
            counter1b = counter1b + 1 #add one to the counter if it is
    percentage = counter1b / 10000 # get the percentage
    totalsum = totalsum + percentage #add the percentage to the sum counter
average = totalsum/1000 #divide the added up percentages by 1000
print(average *100) #get the average percentage

"""
1b.

ans = 37.98780999999999
"""

## 1(c) For the array x in 1(a), use a while loop to determine 
##      the number of random entries required to find the
##      first that is less than 3.

index = 0 #set index
while x[index] >= 3: #while value at that index is greater than or equal to 3
    index = index + 1 #add 1 to the index to check next index
print(index + 1) #add one since index starts at zero
"""
1c.

ans = 3
"""

## 1(d) Repeat 1(c) 1000 times, then compute the average for the
##      number of random entries required.

totalsum1d = 0 # total sum variable
for i in range(0,1000): #for i in range 0, 1000. Repeat 1000
    samp = np.random.uniform(low=0, high=50, size=10000) #take uniform sample
    index = 0 #index variable
    while samp[index] >= 3: #while the value at that index is greater than three
        index = index + 1 #add 1 to the index
    totalsum1d = totalsum1d + index + 1 #add that index to the total sum variable
average = totalsum1d / 1000 #get average
print(average) #print

"""
1d.

ans = 17.334
"""

## 1(e) For the array x in 1(a), use a while loop to determine 
##      the number of random entries required to find the
##      third entry that exceeds 36.

index = 0 #set index
third = 0 #set third variable
while third != 3:
    while x[index] <= 36: #while value at that index is less than or equal to 36
        index = index + 1 #add 1 to the index to check next index
    third = third + 1
    index = index + 1
print(index) #add one since index starts at zero


"""
1e

ans = 15
"""

## 1(f) Repeat 1(e) 5000 times, then compute the average for the
##      number of random entries required.
totalsum1f = 0 #set a counter variable
for i in range(0,5000): #do this trial 5000 times
    samp = np.random.uniform(low=0, high=50, size=10000) #get a uniform distirbution
    index = 0 #set index
    third = 0 #set third variable
    while third != 3:
        while samp[index] <= 36: #while value at that index is less than or equal to 36
            index = index + 1 #add 1 to the index to check next index
        third = third + 1
        index = index + 1
    totalsum1f = totalsum1f + index #add one to index and add it totalsum1f
average = totalsum1f / 5000 #get the percentage
print(average)

"""
1f

ans = 10.7998
"""

## 2.   For this problem you will draw samples from a normal
##      population with mean 40 and standard deviation 12.
##      Run the code below to generate your population, which
##      will consist of 1,000,000 elements.

import numpy as np 
p1 = np.random.normal(40,12,size=1000000)

## 2(a) The formula for a 95% confidence interval for the 
##      population mean is given by
##     
##      [xbar - 1.96*sigma/sqrt(n), xbar + 1.96*sigma/sqrt(n)]
##
##      where xbar is the sample mean, sigma is the population
##      standard deviation, and n is the sample size.
##
##      Select 10,000 random samples of size 10 from p1.  For
##      each sample, find the corresponding confidence 
##      interval, and then determine the percentage of
##      confidence intervals that contain the population mean.
##      (This is an estimate of the confidence level.)

counter2b = 0 #have a counter variable
sigma = np.std(p1, ddof=1)
for i in range(0, 10000): #do this trial 10,000 times
    s = np.random.choice(p1, size=10) #select 10 random samples from p1
    lcl = np.mean(s) - 1.96*sigma/(10**0.5) #find lower confidence level
    ucl = np.mean(s) + 1.96*sigma/(10**0.5) #find upper confidence level
    if lcl <= 40 <= ucl: #if 40 is in the range
        counter2b = counter2b + 1 #add one to the counter
percentage = counter2b/10000 #find the percentage
print(percentage *100) #print the percentage

"""
2a. 

ans = 94.67
"""

## 2(b) Frequently in applications the population standard
##      deviation is not known. In such cases, the sample
##      standard deviation is used instead.  Repeat part 2(a)
##      replacing the population standard deviation with the
##      standard deviation from each sample, so that the
##      formula is
##
##      [xbar - 1.96*stdev/sqrt(n), xbar + 1.96*stdev/sqrt(n)]
##
##      Tip: Recall the command for the standard deviation is 
##           np.std(data, ddof=1)

counter2b = 0 #have a counter variable
for i in range(0, 10000): #do this trial 10,000 times
    s = np.random.choice(p1, size=10) #select 10 random samples from p1
    lcl = np.mean(s) - 1.96*np.std(s, ddof=1)/(10**0.5) #find lower confidence level
    ucl = np.mean(s) + 1.96*np.std(s, ddof=1)/(10**0.5) #find upper confidence level
    if lcl <= 40 <= ucl: #if 40 is in the range
        counter2b = counter2b + 1 #add one to the counter
percentage = counter2b/10000 #find the percentage
print(percentage*100) #print the percentage

"""
2b.

ans= 91.83
"""

## 2(c) Your answer in part 2(b) should be a bit off, in that
##      the estimated confidence level isn't quite 95%.  The 
##      problem is that a t-distribution is appropriate when
##      using the sample standard deviation.  Repeat part 2(b),
##      this time using t* in place of 1.96 in the formula,
##      where: t* = 2.262 for n = 10.

counter2b = 0 #have a counter variable
for i in range(0, 10000): #do this trial 10,000 times
    s = np.random.choice(p1, size=10) #select 10 random samples from p1
    lcl = np.mean(s) - 2.262*np.std(s, ddof=1)/(10**0.5) #find lower confidence level
    ucl = np.mean(s) + 2.262*np.std(s, ddof=1)/(10**0.5) #find upper confidence level
    if lcl <= 40 <= ucl: #if 40 is in the range
        counter2b = counter2b + 1 #add one to the counter
percentage = counter2b/10000 #find the percentage
print(percentage*100) #print the percentage

"""
2c.

ans = 94.69999999999999
"""

## 3.   Suppose that random numbers are selected one at a time
##      with replacement from among the set 0, 1, 2, ..., 8, 9.
##      Use 10,000 simulations to estimate the average number 
##      of values required to select three identical values in 
##      a row.
countertotal = 0
for i in range(10000): #repeat 10000 times
    x1 = np.random.choice(10, size=1) #draw once
    x2 = np.random.choice(10, size=1) #draw twice
    ct =2 #picked twice so far
    done = 0 #finished variable
    while done == 0: #while not done
        x3 = np.random.choice(10, size=1) #pick a third
        ct += 1 #increase trials counter
        if x1 == x2 and x2 == x3: #if all are equal
            done = 1 #set done
        else: #if not
            x1 = x2 #set the second as first and 
            x2 = x3 #last as second
    countertotal = countertotal + ct  
print(countertotal/10000)
"""
3.

ans = 112.3539
"""

        
## 4.   Jay is taking a 20 question true/false quiz online.  The
##      quiz is configured to tell him whether he gets a question
##      correct before proceeding to the next question.  The 
##      responses influence Jay's confidence level and hence his 
##      exam performance.  In this problem we will use simulation
##      to estimate Jay's average score based on a simple model.
##      We make the following assumptions:
##    
##      * At the start of the quiz there is a 80% chance that 
##        Jay will answer the first question correctly.
##      * For all questions after the first one, if Jay got 
##        the previous question correct, then there is a
##        88% chance that he will get the next question
##        correct.  (And a 12% chance he gets it wrong.)
##      * For all questions after the first one, if Jay got
##        the previous question wrong, then there is a
##        70% chance that he will get the next question
##        correct.  (And a 30% chance he gets it wrong.)
##      * Each question is worth 5 points.
##
##      Use 10,000 simulated quizzes to estimate the average 
##      score.

totalaverage = 0
for i in range(0,10000):
    chance_correct = 0.80
    totalscore = 0
    for i in range(0,20):
        corr = np.random.choice([0,1], size = 1, p=[chance_correct, (1-chance_correct)])
        if corr[0] == 0:
            totalscore = totalscore + 5
            chance_correct = 0.88
        else:
            chance_correct = 0.70
    totalaverage = totalaverage + totalscore
print(totalaverage/10000)

"""
4. 

ans = 85.0295
"""

## 5.   The questions in this problem should be done without the 
##      use of loops.  They can be done with NumPy functions.
##      The different parts use the array defined below.

import numpy as np # Load NumPy
arr1 = np.array([[2,5,7,0,2,5,-6,8,1,-9],[-1,3,4,2,0,1,3,2,1,-1],
                [3,0,-2,-2,5,4,5,9,0,7],[1,3,2,0,4,5,1,9,8,6],
                [1,1,0,1,5,3,2,9,0,-9],[0,1,7,7,7,-4,0,2,5,-9]])

## 5(a) Extract a submatrix arr1_slice1 from arr1 that consists of
##      the second and third rows of arr1.
print(arr1[1:3]) #Subset the second and third row
"""
5a. 

ans = array([[-1,  3,  4,  2,  0,  1,  3,  2,  1, -1],
       [ 3,  0, -2, -2,  5,  4,  5,  9,  0,  7]])
"""
    
## 5(b) Find a one-dimensional array that contains the entries of
##      arr1 that are less than -2.

print(arr1[arr1 < -2])  # Extract the values that areless than -2

"""
5b.

ans = array([-6, -9, -9, -4, -9])
"""
## 5(c) Determine the number of entries of arr1 that are greater
##      than 4.
count = np.sum((arr1 > 4)) #get the number of entries greater than 4
print(count) #print count

"""
5c.

ans = 18
"""
## 5(d) Find the mean of the entries of arr1 that are less than
##      or equal to -2.

mean = np.mean(arr1[arr1 <= -2]) #get the mean of entries of arr1 that are less than -2
print(mean) #print mean
"""
5d.

ans = -5.85714285714
"""

## 5(e) Find the sum of the squares of the odd entries of arr1.
oddarr = arr1[arr1 %2 == 1] #get the odd entries
squared = oddarr**2 # square all the terms
print(np.sum(squared)) #sum the terms

"""
5e.

ans = 962
"""
## 5(f) Determine the proportion of positive entries of arr1 
##      that are greater than 5.

positive = arr1[arr1 >= 1] #get positives number
proportion = np.sum((positive > 5))/len(positive) # get the proportion that is above 5
print(proportion) #print the proportion

"""
5f.

ans = 0.261904761905
"""
