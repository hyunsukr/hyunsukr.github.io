##
## File: exam1-sample.py (STAT 3250)
## Topic: Array for Exam 1 Sample Questions
## 

import numpy as np # load "numpy"

array1 = np.array([[5,0,-4,3,5,7,2],
                   [0,-1,-1,5,3,4,-4],
                   [3,0,-2,-5,6,-2,1],
                   [2,5,-4,-3,-1,0,3],
                   [5,5,6,0,-3,-3,-6]])


## extract second and third rows
array1[1:3,]

## Extract the second and 5th row
array1[(1,4),] 

## extract the second and fourth column
## need : in front of ,
array1[:,(1,3)]

## first and third rows
## second and third columns
array1[[0,2]] #get rows first
array1[[0,2]][:,(1,2)] #then get the second and third columns

## replace negatives with 0
array1d = np.where(array1 < 0, 0, array1) #use where function
array1d
np.where(array1 < 0 , "hello", array1)
array1

## find mean of even numbers
array1e = np.mean(array1[array1 % 2 == 0])
array1e.mean()
np.mean(array1e)

## all positives become 1 and if not then opposite
array1p = np.where(array1 > 0 , 1, -array1)
array1p

import pandas as pd
grades = pd.read_csv('samplegrades.csv')
grades

#Q2
## Get average of final
avg = np.mean(grades["Final"])
print(avg)

## at lesat 5
count = grades[grades["APDE"] >= 5]
#get the lenght of where it is greater than 5
percentage = 100*(len(count)/len(grades))
print(percentage)
#or we can do

100*np.sum(grades['APDE'] >= 5)/len(grades)

## This is the professors way
np.sum(grades["CourseAve"] > 80)/len(grades)

## Get the mean of midterms
## First subset...then select column then get the mean
grades[grades["Prev"] == "Y"]["Midterm"].mean()


## Number of females in TR930
## This is sum the counts of where tr930 and female
np.sum((grades["Sect"] == "TR930") & (grades["Gender"] == "F"))

## Average HW score for each year of students under year
list(grades)
subset = grades["HW"].groupby(grades["Year"])
subset.mean()
"""
Year
1    189.243768
2    186.299286
3    189.282692
4    192.951724
"""

##Average Quiz score for each section
list(grades)
subsetsect = grades["Quiz"].groupby(grades["Sect"])
subsetsect.mean()
"""
Sect
MW200     38.983240
TR1230    39.353535
TR930     37.878307
"""

## Subset by each section and get final grades and max function
subsetsect = grades["Final"].groupby(grades["Sect"])
subsetsect.max()
"""
Sect
MW200      97.5
TR1230     97.5
TR930     100.0
"""

##number of males students with course average of less than 75
np.sum((grades["Gender"] == "M") & (grades["CourseAve"] < 75))

## Determine the percentage of students that had higher 
## final exam score than midterm score

np.sum((grades["Final"]) > (grades["Midterm"]))/len(grades) * 100
"""
39.399293286219084
"""

## The column Calc contains information on how the calculus 
## prerequisite was fulfilled
females = grades[grades["Gender"] == "F"]
five = np.sum(females["Calc"] == "AP5")
four = np.sum(females["Calc"] == "AP4")
(five + four)/len(females)

## Number of students that had a grade of A- or were 3rd yeras
grades["Year"]
np.sum( (grades["Grade"] == "A-") | (grades["Year"] == 3)) #use | for or

##For each year of students, determine the mean course average for the male students
subsetmale = grades[grades["Gender"] == "M"]
subsetyear = subsetmale["CourseAve"].groupby(subsetmale["Year"])
subsetyear.mean()
"""
Year
1    81.285348
2    78.119769
3    81.761786
4    86.968800
"""

subset12 = grades[grades["Final"] < grades["Midterm"]]
100 * np.sum(subset12["HW"] == 200)/len(subset12)

## Question 3
import numpy as np
np.random.exponential(scale = 10, size =1)[0]
total = 0
for i in range(100000):
    totalcount = 0
    iteration = 0
    while totalcount < 4:
        if (np.random.exponential(scale = 10, size =1)[0] < 7):
            totalcount = totalcount + 1
        iteration = iteration + 1
    total = total + iteration
print(total/100000)

## Question 4
total = 0
for i in range(100000):
    maximum = np.random.uniform(low=5, high=20, size = 10).max()
    total = total + maximum
total/100000

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

100*(((total/100000) - 20)/20)
    
        


