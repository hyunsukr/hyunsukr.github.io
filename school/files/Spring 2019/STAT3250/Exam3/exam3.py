##
## File: exam-solns.py (STAT 3250)
## Topic: Exam 3 Solutions
##  Max Ryoo

##  Exam 3 consists of three sections.  All code should be submitted as a single 
##  Python file.  Section 3 is on creating plots.  The plots will be submitted 
##  in a separate PDF document.

####
####  Section A
####

##  For this portion of Exam 3 you will be working with Twitter data related
##  to the season opening of Game of Thrones on April 14.  You will use a set
##  of 10,790 tweets for this purpose.  The data is in the file 'GoTtweets.txt'.  
##  The code below can be used to import the data into a list, with each
##  list element a dict of the tweet object.

import json
import pandas as pd
import numpy as np
pd.set_option('display.max_columns', 10) # Display 10 columns in console
import matplotlib.pyplot as plt


# Read in the tweets and append them to 'tweetlist'
tweetlist = []
for line in open('GoTtweets.txt', 'r'): # Open the file of tweets
    tweetlist.append(json.loads(line))  # Add to 'tweetlist' after converting



## A1. The tweets were downloaded in several groups at about the same time.
##     Are there any that appear in the file more than once?  List the tweet 
##     ID for any repeated tweets, along with the number of times each is
##     repeated.
listtweetid = [] #list of empty tweet
datatweet = pd.DataFrame(tweetlist) #make tweetlist into df
ids, counts = np.unique(datatweet["id"],return_counts = True)
#return counts of unique ids
counts = pd.DataFrame({"ID":ids, "Counts":counts})
#make df
repeat = counts[counts["Counts"] > 1]
#get counts >1
print(repeat)

"""
A1.
ans= 
                        ID  Counts
1962   1117608741099069440       2
2013   1117608744639025152       2
10160  1117619559043948544       2
10182  1117619562588057600       2
"""

## Note: For the remaining questions in this section, do not worry about 
##       the duplicate tweets.  Just answer the questions based on the 
##       existing data set.
    
## A2. Some tweeters like to tweet a lot.  Find the screen name for all 
##     tweeters with at least 5 tweets in the data.  Give the screen name
##     and the number of tweets.  
user = pd.DataFrame(datatweet["user"].tolist())
#make the user column into a df
counts = user["screen_name"].groupby(user["screen_name"]).count()
#goup by screenname and get the count
ans = counts[counts >= 5].sort_values(ascending=False)
#get where the count is >5
print(ans)
"""
A2.
ans = 
screen_name
taehyungiebtsdm    6
Eleo_Ellis         6
caioomartinez      5
_sherycee          5
Czo18              5
"""
## A3. Determine the number of tweets that include the hashtag '#GoT', then
##     repeat for '#GameofThrones'.
##     Note: Hashtags are not case sensitive, so any of '#GOT', '#got', 'GOt' 
##     etc are all considered matches.  Each tweet object has a list of
##     hashtag objects -- use those for this problem, not the text of the
##     tweet.
entities = pd.DataFrame(datatweet["entities"].tolist())
#make entities into a dataframe
listhash = []
#make an empty list
def freqhash(listobject):
    #define a function called freq hash
    if len(listobject) > 0:
        #if the length of object passed in is greater than 0
        df = pd.DataFrame(listobject)
        #make it into a dataframe
        hashtag, counts = np.unique(df["text"].str.lower(), return_counts=True)
        #get the unique hashtags and counts
        df2 = pd.DataFrame({"Hashtag":hashtag, "Counts":counts})
        #make a dataframe
        df2["Counts"] = 1
        #set the counts to one 
        listhash.append(df2)
        #append it to the list
        return "Completed"
        #return completed to signify taht the function is done
entities["hashtags"].apply(freqhash)
#apply the function
hashtags = pd.concat(listhash)
#concat the list
ans = hashtags["Counts"].groupby(hashtags["Hashtag"]).count().sort_values(ascending=False).reset_index()[0:5]
#sort the values
ans = ans[(ans["Hashtag"] == "got") | (ans["Hashtag"] == "gameofthrones" )]
#get teh gameofthrones and got hashtags
print(ans) #print ans
"""
A3.
ans = 
         Hashtag  Counts
0  gameofthrones    8364
1            got    1032
"""


