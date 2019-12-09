##
## File: assignment07.py (STAT 3250)
## Topic: Assignment 7 
## Max Ryoo (hr2ee)

##  This assignment requires data from four files: 
##
##      'movies.txt':  A file of over 3900 movies
##      'users.dat':   A file of over 6000 reviewers who provided ratings
##      'ratings.dat': A file of over 1,000,000 movie ratings
##      'zips.txt':    A file of zip codes and location information
##
##  The file 'readme.txt' has more information about the first three files.
##  You will need to consult the readme file to answer some of the questions.

##  Note: You will need to convert the zip code information in 'users.dat' into
##  state (or territory) information for one or more of the questions below.
##  You must use the information in 'zips.txt' for this purpose, you cannot
##  use other conversion methods. 
import pandas as pd
import numpy as np
#read files in 
readme = open('readme.txt').read().split('\n')
users = pd.read_csv('users.dat', sep='::',header=None, names=['UserID','Gender','Age','Occupation','Zip-code'])
movies = pd.read_csv('movies.txt', sep='::',header=None, names=['MovieID','Name','Genre'])
ratings = pd.read_csv('ratings.dat', sep='::',header=None, names=['UserID','MovieID','Rating','Timestamp'])
zips = pd.read_csv("zipcodes.txt")
## 1.  Determine the percentage of users that are female.  Do the same for the
##     percentage of users in the 35-44 age group.  In the 18-24 age group,
##     determine the percentage of male users.
female = users[users["Gender"] == "F"]
#subset females
femalepercent = len(female)/len(users) * 100
#get percent
print(femalepercent)
#print

group1 = users[(users["Age"] >= 35) & (users["Age"] <= 44)]
#get the age group
group1female = group1[group1["Gender"]=="F"]
#subset females
group1percent = len(group1female)/len(group1) * 100
#get percentage
print(group1percent)
#print percentage
 
group2 = users[(users["Age"] >= 18) & (users["Age"] <= 24)]
#get the age group
group2male = group2[group2["Gender"]== "M" ]
#get the males
group2percent = len(group2male)/len(group2) * 100
#get the percetnage
print(group2percent)
#print percentage

"""
1.
overall = 28.294701986754966
35-44 = 28.331936295054483
18-24 = 72.98277425203989
"""

## 2.  Give a year-by-year table of counts for the number of ratings, sorted by
##     year in ascending order.

ratings["year"] = pd.to_datetime(ratings['Timestamp'], unit='s').dt.year
#chage to year and get the year portion
year = ratings["UserID"].groupby(ratings["year"]).count().sort_values(ascending=True)
#group by year for user id and count the entires and sort
print(year)
"""
2.
ans=
2003      3348
2002     24046
2001     68058
2000    904757
"""

## 3.  Determine the average rating for females and the average rating for 
##     males.
ratingusers = pd.merge(users, ratings, on='UserID')
#merge ratings and users on userid
ans = ratingusers["Rating"].groupby(ratingusers["Gender"]).mean()
#get the average rating for each gender
print(ans)
#print answers
"""
3. 
ans = 
Gender
F    3.620366
M    3.568879
"""

## 4.  Find the top-10 movies based on average rating.  (Movies and remakes 
##     should be considered different.)  Give a table with the movie title
##     (including the year) and the average rating, sorted by rating from
##     highest to lowest.  (Include ties as needed.)
ratingmovies = pd.merge(ratings,movies, on ="MovieID", how="outer")
#merge ratings and movies on movie id wit houter how
ans = ratingmovies["Rating"].groupby(ratingmovies["Name"]).mean().sort_values(ascending=False)[0:10]
#group by movie names and get the average ratings get the top 10
print(ans)
"""
4.
ans = 
Name
Gate of Heavenly Peace, The (1995)           5.0
Lured (1947)                                 5.0
Ulysses (Ulisse) (1954)                      5.0
Smashing Time (1967)                         5.0
Follow the Bitch (1998)                      5.0
Song of Freedom (1936)                       5.0
Bittersweet Motel (2000)                     5.0
Baby, The (1973)                             5.0
One Little Indian (1973)                     5.0
Schlafes Bruder (Brother of Sleep) (1995)    5.0
"""
## 5.  Determine the number of movies listed in 'movies.txt' for which there
##     is no rating.  Determine the percentage of these unrated movies for
##     which there is a more recent remake.
ratingmovies = pd.merge(ratings,movies, on ="MovieID", how="outer")
#merge ratings and movies on movieID with outer join
sub = ratingmovies[ratingmovies["Rating"].isnull()]
#subset all the null ratings
numnorate = len(sub)
#numebr of entries with no ratings
print(numnorate)
#print numer

