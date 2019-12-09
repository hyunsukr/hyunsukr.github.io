##
## File: assignment04.py (STAT 3250)
## Topic: Assignment 4
## Name: Max Ryoo
## computing id: hr2ee

##  This assignment requires the data file 'airline_tweets.csv'.  This file
##  contains records of over 14000 tweets and associated information related
##  to a number of airlines.  You should be able to read this file in using
##  the usual pandas methods.
import pandas as pd
import numpy as np
tweets = pd.read_csv("airline_tweets.csv")

##  Note: Questions 1-9 should be done without the use of loops.   
##        Questions 10-13 can be done with loops.

## 1.  Determine the number of tweets for each airline, indicated by the
##     name in the 'airline' column of the data set.  Give the airline 
##     name and number of tweets in table form.


subset = tweets["airline"].groupby(tweets["airline"]) #group by airline
ans = subset.count() #get the number of counts
print(ans) #print ans
len(tweets)
"""
1. 

ans = 
airline
American          2759
JetBlue           2222
Southwest         2420
US Airways        2913
United            3822
Virgin America     504
"""

## 2.  For each airlines tweets, determine the percentage that are positive,
##     based on the classification in 'airline_sentiment'.  Give a table of
##     airline name and percentage, sorted from largest percentage to smallest.
airline = tweets['airline_sentiment'].groupby(tweets['airline']) #group by airline
total = airline.count() #count the above groups
positive = tweets.loc[tweets['airline_sentiment']=='positive'] #
#find the positive airline_sentiments
numerator = positive['airline_sentiment'].groupby(positive['airline']) 
#get the number of postives
number = numerator.count() #count the number observations above
print((number/total*100).sort_values(ascending = False))
#get the percentage and sort

"""
2. 
ans = 
airline
Virgin America    30.158730
JetBlue           24.482448
Southwest         23.553719
United            12.872841
American          12.178325
US Airways         9.234466
"""


## 3.  List all user names (in the 'name' column) with at least 20 tweets
##     along with the number of tweets for each.  Give the results in table
##     form sorted from most to least.
tweets = pd.read_csv("airline_tweets.csv") #reread original file
names = tweets.groupby(tweets["name"]) #group by each name
table = names.size() #get the counts/size
ans = table[table >=20].sort_values(ascending=False) #filter on at least 20 tweets and sort values
print(ans) #print answer
"""
3.

ans = 
name
JetBlueNews        63
kbosspotter        32
_mhertz            29
otisday            28
throthra           27
weezerandburnie    23
rossj987           23
MeeestarCoke       22
GREATNESSEOA       22
scoobydoo9749      21
jasemccarty        20
"""

## 4.  Determine the percentage of tweets from users who have more than one
##     tweet in this data set.
names = tweets.groupby(tweets["name"]) #group by each name
table = names.size() #get the counts/size
total = len(table) #get the length of the total names table
morethanone = len(table[table > 1]) #filter with tweets more than one
percentage = morethanone/total * 100 #get percentage
print(percentage)
"""
4.
ans = 
38.955979742890534
"""

## 5.  Among the negative tweets, which five reasons are the most common?
##     Give the percentage of negative tweets with each of the five most 
##     common reasons.  Sort from most to least common.

negative = tweets[tweets["airline_sentiment"] == "negative"] #get the negative
table = negative.groupby(negative["negativereason"]).size()/len(negative) *100 
#group by reason then get count and get percentage
ans = table.sort_values(ascending=False)[0:5] #get the top 5 reasons
print(ans)
"""
5.
ans = 
negativereason
Customer Service Issue    31.706254
Late Flight               18.141207
Can't Tell                12.965788
Cancelled Flight           9.228590
Lost Luggage               7.888429
"""

## 6.  How many of the tweets for each airline include the phrase "on fleek"?

subset = tweets[tweets["text"].str.contains("on fleek")]
subset = subset["airline"].groupby(subset["airline"]) #group by airline
ans = subset.count() #get the number of counts
print(ans) #print ans

"""
6.
ans = 
airline
JetBlue    146
"""

## 7.  What percentage of tweets included a hashtag?

subset = tweets[tweets["text"].str.contains("#")] #subset where text includes hashtag
numhash = len(subset) #get the length of that subset
percentage = 100*numhash/len(tweets) #divide with the length of entire dataset to get percentage
print(percentage) #print percentage

"""
7
ans = 
17.00136612021858
"""

## 8.  How many tweets include a link to a web site?
subset = tweets[tweets["text"].str.contains("http")] #which entries contain http
numlink = len(subset) #get the length of subset
print(numlink) #print the length/number of tweets
"""
8.

ans = 
1173
"""
## 9.  How many of the tweets include an '@' for another user besides the
##     intended airline?
txt = tweets['text'] #seperate the text
count= len(txt[txt.str.count('@') > 1]) #see if there is more than one @ in teh text
print(count)#then print the length

"""
9.
ans = 
1645
"""

