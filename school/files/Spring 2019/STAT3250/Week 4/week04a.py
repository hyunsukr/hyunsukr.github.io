##
## File: week04a.py (STAT 3250)
## Topic: Pandas
## 

import numpy as np # load "numpy"
import pandas as pd # load pandas as pd

## Creating a DataFrame for demonstration

data = {'Course':['STAT 3A','STAT 3A','STAT 3A','STAT 3B','STAT 3B','STAT 4A','STAT 4A'],
        'Time':['MW200','TR930','TR330','MW1000','MWF900','TR330','MWF100'],
        'Sect':[1,2,4,1,2,1,3],
        'Enrolled':[41,46,39,78,84,51,33],
        'Capacity':[40,50,40,80,80,60,40]}  # this is a 'dict' (dictionary)
df = pd.DataFrame(data, columns=['Course','Sect','Time','Enrolled','Capacity'])
df

# The index is set by default to 0, 1, 2, ...
# We can change it to ['A','B','C','D','E','F','G'] for demonstration
df.index = ['A','B','C','A','E','B','A']
df

#### Extracting subsets of a DataFrame

## Columns
df['Enrolled']  # The column 'Enrolled'
df[['Course','Time']] # The columns Course, Time
df.loc[:,'Enrolled'] # The column 'Enrolled', but with .loc which allows easier
                     # access and supports slicing

df.loc[:,'Sect':'Enrolled'] # The slice Sect-Enrolled, all rows
df['Sect':'Enrolled'] # This doesn't work.


## Rows
df.loc['B'] # Rows indexed by B
df.loc['C'] # Row indexed by C, but mildly annoying format
df.loc[['C'],:]  # Row C as dataframe
df.loc[['B','A'],:] # Rows indexed by B and A, all columns

df.loc['C':'A', :] # This doesn't work because index is not sorted and 'A' is
                   # not a unique index label; see below

# df.loc refers to the "explicit" index of df.  The "implicit" index is still
# 0, 1, 2, ....  This can be referred to using 'iloc'.  (We mostly won't use
# iloc, but it is occassionally handy)
df
df.iloc[2:4,:] # the 3rd and 4th rows of df

## Columns and Rows
df.loc[['E','B'],'Time'] # Rows E, B, and column Time (type = Series)
df.loc[['B','A','E'],['Enrolled','Sect']] # Rows B,A,E; Columns Enrolled, Sect
df.loc[['C','B'],'Time':'Capacity'] # Slicing works
df.loc['C':'E','Sect':'Enrolled'] # Slicing works here too, but careful with index


## Examples of masking
df[df['Enrolled'] < 50]  # Slightly surprising that this produces rows
df.loc[df['Enrolled'] < 50]   # These give the same thing
df.loc[df['Enrolled'] < 50,:] # This might be the most clear

df.loc[df['Sect'] == 2, ['Time','Enrolled']] # Time, Enrolled for Sect = 2

# The Time for STAT 3A and Capacity < 50
df.loc[(df['Course']=='STAT 3A') & (df['Capacity']<50), 'Time']

np.mean(df) # Computes mean of all columns where it makes sense
np.mean(df)['Enrolled']  # Just the 'Enrolled' column

# Sorting
sorteddf1 = df.sort_values(by = 'Enrolled') # Sort by enrollment
sorteddf1

sorteddf2 = df.sort_values(by = 'Enrolled', ascending=False) # Reverse direction
sorteddf2

sorteddf3 = df.sort_values(by = ['Sect','Enrolled']) # Sort by Sect, then Enroll
sorteddf3

#### Reading in a .csv file

grades = pd.read_csv('/Users/maxryoo/Documents/Spring 2019/STAT3250/Week 4/samplegrades.csv')
grades  # Note some values are NaN (missing)

