##
## File: week04b.py (STAT 3250)
## Topic: GroupBy
## 

import pandas as pd # load pandas as pd

## Creating a DataFrame for demonstration

# We need a new practice DataFrame
df = pd.DataFrame({'C1':['a','a','b','b','c','c','a','c'],
                   'C2':['x','y','x','x','x','y','x','y'],
                   'C3':[1,3,-2,-4,5,7,0,2],
                   'C4':[8,0,5,-3,4,1,3,1],
                   'C5':[3,-1,0,-2,4,3,8,0]})
df

# The GroupBy function allows us to group rows
# of a DataFrame based on the values in one of
# the columns, and then perform operations
# based on those groupings.  Examples follow.

# Here we group the data in column 'C3' based on the
# entries in column 'C1'
group1 = df['C3'].groupby(df['C1']) 
group1 # No computations yet, just a GroupBy object

group1.mean() # Mean for each of group a, b, c
group1.std(ddof=1) # SD for each of group a, b, c
group1.count() # The number of elements in each group
group1.max() # The maximum value from each group
group1.min() # The minimum value from each group
group1.sum() # The sum of the values in each group

# The above computations return a Series ( one-column data
# frame) so you can apply the usual Series operations on it.
group1.mean().iloc[0:2] # The first two rows
group1.sum().loc['c'] # The entry indexed by 'c'
group1.max().loc['a':'b'] # Entry 'a' to 'b'
group1.median().sort_values()  # Sort on the values

# Group can be extracted by key using 'get_group'
group1.get_group('a')

# We can have more than one data column
group2 = df[['C3','C4']].groupby(df['C2'])
group2.mean()

# The whole data frame can be grouped
group3 = df.groupby(df['C2'])
group3.mean() # Strings don't have means, so 'C1' ignored
group3.count() # Strings do have counts, so 'C1' included

# GroupBy can be used to group on more than one key.
# Here we group on the keys in C1 and C2.
group4 = df['C5'].groupby([df['C1'],df['C2']])
df # Reminder of original DataFrame
group4.mean() # Mean for each group
group4.mean()['c','x'] # Mean for group ('c','x')
group4.mean().iloc[4] # The 5th entry in Series

