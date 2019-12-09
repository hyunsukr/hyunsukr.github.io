##
## File: assignment06.py (STAT 3250)
## Topic: Assignment 6
## Max Ryoo (hr2ee)

##  This assignment requires the data file 'movies.txt'.  This file
##  contains records for nearly 4000 movies, including a movie ID number, 
##  the title (with year of release, which is not part of the title), and a 
##  list of movie genre classifications (such as Romance, Comedy, etc). 

##  Note: All questions on this assignment should be done without the explicit
##        use of loops in order to be eliglble for full credit.  
import pandas as pd
import numpy as np
reviews = pd.read_csv('movies.txt', sep='::',header=None, names=['ID','Name','Genre'])
## 1.  Are there any repeated movies in the data set?  A movie is repeated 
##     if the title is exactly repeated and the year is the same.  List any 
##     movies that are repeated, along with the number of times repeated.
repeated = reviews.groupby(reviews["Name"]) #group by name and year
table = repeated.size() #get the counts
ans = table[table > 1] #see if there are duplicates
print(ans) #print answer
"""
1. 
ans = 
N/A empty
"""
## 2.  Determine the number of movies included in genre "Action", the number
##     in genre "Comedy", and the number in both "Children's" and "Animation".
actionsub = reviews[reviews["Genre"].str.contains("Action")]
#subset genres with action in it
action = len(actionsub)
#get the length

comedysub = reviews[reviews["Genre"].str.contains("Comedy")]
#subset genres wtih comedy in it
comedy = len(comedysub)
#get the length


child = reviews["Genre"].str.contains("Children's")
#subset Childrens'
animation = reviews["Genre"].str.contains("Animation")
#subset animation

subsettotal = reviews[(child & animation)]
#combine bool values
childanime = len(subsettotal)
#get the length
print("Action: ", action) #print action
print("Comedy: ", comedy) #print comedy
print("Children's and Animation: ", childanime) #print childanmie

"""
2.
ans=
Action:  503
Comedy:  1200
Children's and Animation:  84
"""
## 3.  Among the movies in the genre "Horror", what percentage have the word
##     "massacre" in the title?  What percentage have 'Texas'? (Upper or lower
##     cases are allowed here.) 

horror = reviews[reviews["Genre"].str.contains("Horror")]
#subset horror genres
horror["Name"] = horror["Name"].str.lower()
#lowercase all titles
submas = horror[horror["Name"].str.contains("massacre")]
#subset massacre
massacre = len(submas)/len(horror) * 100
#get precentage by len of subset over lenght of horror * 1000
subtex = horror[horror["Name"].str.contains("texas")]
#subset texas
texas = len(subtex)/len(horror) * 100
#get precentage by len of subset over lenght of horror * 1000
print("Massacre: ", massacre) #print massacre
print("Texas: ", texas) #print texas

"""
3.
ans= 
Massacre:  2.623906705539359
Texas:  1.1661807580174928
"""

## 4.  How many titles are exactly one word?

subsplit = reviews["Name"].str.split(" ")
#split the name by space
count = subsplit[subsplit.str.len() == 2].count()
#if the length is 2 then this means exactly word since year and title
print(count)
#print count

"""
4.
ans = 
690
"""

## 5.  Among the movies with exactly one genre, determine the top-3 genres in
##     terms of number of movies with that genre.
onegenre = reviews[reviews["Genre"].str.contains("|", regex=False) == False]
#Get the false entries of genres having |
genres = onegenre["ID"].groupby(onegenre["Genre"]).count()
#get the count by grouping by genres
ans = genres.sort_values(ascending=False)[0:3]
#subset top 5
print(ans)
#pinrt ans

"""
5. 
ans = 
Genre
Drama     843
Comedy    521
Horror    178
"""

## 6.  Determine the number of movies with 0 genres, with 1 genre, with 2 genres,
##     and so on.  List your results in a table, with the first column the number
##     of genres and the second column the number of movies with that many genres.

reviews["numgen"] = reviews["Genre"].str.split("|").str.len()
#split the genres by the "|" string 
genres = reviews["ID"].groupby(reviews["numgen"]).count()
#count how many genres there are and group by the count
print(genres) 
#print the number of movies in each genres

