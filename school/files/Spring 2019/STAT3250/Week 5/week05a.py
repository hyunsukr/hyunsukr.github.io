##
## File: week5a.py (STAT 3250)
## Topic: String operations 
##

#### Introduction to String operations

import pandas as pd # load pandas as pd

teststr = "There    are two ways   of constructing a software design." 
teststr

# Extract substrings in specific positions
teststr[10:30] # Characters from positions indexed by 10-29
teststr[10:30:2] # Every other character
teststr[:20] # The first 20 characters
teststr[50:] # From the position indexed by 50 to the end
teststr[:-20] # All but the last 20 characters

teststr[5:10]+teststr[15:20] # Concatenate strings

teststr.upper() # Shout!
teststr.lower() # Whisper? (Good for comparing when case in doubt)

teststr.index("o") # Index for first "o".
teststr.count("o") # Number of "o"s in str.
teststr.find("o") # Same as index
teststr.replace("are", "were") # Replace a substring

teststr.startswith("Hello") # Test if 'teststr' starts with given string
teststr.startswith("The")
teststr.endswith("ign") # Test if 'teststr' ends with given string
teststr.endswith("ign.")

teststr.split(" ") # split 'teststr' on " " (space)
teststr.split("s") # We can split on things other than spaces
teststr.split() # The default is spaces; extra spaces discarded
"ABCD".join(teststr.split("s")) # Splice strings together, with "ABCD"
"".join(teststr.split("s")) # Splice strings together, with no space
"s".join(teststr.split("s")) # Splice strings together, with s back in place


#### Vectorized string operations

# Many of the string operations seen previously can be automatically
# performed across a Series of strings without the use of a for loop.
# (A column from a DataFrame is also a Series.)

# A practice DataFrame
df = pd.DataFrame({'C1':['a','a','b','b'],
                   'C2':['Wed May 21 15:47:57 2014 27 ExpFcn-2	lane Library/FortLewis/Algebra/10-1-Exponential-Functions/MCH1-10-1-6.pg',
                         'Wed May 21 15:52:15 2014 21 ExpFcn-2	lane Library/LoyolaChicago/Precalc/Chap4Sec2/Q18.pg',
                         'Wed May 21 16:02:01 2014 32 ExpFcn-2	lane Library/FortLewis/Algebra/10-3-TheExponent/MCH-10-3-6.pg',
                         'Wed May 21 16:18:55 2014 44 ExpFcn-2	lane Library/Union/setFunctionExponential/srw4_1_11.pg']})
df
# Below are some examples.  Let's start with the 'transactions.txt'
# for data.  
recs = df['C2']
recs

# We can find the length of each string in 'recs'
recs.str.len()

# We can the start of the word 'Library' in each string
recs.str.find('Library')

# We can count the number of appearances of 'Library' in each string
recs.str.count('Library')

# Or we can just check for 'FortLewis' in each string
recs.str.contains('FortLewis')

# We can mask on the result of 'str.contains' to extract the strings 
# that contain the word 'FortLewis'
newrecs = recs[recs.str.contains('FortLewis')]
newrecs

# We can pull out the substrings in specific positions from each string
newrecs.str[0:24]

# It's also possible to split each string
newrecs.str.split()  # Produces a Series of lists

# Then we can pull out just the time
newrecs.str.split().str[3]

# We can split again to get just the minutres
newrecs.str.split().str[3].str.split(':').str[1]