## A4. Among the screen names with 4 or more tweets, find the 
##     'followers_count' for each and then give a table of the top-5 
##     (plus ties) in terms of number of followers. Include the screen 
##     name and number of followers.  (If the number of followers changes
##     for a given screen name, then report the average number of followers 
##     among all of the tweeter's tweets.) 
names = pd.DataFrame(datatweet["user"].tolist())["screen_name"]
#make the username screen name into a dataframe
followers = pd.DataFrame(datatweet["user"].tolist())["followers_count"]
#make the follower count into a dataframe as well
dfnames = pd.DataFrame({"Name" : names, "Followers":followers})
#make a df of names and followers
name, count = np.unique(dfnames["Name"], return_counts=True)
#get np unique and return the counts of their occurence
namecount = pd.DataFrame({"Name":name, "Count":count})
#make a df of the name and count
followercount = dfnames["Followers"].groupby(dfnames["Name"]).mean().reset_index()
#reset the index
folnamedf = pd.merge(namecount, followercount, on="Name")
#merge the dataframes
folnamedffour = folnamedf[folnamedf["Count"] >= 4]
#count of greater than or equal to 4
print(folnamedffour.sort_values(by="Followers",ascending=False)[0:5])
#print the top 5
"""
A4.
ans = 

                Name  Count  Followers
5167        bbystark      4    9313.00
1523   Gamoraavengxr      4    3842.00
1249      Eleo_Ellis      6    2948.00
1671  HellblazerArts      4    2506.00
996         Dahoralu      4    1901.25
"""
## A5. Find the mean number of hashtags included in the tweets. 
def numhash(listobject): #defintion of function
    return len(listobject) #get lenght of passed in 

avghash = entities["hashtags"].apply(numhash).sum()/len(entities["hashtags"])
#divide the num of hashtags with num of tweets

print(avghash)
#print the avg
"""
A5.
ans = 
1.0022242817423541
"""

## A6. Give a table of hashtag counts: How many tweets with 0, 1, 2, ...
##     hashtags?
def numhash(listobject): #definition
    return len(listobject) #return the length of list
numhash, counts = np.unique(entities["hashtags"].apply(numhash), return_counts = True)
#get the unique and their respective counts
ans = pd.DataFrame({"Hashtag count":numhash, "Counts":counts})
#make into dataframe
print(ans)
#print the ans
"""
A6.
ans = 
    Hashtag count  Counts
0               0    1575
1               1    8111
2               2     768
3               3     242
4               4      55
5               5      24
6               6      10
7               7       2
8               8       1
9               9       1
10             10       1
"""
## A7. Determine the number of tweets that include 'Daenerys' (any combination
##     of upper and lower case) in the text of the tweet.  Then do the same 
##     for 'dragon'.
dftext = pd.DataFrame(datatweet["text"])
#get the text field
daenerys = len(dftext[dftext["text"].str.lower().str.contains("daenerys")])
#check if that series as the words denerys
dragon = len(dftext[dftext["text"].str.lower().str.contains("dragon")])
#see how many entries have teh words dragon
print("Daenerys: ", daenerys) #print
print("Dragons: ", dragon) #print

"""
A7.
ans = 
Daenerys:  735
Dragons:  385
"""
## A8.  Determine the 5 most frequent hashtags, and the number of tweets that
##      each appears in.  As usual, give a table.
listhash = [] #make an empty list
def freqhash(listobject): #define a funciton
    if len(listobject) > 0: #get the length of the passed in parameter
        df = pd.DataFrame(listobject) #make it into a dataframe
        hashtag, counts = np.unique(df["text"].str.lower(), return_counts=True) #get teh unique
        df2 = pd.DataFrame({"Hashtag":hashtag, "Counts":counts})
        #make into a df again
        df2["Counts"] = 1
        #assign the counts to 1
        listhash.append(df2)
        #listhash.append the df
        return "Completed"

