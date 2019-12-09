"""
Created on Tue Jan 22 15:35:51 2019

@author: maxryoo
"""

##
## File: assignment01.py (STAT 3250)
## Topic: Assignment 1
## Name: Hyun Suk Ryoo (Max Ryoo)
## computing ID: hr2ee
##

## 1.  For the questions in this part, use the following
##     lists as needed:
list01 = [2,5,4,9,10,-3,5,5,3,-8,0,2,3,8,8,-2,-4,0,6]
list02 = [-7,-3,8,-5,-5,-2,4,6,7,5,9,10,2,13,-12,-4,1,0,5]
list03 = [2,-5,6,7,-2,-3,0,3,0,2,8,7,9,2,0,-2,5,5,6]
biglist = list01 + list02 + list03

## (a) Find the product of the last four elements of list02.

product = 1 ##Set an initial vairable
for i in list02[len(list02)-4::]: ## Get the last four elements of list02 and multiply
    product = product * i #set new value of product
print(product) #Print product
"""
## 1a

ans = 0
"""

## (b) Extract the sublist of list01 that goes from
##     the 3rd to the 11th elements (inclusive).

#subset from index 2(3rd element) to the 11th index (not included)
print(list01[2:11])
"""
## 1b

ans = [4, 9, 10, -3, 5, 5, 3, -8, 0]
"""

## (c) Concatenate list01 and list03 (in that order), sort
##     the combined list, then extract the sublist that 
##     goes from the 5th to the 15th elements (inclusive).

newlist = list01 + list03 #concatenate two lists
newlist.sort() #sort the newlist
print(newlist[4:15]) #get the desired elements by subsetting

"""
## 1c

ans = [-3, -2, -2, -2, 0, 0, 0, 0, 0, 2, 2]
"""

## (d) Generate "biglist", then extract the sublist of every 4th 
##     element starting with the 3rd element

print(biglist[2::4]) #subset the biglist ran beforehnd

"""
## 1d

ans = [4, 5, 0, 8, 6, -5, 6, 10, -4, 2, -2, 0, 9, 5]
"""

## 2.  Use for loops to do each of the following with the lists
##     defined above.
 
## (a) Add up the squares of the entries of biglist.
sum2a = 0 #set up a variable
for i in biglist: #go through the biglist and square each term and add it to the variable
    sum2a = sum2a + i**2
print(sum2a) #printthe variable

"""
## 2a

ans = 1825
"""

## (b) Create "newlist01", which has 19 entries, each the 
##     sum of the corresponding entry from list01 added 
##     to the corresponding entry from list02.  That is,
##     
##         newlist01[i] = list01[i] + list02[i] 
##
##     for each 0 <= i <= 18.

newlist01 = [0]*19 #make a list of 19 entries
for i in range(0,len(newlist01)): #for index i that takes value between 0 and length of list
    newlist01[i] = list01[i] + list02[i] #retrieve the index of list01 and list02 and add them together
print(newlist01) #print the new list

"""
## 2b

ans = [-5, 2, 12, 4, 5, -5, 9, 11, 10, -3, 9, 12, 5, 21, -4, -6, -3, 0, 11]
"""

## (c) Compute the mean of the entries of biglist.
##     (Hint: len(biglist) gives the number
##     of entries in biglist.  This is potentially useful.)

sumbiglist = 0 #set a variable
for i in biglist: #for i in biglist
    sumbiglist = sumbiglist + i #add the element of i into a sum variable
meanbiglist = sumbiglist/len(biglist) #divide the sum of the list by length of the list
print(meanbiglist) #print the mean

"""
## 2c

ans = 2.3684210526315788
"""

## (d) Determine the number of entries in biglist that
##     are less than 6.

counter = 0 #counter for entries less than 6
for i in biglist: #for every entry in biglist
    if i < 6: #if i is less than 6
        counter = counter + 1 #add one to the counter
print(counter) #print the counter variable

"""
## 2d

ans = 40
"""
## (e) Determine the number of entries in biglist that
##     are between -2 and 4 (inclusive).

counter2e = 0 #make a counter variable and set to zero
for i in biglist: #for every entry in biglist
    if -2 <= i <= 4: #if that entry is between -2 and 4
        counter2e = counter2e + 1 #add one to the counter variable
print(counter2e) #print the counter variable

"""
## 2e

ans = 22
"""

## (f) Create a new list called "newlist02" that contains 
##     the elements of biglist that are greater than 0.

newlist02 = [] #make an empty list
for i in biglist: #for every entry in biglist
    if i > 0: #if entry is greater than 0
        newlist02.append(i) #add it to the newlist02
