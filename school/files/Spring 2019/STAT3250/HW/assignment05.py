##
## File: assignment05.py (STAT 3250)
## Topic: Assignment 5
## Name: Max Ryoo

##  This assignment requires the data file 'diabetic_data.csv'.  This file
##  contains records for over 100,000 hospitalizations for people who have
##  diabetes.  The file 'diabetic_info.csv' contains information on the
##  codes used for a few of the entries.  Missing values are indicated by
##  a '?'.  You should be able to read in this file using the usual 
##  pandas methods.

import pandas as pd
import numpy as np
data = pd.read_csv("diabetic_data.csv")
##  Note: All questions on this assignment should be done without the explicit
##        use of loops in order to be eliglble for full credit.  

## 1.  Determine the average number of medications ('num_medications') for 
##     males and for females.
ans = data["num_medications"].groupby(data["gender"]).mean()
#for num_medications group by gender and get the mean of each group
ans = ans.drop(labels="Unknown/Invalid")
#remove unkonwn
print(ans)
#print
"""
1. 
ans = 
gender
Female    16.187888
Male      15.828775
"""
## 2.  Determine the average length of hospital stay ('time_in_hospital')
##     for each race classification.  (Omit those unknown '?' but include 
##     those classified as 'Other'.)
means = data["time_in_hospital"].groupby(data["race"]).mean()
#for time in hospital group by race and get the mean of each group
ans = means.drop(labels="?")
#drop the group ?
print(ans)
#print ans
"""
2. 
ans = 
race
AfricanAmerican    4.507860
Asian              3.995320
Caucasian          4.385721
Hispanic           4.059892
Other              4.273572
"""
## 3.  Among males, find a 95% confidence interval for the proportion that 
##     had at 2 or more procedures ('num_procedures').  Then do the same 
##     for females.
males = data[data["gender"] == "Male"] #subset males
phat = np.sum(males["num_procedures"] >= 2) / len(males) #prop of 2 or more in males
lclm = phat - 1.96*(phat*(1-phat)/len(males))**0.5 #get the lowe level
uclm = phat + 1.96*(phat*(1-phat)/len(males))**0.5 #get the higher level
print("[" + str(lclm) + " , " + str(uclm) + "]")  #print
females = data[data["gender"] == "Female"] #subset males
phat = np.sum(females["num_procedures"] >= 2) / len(females) #prop of 2 or more in males
lclf = phat - 1.96*(phat*(1-phat)/len(females))**0.5 #get the lowe level
uclf = phat + 1.96*(phat*(1-phat)/len(females))**0.5 #get the higher level
print("[" + str(lclf) + " , " + str(uclf) + "]")  #print
"""
3.
ans = 
[0.3551161035669802 , 0.36378730733515563] Male
[0.31516986803938 , 0.32298177340245665] Female
"""

## 4.  Among the patients in this data set, what percentage had more than
##     one recorded hospital visit?  (Each distinct record can be assumed 
##     to be for a distinct hospital visit.)
patient = data.groupby("patient_nbr") #group by patient
encounter = patient.size() #get the counts
subsetmore = encounter[encounter > 1] #get patients more than one visit
percentage = 100*len(subsetmore)/len(encounter) #get percentage
print(percentage) #print percentage
"""
4. 
ans = 
23.452837048015883
"""
## 5.  List the top-10 most common diagnoses, based on the codes listed in
##     the columns 'diag_1', 'diag_2', and 'diag_3'.
total_diag = data["diag_1"].append(data["diag_2"].append(data["diag_3"]))
grouped = total_diag.groupby(total_diag)
table = grouped.size()
ans = table.sort_values(ascending=False)[0:10]
print(ans)
"""
5.
ans=
428    18101
250    17861
276    13816
414    12895
401    12371
427    11757
599     6824
496     5990
403     5693
486     5455
"""
## 6.  The 'age' in each record is given as a 10-year range of ages.  Assume
##     that the age for a person is the middle of the range.  (For instance,
##     those with 'age' [40,50) are assumed to be 45.)  Determine the average
##     age for each classification in 'insulin'.
byage = data[:]
#make a copy
byage["age"] = byage["age"].replace(["[0-10)","[10-20)","[20-30)","[30-40)","[40-50)","[50-60)","[60-70)", "[70-80)","[80-90)","[90-100)"], [5,15,25,35,45,55,65,75,85,95])
#replace values
grouped = byage["age"].groupby(byage["insulin"])
#group by insulin and get age
ans = grouped.mean() #get the mean age
print(ans) #print the table
"""
6.
ans = 
insulin
Down      63.300049
No        67.460165
Steady    65.571169
Up        63.673560
"""