## 10. Suppose that a score of 1 is assigned to each positive tweet, 0 to
##     each neutral tweet, and -1 to each negative tweet.  Determine the
##     mean score for each airline, and give the results in table form with
##     airlines and mean scores, sorted from highest to lowest.
#make a function called score
def score(x):
    if x == 'positive': #if positive
        return(1) #return 1
    elif x == 'negative': #if negative return -1
        return(-1)
    else:
        return(0) #if else return 0
tweets['airline_sentiment_cs']=tweets['airline_sentiment'].apply(score) #apply the function
scores =tweets['airline_sentiment_cs'].groupby(tweets['airline'])# group by airline
ans = scores.mean().sort_values(ascending=True) #get mean and sort
print(ans)#get the ans and print
"""
10.
ans = 
airline
US Airways       -0.684518
American         -0.588619
United           -0.560178
Southwest        -0.254545
JetBlue          -0.184968
Virgin America   -0.057540
"""
## 11. Among the tweets that "@" a user besides the indicated airline, 
##     what percentage include an "@" directed at the other airlines 
##     in this file? (Note: Twitterusernames are not case sensitive, 
##     so '@MyName' is the same as '@MYNAME' which is the same as '@myname'.)

text = tweets['text'] #texts
airline = tweets['airline'] #airlines
airline_list = ['@united', '@american', '@jetblue', 
                '@southwest', '@virginamerica', '@usairways']
#list of airlines
ct = 0 #counter variable
for i in range(len(text)): #for loop
    temp_text = text[i].lower() #lowercase text
    intended_airline = airline[i].lower()
    if intended_airline == "united":
        mention = "@united"
    elif intended_airline == "american":
        mention = "@american"
    elif intended_airline == "jetblue":
        mention = "@jetblue"
    elif intended_airline == "southwest":
        mention = "@southwest"
    elif intended_airline == "virgin america":
        mention = "@virginamerica"
    elif intended_airline == "us airways":
        mention = "@usairways"
    temp_airline = airline_list[:]
    temp_airline.remove(mention)
    for air in temp_airline:
        if air in temp_text:
            ct += 1
            break
print(100*ct/len(text))
"""
11.
ans = 2.4453551912568305
"""
## 12. Suppose the same user has two or more tweets in a row, based on how they 
##     appear in the file. For such tweet sequences, determine the percentage
##     for which the most recent tweet (which comes nearest the top of the
##     file) is a positive tweet.
currentname = "startoftheloop" #start loop string
counter = 0 #counter for positive
countertotal = 0 #counter for total streaks
counteriter = 0 #counter for currentstreak
for i in range(len(tweets)): #for loop
    if currentname == tweets["name"][i]: #if the previous is the same user
        counteriter = counteriter + 1 #add one to the counter
        if counteriter == 1: #if the counter is edactly 1
            if tweets["airline_sentiment"][i - 1] == "positive":
                #if the previous is positive when exactly 1
                counter = counter + 1 #add one to the counter of positives
            countertotal = countertotal + 1 #add one to the total count
    else: #else loop
        currentname = tweets["name"][i] #reset the current name to current name
        counteriter = 0 #reset counter variable
percentage = counter/countertotal * 100 #calculate percentage
print(percentage) #print the percentage collected
"""
12.
ans = 11.189634864546525
"""

## 13. Give a count for the top-10 hashtags (and ties) in terms of the number 
##     of times each appears.  Give the hashtags and counts in a table
##     sorted from most frequent to least frequent.  (Note: Twitter hashtags
##     are not case sensitive, so '#HashTag', '#HASHtag' and '#hashtag' are
##     all regarded as the same. Also ignore instances of hashtags that are
##     alone with no other characters.)

hashtag = tweets[tweets["text"].str.contains("#")]["text"] #subset where text has hashtag
dicthash = {} #make a dictionary
for text in hashtag: #for thing in subset
    list = text.lower().split("#") #split by #
    for i in range(1, len(list)): #for each thing in split list
        temp= list[i].split(" ")[0] #split by space and get first thing
        if temp == '': #if hashtag is nothing continue
            continue #continue
        elif temp in dicthash: #if the hashtag exists increment the counter
            dicthash[temp] = dicthash[temp] + 1 #by one
        else: #if not in dictionary
            dicthash[temp] = 1 #make a key value pair
top10 = sorted(dicthash.items(), key=lambda kv:kv[1], reverse=True)
#sort the items in descending order by number of occurrence
ans = top10[0:10]
#get the top 10
table = pd.DataFrame(ans)
#convert to dataframe
table.columns = ["hashtags", "occurrence"]
#rename the columns
print(table) #print the table
"""
13.
             hashtags  occurrence
0  destinationdragons          78
1                fail          64
2             jetblue          45
3      unitedairlines          43
4     customerservice          34
5           usairways          30
6    americanairlines          26
7              united          26
8          neveragain          26
9       usairwaysfail          26
"""





