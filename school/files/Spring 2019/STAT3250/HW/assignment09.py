##
## File: assignment09.py (STAT 3250)
## Topic: Assignment 9 
## Max Ryoo

##  This assignment requires data from the file 
##
##      'ncaa.csv':  NCAA Men's Tournament Scores, 1985-2019
##
##  The organization of the file is fairly clear.  Each record has information
##  about one game, including the year, the teams, the final score, and each 
##  team's tournament seed.  All questions refer only to the data in this
##  file, not to earlier tournaments.

##  Note: The data set is from Data.World, with the addition of the 2019
##  tournament provided by your dedicated instructor.

import pandas as pd
import numpy as np
ncaa = pd.read_csv('ncaa.csv')

## 1.  Find all schools that have won the championship, and make a table that
##     incluldes the school and number of championships, sorted from most to
##     least.
championship = ncaa[ncaa["Region Name"] == "Championship"]
#Get championship games
champs = np.where(championship["Score"] > championship["Score.1"], championship["Team"],championship["Team.1"])
#see who won by using higher score 
uniq, counts = np.unique(champs, return_counts=True)
#get the unique winners and how many times they appeared as champ
dictdf = {"School":uniq, "Number of Championships":counts}
#make a dictionary of school name and then number of championship
tablechamps = pd.DataFrame(dictdf).sort_values(by="Number of Championships", ascending=False)
#sort the dictionary by the number of championships
print(tablechamps)
#print the table ans
"""
1.
ans = 
            School  Number of Championships
3             Duke                        5
12  North Carolina                        4
2      Connecticut                        4
16       Villanova                        3
7         Kentucky                        3
4          Florida                        2
6           Kansas                        2
8       Louisville                        2
0          Arizona                        1
15            UNLV                        1
14            UCLA                        1
13        Syracuse                        1
9         Maryland                        1
11     Michigan St                        1
10        Michigan                        1
1         Arkansas                        1
5          Indiana                        1
17        Virginia                        1
"""
## 2.  Find the top-10 schools based on number of tournament appearances.
##     Make a table that incldes the school name and number of appearances,
##     sorted from most to least.  Include all that tie for 10th position
##     if necessary.

roundone = ncaa[ncaa["Round"] ==1]
#subset the first round
allteams = roundone["Team"].append(roundone["Team.1"])
#get all the teams into one series
uniq, counts = np.unique(allteams, return_counts=True)
#see how mnay times they appeared in the tournament
dictdf = {"School": uniq, "Number of appearance": counts}
#make a dictionary of school and the number of appearance
tableappearance = pd.DataFrame(dictdf).sort_values(by="Number of appearance", ascending=False)[0:11]
#sort by number of appearance and get top 10
print(tableappearance)
#print ans
"""
2.
ans = 
             School  Number of appearance
114          Kansas                    34
64             Duke                    34
173  North Carolina                    32
9           Arizona                    32
117        Kentucky                    30
147     Michigan St                    29
250        Syracuse                    28
255           Texas                    26
209          Purdue                    26
130      Louisville                    26
192        Oklahoma                    26
"""

## 3.  Determine the average tournament seed for each school, then make a
##     table with the 10 schools that have the lowest average (hence the
##     best teams). Sort the table from smallest to largest, and include
##     all that tie for 10th position if necessary.
df3 = ncaa[ncaa["Round"] == 1]
#subset the first round
allteams = df3["Team"].append(df3["Team.1"])
#get all the teams not in t v t format
allseeds = df3["Seed"].append(df3["Seed.1"])
#get all the seeds
dictdf = {"Team": allteams, "Seed":allseeds}
#make a dictionary of teams and their respective seeds
tableseeds = pd.DataFrame(dictdf)
#make into a dataframe
ans = tableseeds["Seed"].groupby(tableseeds["Team"]).mean().sort_values()[0:10]
#group by team and get the average seed that they were given. The subset the top 10
print(ans)
#print ans
"""
3.
ans= 
Team
Duke               2.176471
Kansas             2.500000
North Carolina     2.718750
Kentucky           3.566667
Connecticut        3.950000
Loyola Illinois    4.000000
Massachusetts      4.375000
Syracuse           4.428571
Arizona            4.437500
Ohio St            4.450000
"""
## 4.  Give a table of the average margin of victory by round, sorted by
##     round in order 1, 2, ....

df4 = ncaa
#make a copy of dataframe
df4["Margin"] = np.abs(df4["Score"] - df4["Score.1"])
#get the margin
ans = df4["Margin"].groupby(df4["Round"]).mean()
#get teh mean of margin by the round grouping
print(ans)
#print ans

"""
4.
ans= 
Round
1    12.956250
2    11.275000
3     9.917857
4     9.707143
5     9.485714
6     8.257143
"""

