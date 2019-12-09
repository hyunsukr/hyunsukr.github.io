
##
## File: exam1.py (STAT 3250)
## Topic: Exam 1
## Name: Max Ryoo
## 

import numpy as np # load numpy as np
import pandas as pd
bank = pd.read_csv('bankdata.csv')
list(bank)


array1 = np.array([[13,0,2,-3,2,-4,0,7,-5],
                   [0,5,-2,-1,-4,5,4,9,12],
                   [5,11,-1,-8,0,-3,5,6,7],
                   [-9,2,4,10,0,3,2,-4,-5]])

array1

#Q1
array1[:,(1,4)]

array1[(0,2),]#Get first two rows
array1[(0,2),][:,(1,5)] #Get the columns


np.mean(array1[array1 < -2])

arrayd = np.where(array1 >3, 1, array1 )
np.var(arrayd)


import numpy as np # load numpy as np
import pandas as pd
bank = pd.read_csv('bankdata.csv')
list(bank)

np.sum(bank["contact"] == "telephone")/len(bank) *100
len(bank)

subset = bank["duration"].groupby(bank["day_of_week"])
subset.mean()

sub = bank[bank["job"]=="services"]
sub2 = sub[sub["marital"]=="divorced"]
len(sub2)/len(sub) * 100

contact = bank[bank["pdays"] != 999]
contact["pdays"].median()
np.median(contact["pdays"])


import numpy as np # load numpy as np
import pandas as pd
bank = pd.read_csv('bankdata.csv')
np.unique(bank["job"])

bank["housing"] = np.where(bank["housing"] == "yes", True, False)
subset = bank[bank["housing"]==True]["housing"].groupby(bank["job"])
thing = subset.sum()
thing

bank["housing"] = True
subset2 = bank["housing"].groupby(bank["job"])
thing2 = subset2.sum()
thing2

percentage= thing.div(thing2) * 100
percentage.sort_values(ascending=False)


bank = pd.read_csv('bankdata.csv')
np.unique(bank["job"])
list(bank)
count = np.sum(bank["education"] == "university.degree")
total = len(bank)
phat = count/total
phat
lcl = phat - 1.96*(phat*(1-phat)/len(bank))**0.5 #get the lowe level
ucl = phat + 1.96*(phat*(1-phat)/len(bank))**0.5 #get the higher level
print("[" + str(lcl) + " , " + str(ucl) + "]")  #print


#last question
np.random.exponential(scale=10, size=10)
total = 0
s = np.zeros(100000)
for i in range(100000):
    sampvar = np.var(np.random.exponential(scale=10, size=10))
    s[i] = sampvar
lcl = np.mean(s) - 1.96*np.std(s, ddof=1)/(100000**0.5)
ucl = np.mean(s) + 1.96*np.std(s, ddof=1)/(100000**0.5)
print("[" + str(lcl) + " , " + str(ucl) + "]")  #print




