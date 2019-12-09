#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 24 15:55:14 2019

@author: maxryoo
"""

##
## File: week05b.py (STAT 3250)
## Topic: Modifying Data Frames; demo of 'isin' and 'value_counts'
## 

import pandas as pd # load pandas as pd


#### Adding and removing dataframe columns and rows

# A sample data frame
df = pd.DataFrame({'C1':['a','a','b','b','c','c','a','c'],
                   'C2':['a','y','b','x','x','b','x','a'],
                   'C3':[1,3,-2,-4,5,7,0,2],
                   'C4':[8,0,5,-3,4,1,3,1],
                   'C5':[3,-1,0,-2,4,3,8,0]})
df

# We can create an empty DataFrame column 
df['C6'] = ""
df

# Or we can add values to the column
df['C6'] = 13
df

# We can perform arithmetic on columns to create new columns
df['C7'] = df['C4']+df['C5']  # Vectorized -- faster than loops!
df

# Or modify old columns
df['C6'] = df['C5'] - 2*df['C4']
df

# We can drop columns with 'drop':
df = df.drop('C5',axis=1) # 'axis=1' specifies columns; 'axis=0' is rows
df

# Drop one more column
df = df.drop('C3',axis=1)
df

# Just for fun, let's remove a row too
df = df.drop(5, axis=0)  # Removing a row from the middle is fine
df
len(df)
# We'll discuss adding rows at another time.


####  Changing specific data frame entries

# We can change individual entries with '.loc':
df.loc[3,'C6'] = 100  # Here '3' is in both the explicit and impicit index
df

# We can add lots of entries with a loop.  (Only do this if vectorization
# is not a good alternative.)
for i in range(len(df)):
    df.loc[i,'C7'] = i**2 # If column does not exist it is created.
df  # Perhaps a bit surprising.

df['C8'] = df.index**2  # This is a better option
df

# Use '.loc'!! -- leaving it off does not work as expected!!
df[3,'C7'] = 100  # Don't do this!
df

# Let's remove the unwanted column
df.columns  # Here's the column list
df = df.drop((3,'C7'), axis=1) # 'axis=1' specifies columns; 'axis=0' is rows
df

# And drop the row indexed by 5 to clean up the missing values.
df = df.drop(5, axis=0)
df


#### Chained assignments

df['C4'][1] = 500  # This works, but produces a warning ('chained assignment')
df

df.loc[1,'C4'] = 1000  # This is the preferred approach
df


#### 'isin' and 'value_counts()'

# 'isin' allows one to automatically check if each element of one set is
# also an element of another set.  This can save from having to create
# inefficient/complicated loops.

# Test if each of 'a', 'b', 'c' is in df['C2'].  Note the use of 'pd.Series'
# because the first set cannot be a list, but a Series or DataFrame will work.
pd.Series(['a', 'b', 'c']).isin(df['C2'])

# Columns of data frames are automatically Series
df['C1'].isin(df['C2']) # Checks which entries of df['C1'] are in df['C2']

# Count the number of values in a Series (or data frame column)
df['C1'].value_counts()