## 5.  Give a table of the percentage of wins by the higher seed by round,
##     sorted by round in order 1, 2, 3, ...
df5 = ncaa
#make a copy of dataframe
first = np.where((ncaa["Score"] > ncaa["Score.1"]) & (ncaa["Seed"] < ncaa["Seed.1"]), 1, 0)
#gt if the seed was better and teh score was better
second =  np.where((ncaa["Score"] < ncaa["Score.1"]) & (ncaa["Seed"] > ncaa["Seed.1"]), 1, 0)
#gt if the seed was better and teh score was better
highseedwin = first + second
#add the two arrays
df5["higherwin"] = highseedwin
#set the higherwin as the highseedwin
sums = df5["higherwin"].groupby(ncaa["Round"]).sum()
#the how many the higher seed won
total = df5["higherwin"].groupby(ncaa["Round"]).count()
#get the totla count of games
ans = sums/total * 100
#get the percentages
print(ans)
#print the ans

"""
5.
ans= 
Round
1    74.285714
2    71.250000
3    71.428571
4    55.000000
5    48.571429
6    57.142857
"""
## 6.  Determine the average seed for all teams in the Final Four for each
##     year.  Give a table of the top-5 in terms of the lowest average seed
##     (hence teams thought to be better) that includes the year and the
##     average, sorted from smallest to largest.
finalfour = ncaa[ncaa["Region Name"] == "Final Four"]
#subset the final four games
first = finalfour["Seed"].groupby(finalfour["Year"]).mean()
#get the seed by each year of left team
second = finalfour["Seed.1"].groupby(finalfour["Year"]).mean()
#get the seed by each year of right team
final = (first + second)/2
#get the average again of left and right
ans = final.sort_values()[0:8]
#get teh top 5 years
print(ans)
#print answer
"""
6.
ans = 
Year
2008    1.00
1993    1.25
2007    1.50
2001    1.75
1999    1.75
1997    1.75
1991    1.75
2009    1.75
"""

## 7.  For the first round, determine the percentage of wins by the higher
##     seed for the 1-16 games, for the 2-15 games, ..., for the 8-9 games.
##     Give a table of the above groupings and the percentage, sorted
##     in the order given.

df7 = ncaa[ncaa["Round"] == 1]
#get the first round
df7["combo"] = df7["Seed"].astype(str) + '-' + df7["Seed.1"].astype(str)
#get the combo such as 1-16 by converting into string and adding them together
total = df7["higherwin"].groupby(df7["combo"]).count()
#get the number of counts by grouping by combo
wins = df7["higherwin"].groupby(df7["combo"]).sum()
#get the number of wins by grouping by combo
ans = wins/total * 100
#get the prercentages
print(ans)
#print the answer
"""
7.
ans = 
combo
1-16    99.285714
2-15    94.285714
3-14    85.000000
4-13    79.285714
5-12    64.285714
6-11    62.857143
7-10    60.714286
8-9     48.571429
"""

## 8.  For each champion, determine the average margin of victory in all
##     games played by that team.  Make a table to the top-10 in terms of
##     average margin, sorted from highest to lowest.  Include all that tie
##     for 10th position if necessary.
championship = ncaa[ncaa["Region Name"] == "Championship"]
#get teh championship games
winners = np.where(championship["Score"] > championship["Score.1"], championship["Team"], championship["Team.1"])
#get the winners
winners_list = np.unique(winners).tolist()
#get the unique winners

df8 = ncaa
#make a copy of the dataframe
winners = np.where(df8["Score"] > df8["Score.1"], df8["Team"], df8["Team.1"])
#after comparing score get the team that won taht round for all games
df8["Winners"] = winners
#make a column called winners to show who won
df8["Margin"] = np.abs(df8["Score"] - df8["Score.1"])
#get the margin of win by getting absolute value

yearwinner = championship[["Year","Winners"]]
#make a small df
yearwinner.columns = ['Year', 'Champion']
#rename the columns
df8 = pd.merge(df8,yearwinner, on ="Year", how="inner")
#merge by inner join

df8.groupby(df8["Year"])


listdf = []
#make an empty list
for team in winners_list:
    #for every time in the winnerlist
    subset = df8[(df8["Champion"] == team) & (df8["Winners"] == team)]
    #subset the games where that team won 
    smalldf = subset["Margin"].groupby(subset["Year"]).mean().reset_index()
    #group by year
    smalldf["Team"] = team
    #get the mean of the margins for that team
    listdf.append(smalldf)
    #append a list that contains the team and avg margin to the listdf