entities["hashtags"].apply(freqhash)
#apply the freqhash function
hashtags = pd.concat(listhash)
#contact the dfs
ans = hashtags["Counts"].groupby(hashtags["Hashtag"]).count().sort_values(ascending=False).reset_index()[0:5]
#get the top 5
print(ans)
"""
A8.
ans = 

                Hashtag  Counts
0         gameofthrones    8364
1                   got    1032
2          forthethrone     219
3  gameofthronesseason8     124
4            demthrones     110
"""
## A9.  Determine the 5 most frequent 'user_mentions', and the number of tweets 
##      that each appears in.  Give a table.
listuser = [] #make an emtpy list
def freqhash(listobject): #make a function
    if len(listobject) > 0: #get the length of the function
        df = pd.DataFrame(listobject) #make it into a dataframe
        hashtag, counts = np.unique(df["screen_name"].str.lower(), return_counts=True)
        #get the unique hashtags and counts
        df2 = pd.DataFrame({"Name":hashtag, "Counts":counts})
        #make it into a smaller df
        df2["Counts"] = 1
        #make the counts all one for duplication error avoidance
        listuser.append(df2) #append the mini dataframe to the listuer list
        return "Completed" #return completed to signfy that it is done
entities["user_mentions"].apply(freqhash) #apply the function
usermention = pd.concat(listuser) #concat all the dataframes in the list of dataframes
ans = usermention["Counts"].groupby(usermention["Name"]).count().sort_values(ascending=False).reset_index()[0:5]
#get the top 5 user_mention
print(ans) #print ans
"""
A9.
ans = 
            Name  Counts
0  gameofthrones     502
1      ygorfremo      82
2     gotthings_      79
3        complex      75
4          tpain      60
"""
    
    
####
####  Section B
####

##  We will use the 'Stocks' data sets from Assignment 8 in this section.
##  You can see some information about the data in the assignment description.

##  The time interval covered varies from stock to stock. There are some 
##  missing records, so the data is incomplete. Note that some dates are not 
##  present because the exchange is closed on weekends and holidays. Those 
##  are not missing records. Dates outside the range reported for a given 
##  stock are also not missing records, these are just considered to be 
##  unavailable. Answer the questions below based on the data available in 
##  the files.

import glob # 'glob' searches for files

filelist = glob.glob('Stocks/*.csv') # 'glob.glob' is the directory search

df = pd.DataFrame() #large df
for f in filelist: #for every file
    newdf = pd.read_csv(f) #read csv
    name = f.split(".")[0].split("/")[1]
    newdf["Name"] = name
    df = pd.concat([df,newdf]) #add csv

## B1.  Use the collective data to determine when the market was open from 
##      January 1, 2008 to December 31, 2015. (Do not use external data for 
##      this question.) Report the number of days the market was open for 
##      each year in 2008-2015. Include the year and the number of days in 
##      table form.
B1 = df #make a copy of the df
B1["Datedt"] = pd.to_datetime(B1["Date"])
#convert the date to a datetime object and call it datedt
subset = B1[(2008 <= B1["Datedt"].dt.year) & (B1["Datedt"].dt.year <= 2015)]
#subset the years to between 2008 and 2015
subset = pd.DataFrame(subset["Datedt"].drop_duplicates())
#drop any duplicate values
subset["Year"] = subset["Datedt"].dt.year
#make a column called year
ans = subset.groupby(subset["Year"]).count().reset_index()
#group by the year and get the counts
ans.columns = ["Year", "Count"]
#rename the columns of the dataframe
print(ans) #print the ans
"""
B1.
ans = 

   Year  Count
0  2008    253
1  2009    252
2  2010    252
3  2011    252
4  2012    250
5  2013    252
6  2014    252
7  2015    252
"""

## B2.  Determine the total number of missing records for all stocks for the 
##      period 2008-2015.
df["Datedt"] = pd.to_datetime(df["Date"])
#make the datedt by changeing type of date column
subdrop = df[(2007 < df["Datedt"].dt.year) & (df["Datedt"].dt.year < 2016)]
#subset the data so that it is in the range of 2007 and 2016
datesdropped = subdrop["Datedt"].drop_duplicates()
#drop the duplicate values
opendates = pd.Series(np.unique(datesdropped))
#make it into a series after getting the unique entries
totalcount = 0
#have a counter variable
names = np.unique(df["Name"])
#get the unique names of the stocks
for f in names:
    #for each sock
    subsetname = df[df["Name"] == f]
    #subset the stocks for the specific stock
    subsetname = subsetname[(2007 < subsetname["Datedt"].dt.year) & (subsetname["Datedt"].dt.year < 2016)]
    #subset into a the time configured
    maxs = subsetname["Datedt"].max() #get max in date
    mins = subsetname["Datedt"].min() #get min in date
    opensub = opendates[(opendates >= mins) & (opendates <= maxs)]
    #subset the opendates between min and max
    missing = len(opensub.loc[opensub.isin(subsetname['Datedt'])==False])
    #get the len of the missing dates
    totalcount = totalcount + missing
    #add it to the counter