print(newlist02) #print the new list02

"""
## 2f

ans = [2, 5, 4, 9, 10, 5, 5, 3, 2, 3, 8, 8, 6, 8, 4, 6, 7, 5, 9, 10, 2, 13, 1, 5, 2, 6, 7, 3, 2, 8, 7, 9, 2, 5, 5, 6]
"""


## 3.  In this problem you will be simulating confidence intervals
##     for samples drawn from a uniform distribution on [0,24], 
##     which has a mean of 12.
##     For instance, a sample of size 10 can be drawn with the 
##     commands
import numpy as np # "as np" lets us use "np"; only run once
samp = np.random.uniform(low=0,high=24,size=10)

## (a) Use random samples of size 20 and simulation to generate 
##     500,000 confidence intervals of the form
##     
##                           xbar +- 2
## 
##     Use your confidence intervals to estimate the confidence
#      level. (Give the level as a percentage.)

counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.uniform(low=0, high=24, size=20) #get a vector
    if np.mean(samp) - 2 <= 12  <= np.mean(samp) + 2: #check if 12 is in the interval
        counterinterval = counterinterval + 1 #add 1 if the thing is in the interval
print(counterinterval/500000 * 100) #divide and get proportion

"""
## 3a

ans = 80.2438
"""

## (b) Repeat (a) with confidence intervals xbar +- 3

counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.uniform(low=0, high=24, size=20) #get a vector
    if np.mean(samp) - 3 <= 12  <= np.mean(samp) + 3: #check if 12 is in the interval
        counterinterval = counterinterval + 1 #add 1 if the thing is in the interval
print(counterinterval/500000 * 100) #divide and get proportion
"""
## 3b

ans = 94.7706
"""

## (c) Repeat (a) with samples of size 30.

counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.uniform(low=0, high=24, size=30) #get a vector
    if np.mean(samp) - 2 <= 12  <= np.mean(samp) + 2: #check if 12 is in the interval
        counterinterval = counterinterval + 1  #add 1 if the thing is in the interval
print(counterinterval/500000 * 100)  #divide and get proportion
"""
## 3c

ans = 88.5466
"""


## (d) Repeat (b) with samples of size 30.
counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.uniform(low=0, high=24, size=30) #get a vector
    if np.mean(samp) - 3 <= 12  <= np.mean(samp) + 3:  #check if 12 is in the interval
        counterinterval = counterinterval + 1  #add 1 if the thing is in the interval
print(counterinterval/500000 * 100)  #add 1 if the thing is in the interval
"""
## 3d

ans = 98.3094
"""

## 4.  Here we repeat parts (a)-(d) of #3, but this time using
##     samples from an exponential distribution with mean 12.
##     The code below will produce a sample of size 10 with 
##     mean = 12:
samp = np.random.exponential(scale=12,size=10)

counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.exponential(scale=12,size=20) #get a vector
    if np.mean(samp) - 2 <= 12  <= np.mean(samp) + 2: #check if 12 is in the interval
        counterinterval = counterinterval + 1 #add 1 if the thing is in the interval
print(counterinterval/500000 * 100) #add 1 if the thing is in the interval

"""
## 4a

ans = 54.544
"""

## (b) Repeat (a) with confidence intervals xbar +- 3

counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.exponential(scale=12,size=20) #get a vector
    if np.mean(samp) - 3 <= 12  <= np.mean(samp) + 3:  #check if 12 is in the interval
        counterinterval = counterinterval + 1 #add 1 if the thing is in the interval
print(counterinterval/500000 * 100) #add 1 if the thing is in the interval
"""
## 4b

ans = 74.1366
"""

## (c) Repeat (a) with samples of size 30.

counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.exponential(scale=12,size=30)  #get a vector
    if np.mean(samp) - 2 <= 12  <= np.mean(samp) + 2: #check if 12 is in the interval
        counterinterval = counterinterval + 1 #add 1 if the thing is in the interval
print(counterinterval/500000 * 100)  #add 1 if the thing is in the interval
"""
## 4c

ans = 64.0684
"""


## (d) Repeat (b) with samples of size 30.
counterinterval = 0 #set a counter variable
for i in range(500000): #run this simulation 500,000
    samp = np.random.exponential(scale=12,size=30)  #get a vector
    if np.mean(samp) - 3 <= 12  <= np.mean(samp) + 3: #check if 12 is in the interval
        counterinterval = counterinterval + 1 #add 1 if the thing is in the interval
print(counterinterval/500000 * 100)  #add 1 if the thing is in the interval

"""
## 4d

ans = 83.3516
"""
