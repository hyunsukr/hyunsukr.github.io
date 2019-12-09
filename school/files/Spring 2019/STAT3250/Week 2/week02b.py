##
## File: week02b.py (STAT 3250)
## Topic: Numpy and simulation
##

####   Numpy & Random simulation

# This loads the "numpy" library, which 
# has a variety of functions to generate
# random values (plus other stuff) 
import numpy as np # "as np" lets us use "np"
                   # in place of "numpy"
              
# For instance, here we compute several things
# for a list of numbers.
list01 = [2,3,5,7,4,11,2]
np.mean(list01)  #  mean
np.median(list01)  #  median
np.var(list01, ddof=1)  #  sample variance
np.std(list01, ddof=1)  #  sample standard deviation

# We can generate random values from a uniform
# distribution.  
x = np.random.uniform(low=0,high=100,size=1000)
x

# Remark: The above generates an "array" rather
# than a list.   

# The code below will count the number of
# entries in x that are less than 20.
# (We'll see a more efficient way to do this
# later.)
ct = 0
for xval in x:
    if xval < 20:
        ct += 1  # Adds 1 to ct; same as ct = ct + 1
print(ct)  # We expect about 200 (roughly)

# If we generate a new set of 1000 random values,
# on [0,100], we expect the number of values that are
# less than 20 to vary.  Let's try it again.
x = np.random.uniform(low=0,high=100,size=1000)
ct = 0
for xval in x:
    if xval < 20:
        ct += 1  # Adds 1 to ct
print(ct)  # We expect about 200 (roughly)

# We can repeat this experiment numerous times, and 
# record the value of "ct" each time.  Here's 100
# repeats of the experiment, using nested for loops.
ctarray = np.zeros(100)  # An array of 100 zeros
for i in range(100):
    x = np.random.uniform(low=0,high=100,size=1000)
    ct = 0
    for xval in x:
        if xval < 20:
            ct += 1  # Adds 1 to ct
    print(ct)  # Print count for each iteration
    ctarray[i] = ct # Record count
    
print(ctarray)  # The list of counts; significant variation.

np.mean(ctarray)  # We expect this to be near 200.

#### Random selection from a set

# "np.random.choice" allows us to make a random selection
# from a specified list of values.
l = [2,7,3,5]
s = np.random.choice(l, size=20) # random sample from l; size=10
print(s)  # Note: Values can be repeated

# An optional argument can be used to set the probability that
# each entry is selected 
s = np.random.choice(l, size=20, p=[0.7,0.1,0.1,0.1]) # p=probs
print(s)

# This can also be applied to range(n) = [0, 1, ..., n-1]
s = np.random.choice(range(10), size=20) 
print(s)  


#### while loops

# A "while" loop repeats until a condition is not
# met.  An example:
ct = 0
while ct <= 5:  # Loop will run until ct > 5
   print("The count is %d" % ct)  # print count
   ct += 1  # increment count
        
# For range(10) above, suppose that we randomly
# select an entry until we find one equal to 7.
# We can use a while loop to perform the random selections,
# and to keep track of the number of selections required.
ct = 1  # Initialize the counter
s = np.random.choice(range(10), size=1)  # initial random choice
while s != 7: # continue while s is not equal to 7
    ct += 1  # Increment the counter by 1
    s = np.random.choice(range(10), size=1)  # a new random choice
print(ct)  # Print the number of choices until s = 7    
s   # s is actually an array
print(s[0]) # Obtain s from the array

# We can do this over and over by nesting the while loop
# in a for loop.  This allows for an estimate of the average
# number of selections required to obtain the first value
# equal to 7.  Let's try 1000 simulations.
ctarray = np.zeros(10000)  # An array to hold the values of ct
for i in range(10000):
    ct = 1  # Initialize the counter
    s = np.random.choice(range(10), size=1)  # initial random choice
    while s != 7:
        ct += 1  # Increment the counter by 1
        s = np.random.choice(range(10), size=1)  # a new random choice
    ctarray[i] = ct  # Record the number of selections required

print(ctarray[0:50])
np.mean(ctarray)  # Compute the mean number of selections required

#%%

#