print(totalcount)
#prin tthe total count

"""
B2.
ans = 
7168 records
"""

## B3.  For the period 2008-2015, find the 10 stocks (plus ties) that had the 
##      most missing records, and the 10 stocks (plus ties) with the fewest 
##      missing records. (For the latter, don’t include stocks that have no 
##      records for 2008-2015.) Report the stocks and the number of missing 
##      records for each.


df["Datedt"] = pd.to_datetime(df["Date"])
#convert the date into a datetime object and set it as another column
subdrop = df[(2007 < df["Datedt"].dt.year) & (df["Datedt"].dt.year < 2016)]
#subst teh data to be between 2007 2016
datesdropped = subdrop["Datedt"].drop_duplicates()
#drop the duplicates
opendates = pd.Series(np.unique(datesdropped))
#make it into a series
totalmiss = [] #make an emtpy list
names = np.unique(df["Name"]) #get the unique names of stocks
for f in names: #get the file names
    subsetname = df[df["Name"] == f]
    #subset for a specific stock
    subsetname = subsetname[(2007 < subsetname["Datedt"].dt.year) & (subsetname["Datedt"].dt.year < 2016)]
    #subset teh time for the df
    maxs = subsetname["Datedt"].max()
    #get teh max date
    mins = subsetname["Datedt"].min()
    #get the min date
    opensub = opendates[(opendates >= mins) & (opendates <= maxs)]
    #get the subset of opendates
    missing = len(opensub.loc[opensub.isin(subsetname['Datedt'])==False])
    #see what is not included
    totalmiss.append([f, missing])
    #append teh name of stock and count to totalmiss
missdates = pd.DataFrame(totalmiss)
#make it into a dataframe
missdates.columns = ["Stocks", "Count"]
#rename the columns
top10 = missdates.sort_values(by="Count", ascending=False)[0:12] #get top 10
print(top10)

bot10 =  missdates.sort_values(by="Count")[0:10] #get bottom 10
print(bot10)
"""
B3.
ans = 
    Stocks  Count
177    NBL     44
217     RF     37
120   HBAN     37
272    WAT     36
29     BBT     36
149     LB     36
197   PDCO     36
227    SEE     35
124    HOT     34
268   VRSN     34
215    RCL     34
105    GAS     34
    Stocks  Count
290    ZTS      0
287    XYL      0
252   TRIP      0
189   NWSA      0
183   NLSN      0
176   NAVI      0
157    LYB      0
9      ADT      0
112     GM      0
94      FB      0

"""
## B4.  Identify the top-10 dates (plus ties) in 2008-2015 that are missing 
##      from the most stocks.  Provide a table with dates and counts.

df["Datedt"] = pd.to_datetime(df["Date"]) #make it into a datetime object
subdrop = df[(2007 < df["Datedt"].dt.year) & (df["Datedt"].dt.year < 2016)]
#subset
datesdropped = subdrop["Datedt"].drop_duplicates()
#drop duplicates
opendates = pd.Series(np.unique(datesdropped))
#make into series
totalmiss = []
#emtpy list
names = np.unique(df["Name"])
#get teh unique name
for f in names:
    #for all the stocks
    subsetname = df[df["Name"] == f]
    #subset for specific stock
    subsetname = subsetname[(2007 < subsetname["Datedt"].dt.year) & (subsetname["Datedt"].dt.year < 2016)]
    #subset the year
    maxs = subsetname["Datedt"].max()
    #get the min and max
    mins = subsetname["Datedt"].min()
    #get the min and max
    subopen = opendates[(opendates >= mins) & (opendates <= maxs)]
    #get the sub component of open dates
    missing = subopen.loc[subopen.isin(subsetname['Datedt'])==False]
    #get the missing dates
    totalmiss.append(pd.DataFrame(missing))
    #append teh df
