#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 17 15:34:52 2019

@author: maxryoo
"""

##
## File: week1b.py (STAT 3250)
## Topic: Intro to Python -- Part 1
##

#%%  This is the start of a cell.  It's
##   can be handy to split your code 
##   into cells.  It also helps the 
##   keyboard shortcuts work correctly.

#%%  Each #%% ends the preceding cell and
##   starts the next.

####   Arithmetic with Python

2+5  # The sum of 2 and 5

#%%  

-3*7  # The product of -3 and 7

#%% 

15/7  # 15 divided by 7; 

#%%

2**5  # 2 to the power 5; ^ is not exponentiation!!

#%%  Python only displays the last calculated value
##   in iPython.

2**5
7-4*3

#%%  Use "print" to display multple values (and other
##   stuff too, as we'll see later.)

print(2**5)
print(7-4)

#%%

####  Defining variables

x = 13
print(x)  # Good, but not clear this is x
print('x = %d.' % x)  # Displays x with label as a decimal

7*x  # Arithmetic can be performed on variables

y = 93
x**y  # Integers can be big!

#%%
####  New Variables From Old

x = 10   # Set x equal to 10
y = x    # Set y equal to x
print(y) # Display y; we see that y is value of x

x = 29   # Change x to 29
print(x) # The new value of x
print(y) # y does not change

#%%

####  Lists

list01 = [2,5,1,7,4,6,3]
print(list01)

#%%  List elements

list01[0]  # The 1st entry -- counting starts at 0

list01[3]  # The 4th entry

list01[4] = -8  # Redefine 5th entry to be -8
print(list01)

#%%  Adding and removing list elements

list01.append(12)  # Append 12 to end of mylist
print(list01)

list01.insert(2, 13)  # Insert 13 in the 3rd position
print(list01)

list01.pop(5)  # Remove the 6th entry from mylist
print(list01)

list01.remove(7)  # Removes first occurence of 7
print(list01)

#%% Slicing -- Extracting and replacing sublists

list01 = [2,5,1,7,4,6,3]  # Reset definition for list01
print(list01)

## Note that none of these below changes list01
list01[2:5] # The 3rd, 4th, and 5th entries

list01[:4]  # 1st to 4th entries  

list01[2:]  # 3rd to last entries

list01[-5:]  # Last 5 entries

list01[:-2] # Entries from 1st to 2nd from end

list01[::2] # Every other entry, starting with 1st

list01[::3] # Every third entry, starting with 1st

list01[1::3] # Every third entry, starting with 2nd

list01[::-1] # Every entry, but in reverse order from end

list01[::-2] # Every other entry, in reverse order from end

# If we want to actually change list01:
list01 = list01[::-1] # Change list01 to reverse order
print(list01)

#%%   Misc. other list operations

print(list01)  # Current definition for list01
list02 = [5,7,-3,2]  # Define a new list

biglist = list01+list02 # Concatenate lists
print(biglist)

biglist.sort()  # Sort list from smallest to largest
print(biglist)  # Note that this command changed biglist

biglist.reverse()  # Reverse the order of the sorted list
print(biglist)     # This command also changed biglist

biglist.count(5)  # Count the number of times 5 appears
print(biglist)    # biglist is not changed

biglist.index(2)  # index of first 2 in list 
print(biglist)    # biglist is not changed

#%%  A list caution

x = [1,2,3] # Set x to a list
y = x       # Set y equal to x
print(x)
print(y)

x[1] = 37
print(x)
print(y)  # y changes too!

y[1] = -23
print(y)
print(x)  # x is changed

# To prevent above behavior:
x = [1,2,3] # Reset x to a [1,2,3]
y = list(x)  # Make y a copy of x
print(y)
x[1] = 19   # Change 2nd entry of x
print(x)   # x is changed
print(y)   # This time y is not changed

#%% Practice Problems

## For the problems below, use the following
## lists as needed:
mylist01 = [2,5,4,9,10,-3,5,5,3,-8,0,2,3,8,8,-2,-4,0,6]
mylist02 = [-7,-3,8,-5,-5,-2,4,6,7,5,9,10,2,13,-12,-4,1]

## 1. Find the product of the 7th entry in mylist01,
##     the 13th entry in mylist01, and the 4th entry
##     in mylist02.

mylist01[6] * mylist01[12] * mylist02[3]

## 2. Extract the sublist of mylist02 that goes from
##     the 5th to the 9th elements (inclusive).

mylist02[4:9]

## 3. Concatenate mylist01 to mylist02 (in that order), sort 
##     the new combined list, then extract the sublist that 
##     goes from the 8th to the 19th elements (inclusive).
newlist = mylist01 + mylist02
newlist.sort()
newlist[7:19]

## 4. Extract the sublist of mylist02 consisting of every
##     3rd entry, starting at the end and going in 
##     reverse.

mylist02[::-3]

## 5. From mylist01 concatenated to mylist02 extract the sublist
##     of every 5th entry, starting with the 3rd entry.

newlist =  mylist01 + mylist02
newlist[2::5]

#%% Answers to Practice Problems

## 1.  -75
## 2.  [-5, -2, 4, 6, 7]
## 3.  [-3, -3, -2, -2, 0, 0, 1, 2, 2, 2, 3, 3]
## 4.  [1, 13, 9, 6, -5, -3]
## 5.  [4, 5, 3, 0, -5, 7, 13]