## 7.  Among those whose weight range is given, assume that the actual
##     weight is at the midpoint of the given interval.  Determine the
##     average weight for those whose 'num_lab_procedures' exceeds 50,
##     then do the same for those that are fewer than 30.
above50 = data[data["num_lab_procedures"] > 50]
#subset above 50
above50[above50["weight"] != "?"]["weight"].unique()
#get the ranges
above50["weight"] = above50["weight"].replace(["[0-25)","[25-50)","[50-75)","[75-100)","[100-125)","[125-150)","[150-175)","[175-200)",">200","?"],[((0+25)/2),((25+50)/2),((50+75)/2),((75+100)/2),((100+125)/2),((125+150)/2),((150+175)/2),((175+200)/2),200,np.nan])
#replace values
fweight = above50["weight"].mean()
#get the mean
less30 = data[data["num_lab_procedures"] < 30]
#subset above <30
less30[less30["weight"] != "?"]["weight"].unique()
#get the ranges
less30["weight"] = less30["weight"].replace(["[0-25)","[25-50)","[50-75)","[75-100)","[100-125)","[125-150)","[150-175)","[175-200)",">200","?"],[((0+25)/2),((25+50)/2),((50+75)/2),((75+100)/2),((100+125)/2),((125+150)/2),((150+175)/2),((175+200)/2),200,np.nan])
#replace values
tweight = less30["weight"].mean()
#get mean
print(fweight, "Exceeds 50", tweight, "Under 30")
"""
7. 
ans = 
85.05018489170628 Exceeds 50 88.73546511627907 Under 30
"""
## 8.  Three medications for type 2 diabetes are 'glipizide', 'glimepiride',
##     and 'glyburide'.  There are columns in the data for each of these.
##     Determine the number of records for which at least two of these
##     are listed as 'Steady'.

med1 = data["glipizide"] == "Steady"
#is it steady for medication
med1 = med1.replace([True, False],[1,0])
#replace true with 1 and False with 0
med2 = data["glimepiride"] == "Steady"
#is it steady for medication
med2 = med2.replace([True, False],[1,0])
#replace true with 1 and False with 0
med3 = data["glyburide"] == "Steady"
#is it steady for medication
med3 = med3.replace([True, False],[1,0])
#replace true with 1 and False with 0
steady = med1.add(med2.add(med3))
#add all the series
morethan2 = steady[steady >=2]
#get entries that are greater or equal to 2
ans = len(morethan2)
#get length of the new series
print(ans)
#print the count
"""
8.
ans = 
284
"""
## 9.  What percentage of reasons for admission ('admission_source_id')
##     correspond to some form of transfer from another care source?

transferlist = [4,5,6,10,18,22,25,26]
#id from another
another = data["admission_source_id"].isin(transferlist).sum()
#does the id fall into the category?
total = len(data["admission_source_id"])
#get the total length of the data
percentage = another/total * 100
#get the percentage
print(percentage)
#print the percentage
"""
9.
ans = 
6.218186820745633
"""
## 10. The column 'discharge_disposition_id' gives codes for discharges.
##     Determine which codes (and the corresponding outcomes from the ID
##     file) resulted in no readmissions ('NO' under 'readmitted').  Then
##     find the top-5 outcomes that resulted in readmissions, in terms of
##     the percentage of times readmission was required.
data10 = data[:]
#make a copy
data10["No"] = 1
#add a new column
all = data10["No"].groupby(data10["discharge_disposition_id"]).sum()
#get the count of every id
data10.loc[data10["readmitted"] == "NO", "No"] = 0
#get all the entries with no readmit
zero = data10[data10["No"] == 0]
#subset all the nos
yes = zero["No"].groupby(zero["discharge_disposition_id"]).count()
#count the nos
ans = 100-yes.div(all)*100
#get the proportion of yes
ans = ans.sort_values(ascending=False)[0:5]
#geth the top 5
print(ans) #print
"""
10. 
ans = 
discharge_disposition_id
15    73.015873
10    66.666667
12    66.666667
28    61.151079
16    54.545455
"""