dates = pd.concat(totalmiss)
#make into a big df
dates.columns=["Dates"]
#rename columns
ans = dates["Dates"].groupby(dates["Dates"]).count().sort_values(ascending=False)[0:23]
#get the top 10
print(ans)
"""
B4.
ans = 
Dates
2012-04-23    11
2011-03-08    10
2013-01-30    10
2013-09-23    10
2009-12-24     9
2010-07-21     9
2012-04-24     9
2013-07-22     9
2009-08-13     9
2009-06-11     9
2008-06-10     9
2009-04-27     9
2012-06-25     9
2013-04-30     9
2008-04-01     9
2009-08-05     9
2008-04-03     9
2012-08-10     9
2009-04-06     9
2011-08-01     9
2013-11-05     9
2009-03-16     9
2013-08-29     9
"""


##  Questions B5 and B6: For each stock, impute (fill in) the missing records 
##  using linear interpolation. For instance, suppose d1 < d2 < d3 are dates,  
##  and P1 and P3 are known Open prices on dates d1 and d3, respectively, with
##  P2 missing.  Then we estimate P2 (the Open price on date d2) with
##
##    P2 = ((d3 − d2)P1 + (d2 − d1)P3)/(d3 − d1)
##
##  The same formula is used for the other missing values of High, Low, Close, 
##  and Volume.  Once you have added the missing records into your data, then
##  use the new data (including the imputed records) to calculate the Python 
##  Index for each date in 2008-2015 (see Assignment 8 for the formula). 
##  Remember that weekends and holidays are not missing records, so don’t 
##  impute those.  Once you're done with that, then you can answer B5 and B6.

## B5.  Find the Open, High, Low, and Close for the imputed Python Index for 
##      each day the market was open in January 2013. Give a table the includes 
##      the Date, Open, High, Low, and Close, with one date per row.

subdrop = df[(2007 < df["Datedt"].dt.year) & (df["Datedt"].dt.year < 2016)]
#subset
def times(x): #define function
    return(x.weekday())  #get the weekday