sub["Title"] = sub["Name"].str[0:-6]
#subset only the titles and not the years
listnorates = sub["Title"].tolist()
#make it into list
listremake = []
#make an empty list
for i in listnorates:
    #for every movie with no ratings
    subset = movies[movies["Name"].str[0:-6] == i]
    #get only the titles
    if (len(subset) > 1):
        #if there are remakes
        listremake.append(i)
        #add the movie to the list
percent = len(listremake) / numnorate * 100
#percent
print(percent) 
#print the percent
        

"""
5.
ans = 
Number of movies = 177
Percentage = 0.0
"""
## 6.  Determine the average rating for each occupation classification 
##     (including 'other or not specified'), and give the results in a
##     table sorted from highest to lowest average and including the
##     occupation title.
occupation = pd.Series(readme[70:91])
#get the occupations
occupation = occupation.str.split('"').str[1]
#split and get the occupation names
frame_occupation = occupation.to_frame("Occupation")
#make it into a dataframe.
listnum = ratingusers["Occupation"].tolist()
#make it into a list format
names = frame_occupation.iloc[listnum]["Occupation"].tolist()
#get the corresponding occupation
ratingusers["NamesOcc"] = names
#set a column and name
ans = ratingusers["Rating"].groupby(ratingusers["NamesOcc"]).mean().sort_values(ascending=False)
#get the means of ratings and sort values
print(ans)
#print 
"""
6.
ans = 
NamesOcc
retired                 3.781736
scientist               3.689774
doctor/health care      3.661578
homemaker               3.656589
clerical/admin          3.656516
programmer              3.654001
sales/marketing         3.618481
lawyer                  3.617371
technician/engineer     3.613574
executive/managerial    3.599772
self-employed           3.596575
academic/educator       3.576642
artist                  3.573081
other                   3.537544
customer service        3.537529
college/grad student    3.536793
K-12 student            3.532675
tradesman/craftsman     3.530117
writer                  3.497392
farmer                  3.466741
unemployed              3.414050
"""

## 7.  Determine the average rating for each genre, and give the results in
ratingmovies = pd.merge(movies, ratings, on=['MovieID'], how='inner')
#merge movies and ratings with inner
genrelists = movies['Genre'].str.split('|')
#split the genres by |
genreonce = np.unique(sum(genrelists,[]))
#get the unique 
ratings_dictionary= {}
#set an empty dictionary
for i in genreonce:
    #for every genre in genreonce
    subset = ratingmovies[ratingmovies["Genre"].str.contains(i)]
    #subset the movies that have the current genre
    avg = subset["Rating"].mean()
    #get the rating average of the subset
    ratings_dictionary[i] = avg
    #key is genre value is average
ans = pd.DataFrame(ratings_dictionary.items(), columns=["Genre","Average Rating"])
#make the dictionary into a dataframe
ans = ans.sort_values(by="Average Rating",ascending=False)
#Sort by average rating
print(ans)
#print ans
"""
7.
ans = 
          Genre  Average Rating
9     Film-Noir        4.075188
6   Documentary        3.933123
16          War        3.893327
7         Drama        3.766332
5         Crime        3.708679
2     Animation        3.684868
12      Mystery        3.668102
11      Musical        3.665519
17      Western        3.637770
13      Romance        3.607465
15     Thriller        3.570466
4        Comedy        3.522099
0        Action        3.491185
1     Adventure        3.477257
14       Sci-Fi        3.466521
8       Fantasy        3.447371
3    Children's        3.422035
10       Horror        3.215013
"""

