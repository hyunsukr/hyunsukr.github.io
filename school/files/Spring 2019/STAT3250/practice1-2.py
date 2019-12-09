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

##Q1)
#a
array1[(1,3),]

#b
array1[:,(1,3)]

#c
array1[(0,2),]#Get first two rows
array1[(0,2),][:,(1,3)] #Get the columns

#d
arrayzero = np.where(array1 < 0, 0, array1 )
#where it is lower than 0 get zero if not array1 fill in
arrayzero

#e
arrayofeven = array1[array1 % 2 == 0]
np.mean(arrayofeven)

#f
np.where(array1 > 0, 1, -array1)

## Q2)
#a
import pandas as pd
grades = pd.read_csv('samplegrades.csv')
grades

#a
list(grades)
np.mean(grades["Final"])

#b
len(grades[grades["APDE"] >= 5])/len(grades) * 100

#c
len(grades[grades["CourseAve"] > 80])/len(grades)

#d
np.mean(grades[grades["Prev"] == "Y"]["Midterm"])

#e
np.sum((grades["Sect"] == "TR930") & (grades["Gender"] == "F"))

#f
subset = grades["HW"].groupby(grades["Year"])
subset.mean()

#g
subset = grades["Quiz"].groupby(grades["Sect"])
subset.mean()

#h
subset = grades["Final"].groupby(grades["Sect"]).max()
subset

#i
np.sum((grades["Gender"]=="M") & (grades["CourseAve"] < 75))

#j
len(grades[grades["Final"] >grades["Midterm"]])/len(grades) *100

#k
subsetfemal = grades[grades["Gender"] == "F"]
len(subsetfemal)
four = np.sum(subsetfemal["Calc"] == "AP4")
five = np.sum(subsetfemal["Calc"] == "AP5")
(four+five)/len(subsetfemal)

#l
np.sum( (grades['Grade']=='A-') | (grades['Year']==3) )

#m
male = grades[grades["Gender"] == "M"]
male["CourseAve"].groupby(male["Year"]).mean()

#n
subset = grades[grades["Midterm"] > grades["Final"]]
np.sum(subset["HW"] == 200) / len(subset) * 100

##Q3
np.random.exponential(scale = 10, size = 1)[0]
total = 0
for i in range(100000):
    counter = 0
    index = 0
    while counter <4:
        if np.random.exponential(scale = 10, size = 1)[0] < 7:
            counter = counter + 1
        index = index + 1
    total = total + index
total/100000

##Q4
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