subdrop['dayn'] = subdrop['Datedt'].apply(times) #get the weekday of the daty
openlist5 = np.unique(subdrop['Date']) #get the open days
opendates5 = pd.DataFrame({'Opendate':openlist5}) #make the dates as dataframe
emptyb5=[] #make an empty lsit
for f in names: #for each stock files
    stock = subdrop[subdrop['Name']==f] #subset the data for each stocks
    sortedstock = stock.sort_values(by='Date',ascending=True) #sort by date
    startday = sortedstock['Date'].iloc[0] #find the starting date of the stock
    enday = sortedstock['Date'].iloc[(len(sortedstock)-1)] #find the ending date of the stock
    lower = opendates5.index[opendates5['Opendate'] == startday].tolist()[0]
    #start date of stock market
    upper = opendates5.index[opendates5['Opendate'] == enday].tolist()[0]
    #end date of stock market 
    newdate = opendates5['Opendate'][lower:(upper+1)]  #subset df
    news = pd.DataFrame({'Date':newdate}) #make as dataframe
    merged = pd.merge(sortedstock,news, on=['Date'],how='outer') #merge dataframes on the date element
    mergsort = merged.sort_values(by='Date',ascending=True) #sort values in ascending order
    reset = mergsort.reset_index() #reset the index of df
    missingvalues = reset.index[reset['Open'].isna()].tolist() #get the na values
    reset['Datess'] = pd.to_datetime(reset['Date']) #change date to datetime
    reset['dayn'] = reset['Datess'].apply(times) #apply times function
    for rec in missingvalues: #fill in the missingvalues
        d3_2 = (reset['Datess'][rec+1]- reset['Datess'][rec]).days #d3 - d2
        d2_1 = (reset['Datess'][rec]- reset['Datess'][rec-1]).days #d2 - d1
        d3_1 = (reset['Datess'][rec+1]- reset['Datess'][rec-1]).days #d3 - d1
        date = reset.iloc[rec]['Date']  #locate date for missing record
        stockname = reset.iloc[rec]['Name'] 
        #locate stock name of missing record
        p1_open = reset.iloc[rec-1]['Open'] 
        #p1 of open
        p3_open = reset.iloc[rec+1]['Open']
        #p3 of open
        popen_top = ((d3_2)*p1_open) + ((d2_1)*p3_open)
        #numerator
        popen = popen_top / (d3_1)
        #p2 of open
        p1_high = reset.iloc[rec-1]['High'] 
        #p1 of high
        p3_high = reset.iloc[rec+1]['High']
        #p3 of high
        phigh_top = ((d3_2)*p1_high) + ((d2_1)*p3_high)
        #numerator
        phigh = phigh_top / (d3_1)
        #division
        #p2 of high
        p1_low = reset.iloc[rec-1]['Low'] 
        #p1 of low
        p3_low = reset.iloc[rec+1]['Low'] 
        #p3 of low
        plow_top = ((d3_2)*p1_low) + ((d2_1)*p3_low)
        #numerator
        plow = plow_top/ (d3_1)
        #division
        #p2 of low
        p1_close = reset.iloc[rec-1]['Close'] #p1 of close
        p3_close = reset.iloc[rec+1]['Close'] #p3 of close
        pclose_top = ((d3_2)*p1_close) + ((d2_1)*p3_close)
        #numerator
        pclose = pclose_top / (d3_1) #p2 of close
        #division
        p1_vol = reset.iloc[rec-1]['Volume'] #p1 of volume
        p3_vol = reset.iloc[rec+1]['Volume'] #p3 of volume
        pvol_top = ((d3_2)*p1_vol) + ((d2_1)*p3_vol)
        pvol = pvol_top/ (d3_1) #p2 of volume
        reset.loc[rec] = pd.Series({'Date':date,'Open':popen, 'High':phigh, 'Low':plow, 'Close':pclose,'Volume':pvol})
        #fill in teh nas
    for w in range(0,len(reset)): #for each observations in interpolation data
        mss = reset.iloc[w] #subset
        emptyb5.append(mss) #append to the empty list
tableb5 = pd.DataFrame(emptyb5) #make as dataframe
jan2013 = tableb5[tableb5['Date'].str[0:7]=='2013-01'] #subset jan of 2013 from Date

jan2013['opvol'] = (jan2013['Open'] * jan2013['Volume']) #create opvol
jan2013['hivol'] = (jan2013['High'] * jan2013['Volume']) #create hivol
jan2013['lovol'] = (jan2013['Low'] * jan2013['Volume']) #create lovol
jan2013['clovol'] = (jan2013['Close'] * jan2013['Volume']) #create clovol
janopen = (jan2013['opvol'].groupby(jan2013['Date']).sum())/(jan2013['Volume'].groupby(jan2013['Date']).sum())
#PI for open
janhigh = (jan2013['hivol'].groupby(jan2013['Date']).sum())/(jan2013['Volume'].groupby(jan2013['Date']).sum())
#PI for high
janlow = (jan2013['lovol'].groupby(jan2013['Date']).sum())/(jan2013['Volume'].groupby(jan2013['Date']).sum())
#PI for low
janclose = (jan2013['clovol'].groupby(jan2013['Date']).sum())/(jan2013['Volume'].groupby(jan2013['Date']).sum())
#PI for close
ans = pd.DataFrame({'Open': janopen, 'High': janhigh, 'Low': janlow, 'Close': janclose})
#make dataframe with PI
print(ans) 