## 8.  For the user age category, assume that the user has age at the midpoint
##     of the given range.  (For instance '35-44' has age (35+44)/2 = 39.5)
##     For 'under 18' assume an age of 16, and for '56+' assume an age of 60.
##     For each possible rating (1-5) determine the average age of the raters.
ratingusers["actualage"] = np.where(ratingusers["Age"] == 1, 16, ratingusers["Age"])
#change 1 to 16
ratingusers["actualage"] = np.where(ratingusers["actualage"] == 18, (18+24)/2, ratingusers["actualage"])
#change 18 to the middle
ratingusers["actualage"] = np.where(ratingusers["actualage"] == 25, (25 + 34)/2, ratingusers["actualage"])
#change 25 to the middle
ratingusers["actualage"] = np.where(ratingusers["actualage"] == 35, (35 + 44)/2, ratingusers["actualage"])
#change 35 to the middle
ratingusers["actualage"] = np.where(ratingusers["actualage"] == 45,  (45 + 49)/2, ratingusers["actualage"])
#change 45 to the middle
ratingusers["actualage"] = np.where(ratingusers["actualage"] == 50, (50 + 55)/2, ratingusers["actualage"])
#change 50 to the middle
ratingusers["actualage"] = np.where(ratingusers["actualage"] == 56, 60, ratingusers["actualage"])
#change 56 to 60
ans = ratingusers["actualage"].groupby(ratingusers["Rating"]).mean()
#group by rating and get the mean age
print(ans)
#print ans
"""
8.
ans = 
Rating
1    31.710783
2    32.769485
3    33.840672
4    34.270909
5    34.368274
"""
## 9.  Find all combinations (if there are any) of occupation and genre for 
##     which there are no ratings.  
movierating = pd.merge(movies, ratings, on='MovieID', how='outer')
#merge movies and ratings on movie and outer join
final = pd.merge(movierating, users, on='UserID', how='outer')
#merge movierating and users on outer
norating = final[final['Rating'].isnull()]
#get the null values
norateoccup = norating[norating[['Genre','Occupation']]["Occupation"].isnull() == False]
#subset the not null ocupations
ans = len(norateoccup)
#there were none
print(ans)
#sad zero is the answer
"""
9.
ans = 
0
"""
## 10. For each age group, determine the occupation that gave the lowest 
##     average rating.  Give a table that includes the age group, occupation,
##     and average rating.  (Sort by age group from youngest to oldest) 
group = ratingusers["Rating"].groupby([ratingusers["Age"],ratingusers["NamesOcc"]]).mean()
#group by name of occupatation and age and get average ratings
ans = group.groupby(level=0, group_keys=False).nsmallest(1) 
#get the lowest
print(ans)
#print ans

"""
10.
ans = 
Age  NamesOcc       
1    lawyer                  3.066667
18   doctor/health care      3.235525
25   unemployed              3.366426
35   farmer                  2.642045
45   college/grad student    3.280000
50   farmer                  3.437610
56   sales/marketing         3.291755
"""

## 11. Find the top-5 states in terms of average rating.  Give in table form
##     including the state and average rating, sorted from highest to lowest.
##     Note: If any of the zip codes in 'users.dat' includes letters, then we
##     classify that user as being from Canada, which we treat as a state for
##     this and the next question.
ustates = zips[zips["Zipcode"].astype(str).str.contains('[a-zA-Z]') == False] #check if there are letters
ratingusers["Zipcode"] = ratingusers["Zip-code"].str.split("-").str[0].astype(int)
#split so that we only get what is before -
statesuser = pd.merge(ratingusers, ustates, on=['Zipcode'], how='inner')
#merge the ratingusers and ustates
fivenum = statesuser[(statesuser["Zipcode"] > 9999) & (statesuser["Zipcode"] < 100000)] #5digit zip code
ans = fivenum["Rating"].groupby(fivenum["State"]).mean().sort_values(ascending=False)[0:5]
#get the top five states by taking averge rating
print(ans)
#print 
"""
11.
ans = 
State
GU    4.236842
AK    4.008094
AP    3.938967
MS    3.913241
IN    3.820510
Name: Rating, dtype: float64
"""

## 12. For each genre, determine which state produced the most reviews.  
##     (Include any ties.)

users["Zipcode"] = users["Zip-code"].str.split("-").str[0].astype(int)
#split to get whatever ie before the -
userszips = pd.merge(users, zips, on=['Zipcode'], how='inner')
#merge users and zips
userszipsratings = pd.merge(userszips, ratings, on=['UserID'], how='inner')
#merge userszipsratings
final = pd.merge(userszipsratings, movies, on=['MovieID'], how='inner')
#merge userzipsratings and movies
genrelists = movies['Genre'].str.split('|')
#split the genres
lists=np.unique(sum(genrelists,[]))
#get the unqiue
genrestop = []
#the genres
for i in lists.tolist():
    #for the genres
    data = final[final['Genre'].str.contains(i)]
    #subset the dataframe 
    state = data['Rating'].groupby(data['State']).count()
    #group by state and count  the number of ratings
    reviews = state.sort_values(ascending=False).reset_index()[0:1]
    #reset the index and get the top 1st value
    genrestop.append([i,reviews["State"][0], reviews["Rating"][0]])
    #append it in a list format
topgenre = pd.DataFrame(genrestop, columns=['Genre','State','Reviews'])
#make into dataframe
print(topgenre)
#output dataframe


"""
12.
ans = 
          Genre State  Reviews
0        Action    CA    82536
1     Adventure    CA    42273
2     Animation    CA    13587
3    Children's    CA    21920
4        Comedy    CA   109518
5         Crime    CA    25736
6   Documentary    CA     2797
7         Drama    CA   111456
8       Fantasy    CA    10898
9     Film-Noir    CA     6239
10       Horror    CA    23253
11      Musical    CA    12697
12      Mystery    CA    13192
13      Romance    CA    45406
14       Sci-Fi    CA    50330
15     Thriller    CA    61704
16          War    CA    20989
17      Western    CA     6397
"""