"""
6.
ans = 
numgen
1    2025
2    1322
3     421
4     100
5      14
6       1
"""

## 7.  How many remakes are in the data?  A movie is a remake if the title is
##     exactly the same but the year is different. (Count one per remake.  For
##     instance, 'Hamlet' appears 5 times in the data set -- count this as one
##     remake.)
#reviews["Titles"] = reviews["Name"].str.split(r'(\(\d+\))').str[0]
reviews["Titles"] = reviews["Name"].str[0:-6]
#get tht titles
groupby = reviews["ID"].groupby(reviews["Titles"]).count()
#get the count to entries grouped by tites
remake = groupby[groupby >= 2]
#which are remakes?
ans = len(remake)
#get the length of the remake dataframe
print(ans) #print as
"""
7.
ans = 
38
"""
## 8.  List the top-5 most common genres in terms of percentage of movies in
##     the data set.  Give the genre and percentage, from highest to lowest.
listnp = reviews["Genre"] #subset genre
listpipe = np.array(' '.join(listnp).split('|'))
#split by | and make into array
listsplit = np.array(' '.join(listpipe).split(' '))
#split by space and make into one d array
uniq, counts = np.unique(listsplit, return_counts=True)
#get the unique elements and their countes in the one dimensional array
ans = pd.DataFrame({'Genre': uniq, 'Percentage': counts*100/len(reviews)}, columns=['Genre', 'Percentage'])
#make into dataframe
top5 = ans.sort_values(by=['Percentage'],ascending=False)[0:5]
#sort by percentage
print(top5)
#print final dataframe

"""
8.
ans = 
       Genre  Percentage
7      Drama   41.282514
4     Comedy   30.903940
0     Action   12.953902
15  Thriller   12.670616
13   Romance   12.129797
"""
## 9.  Besides 'and', 'the', 'of', and 'a', what are the 5 most common words  
##     in the titles of movies classified as 'Romance'? (Upper and lower cases
##     should be considered the same.)  Give the number of titles that include
##     each of the words.

romance = reviews[reviews["Genre"].str.contains("Romance")]
#subset romance genre
listnp = romance["Name"].str.lower().str[0:-6]
#Get the title
listrpipe = np.array(''.join(listnp).split())#split by space and make it into a one dimensional array
uniq, counts = np.unique(listrpipe, return_counts=True)
counts
#get the unique words and their respective coutns
ans = pd.DataFrame({'word': uniq, 'Counts': counts}, columns=['word', 'Counts'])
#make into a dataframe
top5 = ans.sort_values(by=['Counts'],ascending=False)
#sort the dataframe
top5 = top5[top5["word"] != ""] #remove given element
top5 = top5[top5["word"] != "and"] #remove given element
top5 = top5[top5["word"] != "the"] #remove given element
top5 = top5[top5["word"] != "of"] #remove given element
top5 = top5[top5["word"] != "a"] #remove given element
ans = top5.sort_values(by=['Counts'],ascending=False)[0:5] #Get top 5
print(ans)
#print table
"""
9.
ans = 
     word  Counts
429    in      27
509  love      21
836    to      14
913   you      10
619    on      10
"""
## 10. It is thought that musicals have become less popular over time.  We 
##     judge that assertion here as follows: Compute the mean release years 
##     for all movies that have genre "Musical", and then do the same for all
##     the other movies.  Then repeat using the median in place of mean.

musical = reviews[reviews["Genre"].str.contains("Musical")]
#subset musicals
years = musical["Name"].str[-5:-1]
#get the years
mean = np.mean(years.astype(int))
#change to int type and get mean
median = np.median(years.astype(int))
#chane to int type and get median

nomusical = reviews[reviews["Genre"].str.contains("Musical") == False]
#subset nonmusical
noyears = nomusical["Name"].str[-5:-1]
#get the years
nomean = np.mean(noyears.astype(int))
#get the mean after int caset
nomedian = np.median(noyears.astype(int))
#median after int type cast
print("Mean Musical: ", mean)
print("Mean NonMusical: ", nomean)
print("Median Musical: ", median)
print("Median NonMusical: ", nomedian)

"""
10. 
ans = 
Mean Musical:  1968.7456140350878
Mean NonMusical:  1986.5908729105863
Median Musical:  1967.0
Median NonMusical:  1994.0
"""