"""
B5.
ans = 
                 Open       High        Low      Close
Date                                                  
2013-01-02  37.054761  37.505297  36.638862  37.228915
2013-01-03  37.032179  37.523912  36.657750  37.081912
2013-01-04  37.404633  37.863218  37.142403  37.636333
2013-01-07  39.467304  39.985991  39.121514  39.630800
2013-01-08  39.403554  39.748143  38.922081  39.354890
2013-01-09  35.024724  35.401727  34.640686  35.003027
2013-01-10  37.033616  37.421070  36.654474  37.189733
2013-01-11  38.191304  38.514559  37.833823  38.247111
2013-01-14  38.484674  38.900076  38.112640  38.526461
2013-01-15  38.200333  38.754825  37.881484  38.366129
2013-01-16  39.376960  39.755706  38.911310  39.371881
2013-01-17  35.979870  36.329769  35.648391  35.974307
2013-01-18  40.134305  40.504265  39.723440  40.230839
2013-01-22  40.567323  41.068261  40.241281  40.851074
2013-01-23  44.641020  45.344795  44.288949  44.994229
2013-01-24  48.921170  49.827586  48.346726  49.279962
2013-01-25  55.089956  58.565085  54.817362  57.965279
2013-01-28  50.963814  51.568084  49.721003  50.138855
2013-01-29  42.852754  43.719166  42.382627  43.346702
2013-01-30  45.365733  45.742741  44.516468  44.955761
2013-01-31  43.908594  44.645015  43.391417  44.108205
"""

## B6.  Determine the mean Open, High, Low, and Close imputed Python index 
##      for each year in 2008-2015, and report that in a table that includes 
##      the year together with the corresponding Open, High, Low, and Close.
subdrop = df[(2007 < df["Datedt"].dt.year) & (df["Datedt"].dt.year < 2016)]
#subset the years
subdrop['Year'] = subdrop['Datedt'].dt.year 
#get the year
subdrop['opvol'] = (subdrop['Open'] * subdrop['Volume']) #make the opvol column
subdrop['hivol'] = (subdrop['High'] * subdrop['Volume']) #make the hivol volumn
subdrop['lovol'] = (subdrop['Low'] * subdrop['Volume']) #make the lovol column
subdrop['clvol'] = (subdrop['Close'] * subdrop['Volume']) #make the clvol column
b6open = (subdrop['opvol'].groupby(subdrop['Year']).sum())/(subdrop['Volume'].groupby(subdrop['Year']).sum())
#groupby the year and divide the opvol by volume
b6high = (subdrop['hivol'].groupby(subdrop['Year']).sum())/(subdrop['Volume'].groupby(subdrop['Year']).sum())
#groupby the year and divide the hivol by volume
b6low = (subdrop['lovol'].groupby(subdrop['Year']).sum())/(subdrop['Volume'].groupby(subdrop['Year']).sum())
#groupby the year and divide the lovol by volume
b6close = (subdrop['clvol'].groupby(subdrop['Year']).sum())/(subdrop['Volume'].groupby(subdrop['Year']).sum())
#groupby the year and divide the clvol by volume
ans = pd.DataFrame({'Open': b6open, 'High': b6high, 'Low': b6low, 'Close': b6close})
#make a dataframe
print(ans)

"""
B6.
ans = 
           Open       High        Low      Close
Year                                            
2008  38.301587  39.300424  37.188471  38.253685
2009  26.282817  26.869796  25.709767  26.314706
2010  35.281933  35.768472  34.753491  35.276531
2011  38.284020  38.845107  37.648714  38.239720
2012  37.151186  37.641648  36.687716  37.183567
2013  46.827730  47.377826  46.274983  46.839039
2014  57.809045  58.452907  57.113996  57.796364
2015  54.347531  54.992031  53.673537  54.340059
"""
####
####  Section C
####

##  This section requires the creation of a number of graphs. In addition to 
##  the code in your Python file, you will also upload a PDF document (not Word!)
##  containing your graphs (be sure they are labeled clearly).  The data file 
##  you will use is “samplegrades.csv”.

grades = pd.read_csv("samplegrades.csv")
#read the csv

## C1.  Make a scatter plot of the “Math” SAT scores (x-axis) against the 
##      “Read” SAT scores (y-axis). Label the plot “Math vs Read” and label
##      the axes "Math" and "Read".
x = grades["Math"]
#get the math scores
y = grades["Read"]
#get teh read scores
plt.scatter(x,y)
#make a scatter plot
plt.title('Math vs Read')
#make a title
plt.xlabel('Math')
#make a x label
plt.ylabel('Read')
#make a y label
plt.show()
#show the plot