listdf
dataframe = pd.concat(listdf)
#make a dataframe from listdf with columns team and avg margin
ans = dataframe.sort_values(by="Margin",ascending=False)[0:10]
#sort by avg margin and get the top 10
print(ans)
#print ans
"""
8.
ans =
   Year     Margin            Team
0  1996  21.500000        Kentucky
1  2016  20.666667       Villanova
2  2009  20.166667  North Carolina
0  1990  18.666667            UNLV
2  2018  17.666667       Villanova
2  2001  16.666667            Duke
1  2013  16.166667      Louisville
0  2006  16.000000         Florida
0  1993  15.666667  North Carolina
4  2015  15.500000            Duke
"""
## 9.  For each champion, determine the average seed of all opponents of that
##     team.  Make a table of top-10 in terms of average seed, sorted from 
##     highest to lowest.  Include all that tie for 10th position if necessary.
##     Then make a table of the bottom-10, sorted from lowest to highest.
##     Again include all that tie for 10th position if necessary. 
championship = ncaa[ncaa["Region Name"] == "Championship"]
#get teh championship games
winners = np.where(championship["Score"] > championship["Score.1"], championship["Team"], championship["Team.1"])
#get the winners
winners_list = np.unique(winners).tolist()
#get the unique winners

df9 = ncaa
#make a copy of the dataframe
winners = np.where(df9["Score"] > df9["Score.1"], df9["Team"], df9["Team.1"])
#after comparing score get the team that won taht round for all games
df9["Winners"] = winners
#make a column called winners to show who won
df9["Margin"] = np.abs(df9["Score"] - df9["Score.1"])
#get the margin of win by getting absolute value

yearwinner = championship[["Year","Winners"]]
#make a mini df
yearwinner.columns = ['Year', 'Champion']
#rename the columns
df9 = pd.merge(df9,yearwinner, on ="Year", how="inner")
#merge the dataframes together to get champions

teamseed = []
#empty list used later for dataframe
for team in winners_list:
    #for every team in the winner list
    totalseed = 0
    #total seed variable set to 0
    subset = df9[(df9["Champion"] == team) & (df9["Winners"] == team)]
    #Subset champion and winners is the team in the loop
    seeds1 = np.where(subset["Team"] == subset["Champion"], subset["Seed.1"],0)
    #get opponent seed
    seeds2 = np.where(subset["Team.1"] == subset["Champion"], subset["Seed"],0)
    #get the opponent seed
    seeds = seeds1 + seeds2
    #add it as a new columns
    subset["Oppseeds"] = seeds
    #get the seeds  grouped by year
    totalseed = subset["Oppseeds"].groupby(subset["Year"]).mean().reset_index()
    #add team name in df
    totalseed["Team"] = team
    #Get the average
    teamseed.append(totalseed)
    #add a list containing the team and avgseed to the list being used to make a df
dataframe = pd.concat(teamseed)
#make a dataframe from the populated list
bot10 = dataframe.sort_values(by="Oppseeds")[0:11]
#sort by value and get top 10
top10 = dataframe.sort_values(by="Oppseeds",ascending=False)[0:11]
#sort by value in opposite way and get bottom 10
print("Top10") #print ans
print(top10)#print ans
print("")#print ans
print("Bot10")#print ans
print(bot10)#print ans
"""
9.
Top10
   Year  Oppseeds            Team
0  1990  9.000000            UNLV
1  2013  8.500000      Louisville
0  2019  8.000000        Virginia
1  2008  8.000000          Kansas
0  2006  7.666667         Florida
0  1986  7.500000      Louisville
0  1999  7.500000     Connecticut
0  1994  7.333333        Arkansas
0  2000  7.166667     Michigan St
0  1987  7.000000         Indiana
1  2005  7.000000  North Carolina

Bot10
   Year  Oppseeds            Team
0  1985  3.333333       Villanova
3  2014  4.666667     Connecticut
1  2016  4.833333       Villanova
0  1993  5.500000  North Carolina
0  2003  5.666667        Syracuse
3  2017  5.666667  North Carolina
2  2009  5.833333  North Carolina
0  1989  6.000000        Michigan
0  2002  6.000000        Maryland
1  2007  6.000000         Florida
0  1996  6.000000        Kentucky
"""

## 10. Determine the 2019 champion.
lastgame = ncaa[(ncaa["Region Name"] == "Championship") & (ncaa["Year"] == 2019)]
#subset teh championship game for 2019
winner = np.where(lastgame["Score"] > lastgame["Score.1"], lastgame["Team"], lastgame["Team.1"])
#See who the winner is by comparing the scores
print("The 2019 NCAA Champion is: ", winner[0], "!")
#print the winner which we already know is the answer <3
"""
10.
ans = 
The 2019 NCAA Champion is:  Virginia !
"""
