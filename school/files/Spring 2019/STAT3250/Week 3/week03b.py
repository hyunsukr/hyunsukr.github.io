##
## File: week03b.py (STAT 3250)
## Topic: NumPy Arrays and Vectorized Computation
## 

import numpy as np # load "numpy"

## Creating arrays

arr1 = np.array([1,2,3,4,5,6,7])  # Define a 1-D array
arr1
arr2 = np.array([3,1,0,2,4,5,1])

## NumPy arithmetic operations on arrays

3*arr1  # Multiply each entry by 3
arr1 + arr2  # Add array values term by term
arr1*arr2  # Multiply array values term by term
arr1**3  # Raise array values to 3rd power

## Subsets and new values

arr1[3]  # The 4th value
arr1[3:5]  # The 4th and 5th values, returned as an array

arr1[2] = 20  # Replace 3rd value with 20
arr1
arr1[2:5] = 12  # Replace 3rd to 5th value with 12
arr1

arr1_slice = arr1[1:4]  # A subset of arr1
arr1_slice

arr1_slice[2] = 30  # Changes the 3rd entry in arr1_slice
arr1_slice
arr1  # The change to arr1_slice also changes arr1!

arr1_slice = np.copy(arr1[1:4])  # Make a copy of arr1[1:4]
arr1_slice
arr1_slice[1] = 100
arr1_slice
arr1  # Now changes to arr1_slice do not transmit back to arr1

## 2-dimensional arrays

arr3 = np.array([[1,2,3,4],[5,6,7,8],[9,10,11,12]])  # Define a 2-D array
arr3  # Kind of looks like a matrix

arr3[1]  # 2nd row
arr3[1][3]  # 2nd row, 4th entry
arr3[1,3]  # Same
arr3[:2]  # 1st and 2nd rows
arr3[2:]  # 3rd row
arr3[1:,:3]  # Rows 2-3 and columns 1-3
arr3[:,2]  # Column 3

## Vectorized computations
arr4 = np.array([[3,2,-3,0,7],[0,5,2,-1,1],[2,-2,3,0,1],[6,4,7,2,2]])
arr4

# We can test values
arr4 == 2  # Test which entries are equal to 2
arr4 < 0 # Test which entries are negative

# Count and add values
np.sum((arr4 < 0))  # Count the number of values that are negative
arr4[arr4 < 0]  # Extract the values that are negative
np.mean(arr4[arr4 < 0])  # Mean of the values that are negative
np.sum((arr4 < 2) & (arr4 > -2)) # Count of entries x with -2<x<2

#### More NumPy Features

## Creating arrays

np.empty((5,3)) # 5-by-3 array, initialized but not always zeros
np.zeros((5,3)) # 5-by-3 array of 0's
np.ones((5,3)) # 5-by-3 array of 1's

arr5 = np.arange(40)  # Define a 1-D array [0,...,39]
arr5
arr5 = arr5.reshape((10,4)) # Convert values into a 10-by-4 array
arr5

## Fancy indexing

# NumPy supports extended indexing of values from arrays.
arr5[2]  # Row indexed by 2
arr5[[1,3,5]]  # Rows indexed by 1, 3, and 5
arr5[[3,5,1]]  # Same rows, different order
arr5[:,[0,2]]  # All rows, columns indexed by 0 and 2
arr5[[2,4,5],[0,1,2]] # Entries indexed by (2,0),(4,1),(5,2)

# If we want the "grid" of rows indexed 2,4,5 and columns indexed 0,1,2:
arr5[[2,4,5]][:,[0,1,2]]  # A bit awkward, but it works.

# transpose interchanges the rows and columns
np.transpose(arr5[[2,4,5]][:,[0,1,2]])  
np.transpose(arr5)

## np.where
# The command below will replace any element divisible
# by 3 with -1, and replace all other elements with 1.
np.where(arr5 % 3 == 0, -1, 1)

# This time we just replace elements divisible by 3 with
# -1, keep others the same.
np.where(arr5 % 3 == 0, -1, arr5)

# Here we change the sign of elements divible by 3, keeping
# the others the same.
np.where(arr5 % 3 == 0, -arr5, arr5)

## Math & Stat Functions
np.mean(arr5)  # The mean of all entries
np.sum(arr5)  # The sum of all entries

np.mean(arr5, axis=0)  # The mean of each column
np.mean(arr5, axis=1)  # The mean of each row
np.std(arr5, axis=0, ddof=1)  # The standard deviation of each column
np.std(arr5, axis=1, ddof=1)  # The standard deviation of each row

## Set operations
arr6 = np.array([2,4,6,8,2,4,6,8,10])
arr7 = np.array([2,3,4,2,4,8])

np.unique(arr6)  # Eliminate all duplicates
np.intersect1d(arr6,arr7)  # Intersection of arr6 and arr7
np.union1d(arr6,arr7)  # Union of arr6 and arr7
np.setdiff1d(arr6,arr7)  # Elements in arr6 that are not in arr7
np.setxor1d(arr6,arr7)  # Elements in eactly one of arr6 and arr7

np.in1d(arr6,arr7)  # Test which elements of arr6 are in arr7
# If we want the actual elements:
arr6[np.in1d(arr6,arr7)]
# If we want the above without duplicates:
np.unique(arr6[np.in1d(arr6,arr7)])