## C2.  Make the same scatter plot as the previous problem, but this time 
##      color-code the points to indicate the “Sect” and choose different 
##      shapes to indicate the value of “Prev”.
Yes = grades[grades["Prev"] == "Y"]
#subset where prev = y
YesMW200x = Yes[Yes["Sect"] == "MW200"]["Math"]
#subset mw200 math
YesMW200y = Yes[Yes["Sect"] == "MW200"]["Read"]
#subset mw200 read
YesTR1230x = Yes[Yes["Sect"] == "TR1230"]["Math"]
#subset tr1230 math
YesTR1230y = Yes[Yes["Sect"] == "TR1230"]["Read"]
#subset tr1230 read
YesTR930x = Yes[Yes["Sect"] == "TR930"]["Math"]
#subset tr930 math
YesTR930y = Yes[Yes["Sect"] == "TR930"]["Read"]
#subset tr930 read

No = grades[grades["Prev"] == "N"]
#subset where prev = no
NoMW200x = No[No["Sect"] == "MW200"]["Math"]
#subset mw200 math
NoMW200y = No[No["Sect"] == "MW200"]["Read"]
#subset mw200 read
NoTR1230x = No[No["Sect"] == "TR1230"]["Math"]
#subset tr1230 math
NoTR1230y = No[No["Sect"] == "TR1230"]["Read"]
#subset tr1230 read
NoTR930x = No[No["Sect"] == "TR930"]["Math"]
#subset tr930 math
NoTR930y = No[No["Sect"] == "TR930"]["Read"]
#subset tr930 read

plt.title('Math vs Read')
#make a title
plt.xlabel('Math')
#xlabel is math
plt.ylabel('Read')
#ylabel is read
plt.scatter(YesMW200x,YesMW200y, marker="o",color = "red")
#scatter with color red and o marker
plt.scatter(YesTR1230x,YesTR1230y, marker="o",color = "green")
#scatter with color green and o marker
plt.scatter(YesTR930x,YesTR930y, marker="o",color = "blue")
#scatter with color blue and o marker
plt.scatter(NoMW200x,NoMW200y, marker="^",color = "red")
#scatter with color red and ^ marker
plt.scatter(NoTR1230x,NoTR1230y, marker="^",color = "green")
#scatter with color green and ^ marker
plt.scatter(NoTR930x,NoTR930y, marker="^",color = "blue")
#scatter with color blue and ^ marker
plt.show()
#show plot

## C3.  Make a histogram of the values of “CourseAve”. Label the graph 
##      “Course Averages”.
CourseAve = grades["CourseAve"]
#subset the courseave
plt.hist(CourseAve)
#plot histogram
plt.title('Course Averages')
#have title as course average
plt.show()
#show plot

## C4.  Make a histogram of the values of “Final” with color-coded portions 
##      indicating whether they scored at least 75 on the Midterm. Give 
##      the graph appropriate labels.
midterm = grades[grades["Midterm"] >= 75]
#subset midterm is > 75
final = midterm["Final"]
#get teh final from the midterms above 85
finaltotal = grades["Final"]
#get all the final grades
plt.hist(finaltotal, color="blue")
#set color as blue for all finals
plt.hist(final, range=[0,100], color="red")
#set color as red for all midterm above 75
plt.title('Portions of scores above 75 on midterms')
#give title
plt.show()
#show plot

## C5.  Make a bar chart of the counts for the different values of Year. 
##      Give the graph appropriate labels.

counts = grades["Year"].value_counts()
#count years
styles = counts.index
#index and counts
plt.bar(styles,counts)
#make bar plot
plt.title("The different years")
#give title
plt.show()
#show the plot

## C6.  Make side-by-side box-and-whisker plots for the ‘CourseAve” for each 
##      distinct “Sect”. Give the graph appropriate labels.

sect1 = grades[grades["Sect"] == "MW200"]
#subset section 1
sect2 = grades[grades["Sect"] == "TR1230"]
#subset section 2
sect3 = grades[grades["Sect"] == "TR930"]
#subset section 3
ca1 = sect1["CourseAve"]
#get the course ave for section 1
ca2 = sect2["CourseAve"]
#get the course ave for section 2
ca3 = sect3["CourseAve"]
#get the course ave for section 3
plt.boxplot([ca1,ca2,ca3])
#make boxplot
plt.xlabel("Section")
#x label as section
plt.ylabel("Score")
#y label as score
plt.xticks([1,2,3],["MW200","TR1230","TR930"])
#show which box is which
plt.show()
#show







