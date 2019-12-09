##
## File: exam02.py (STAT 3250)
## Topic: Exam 2
## Max Ryoo

##  As discussed in class, Exam 2 will be fairly close in form to assignments:
##  there is no "in-class" or timed portion, and you are welcome to talk with
##  other students about solution strategies.  Two major differences from 
##  assignments:
##
##  (1) Course assistants only will provide help with code debugging but will
##      not provide a lot of help with code strategy.
##  (2) Grading will be stricter than with assignments.  In particular, the
##      code efficiency and elegance will be considered in grading to a 
##      greater degree than on assignments.  Also taken into account will be
##      using coding approaches covered in class, rather than something 
##      found online or in another course.
##
##  Grading of Exam 2: 5 questions will be selected for scoring from 0-5,
##  and 5 points will be added for overall completeness, for a total of 30.

##  Note: There is no blanket prohibition on the use of loops, but loops can
##  be inefficient and inelegant so excessive use when non-loop options exist
##  is likely to result in score reductions.  (The same goes for reading in 
##  data.  You should not do that more than once.)

##  The exam is due by Thursday March 28 at 11:30pm.  Exams marked late by
##  Collab will receive a 2 point deduction.  No exams may be submitted after
##  Friday, March 29 at 11:30am.

##  This exam requires the data file 'airline-stats.txt'.  This file contains
##  over 50,000 records of aggregated flight information, organized by airline, 
##  airport, and month.  The first record is shown below.

# =============================================================================
# airport
#     code: ATL 
#     name: Atlanta GA: Hartsfield-Jackson Atlanta International
# flights 
#     cancelled: 5 
#     on time: 561 
#     total: 752 
#     delayed: 186 
#     diverted: 0
# number of delays 
#     late aircraft: 18 
#     weather: 28 
#     security: 2 
#     national aviation system: 105 
#     carrier: 34
# minutes delayed 
#     late aircraft: 1269 
#     weather: 1722 
#     carrier: 1367 
#     security: 139 
#     total: 8314 
#     national aviation system: 3817
# dates
#     label: 2003/6 
#     year: 2003 
#     month: 6
# carrier
#     code: AA 
#     name: American Airlines Inc.
# =============================================================================
import pandas as pd
import numpy as np
lines = open('airline-stats.txt').read().split('##########')
#split lines by hashtag
lines = pd.Series(lines)
#make the lines into a series
testing = lines.str.replace(" ","").replace("\r","").replace("","").str.split("\n")
#replace new line and spaces with nothing
totallist = []
#list to add later to dataframe
for thing in testing:
    #for every line
    listofitems = thing[0:-2]
    #get the list of items
    addlist = []
    #temp list
    count = 0
    #counter variable
    for items in listofitems:
        #for everything in the list of items
        if count == 1 and ":" in items:
            #if the count is 1 and there is a colon
            name = items.split(":")[1] + ': ' + items.split(":")[2]
            #get the name
            addlist.append(name)
            #add it the the temp list
            count = count + 1
            #increase counter
        elif ":" in items:
            #if there is a colon in item and the counter is not one
            addlist.append(items.split(":")[1])
            #add item split second index into addlist (this is the addition of content)
            count = count + 1
            #increase by one to not confuse counter logic
    if len(addlist) != 0:
        #if there is nothing in addlist
        totallist.append(addlist)
        #append the empty list
totallist[0]
df = pd.DataFrame(totallist,columns=['acode',
                                     'aname', 
                                     'fcancelled', 
                                     'fontime', 
                                     'ftotal', 
                                     'fdelayed', 
                                     'fdiverted', 
                                     'ndlateaircraft', 
                                     'ndweather', 
                                     'ndsecurity', 
                                     'ndnationalaviationsystem', 
                                     'ndcarrier',
                                     'mdlateaircraft', 
                                     'mdweather',
                                     'mdcarrier',
                                     'mdsecurity', 
                                     'mdtotal', 
                                     'mdnationalaviationsystem', 
                                     'dlabel', 
                                     'dyear',
                                     'dmonth', 
                                     'ccode', 
                                     'cname'])
#make a dataframe based on list of items to add and the given column names in explanation above
## 1.  Give the total number of hours delayed for all flights in all records.
hours = df["mdtotal"].astype(int).sum()/60
#get the sum of minutes delayed total and divide by 60
print(hours)
#print the hours
"""
1.
ans = 9991285.583333334 hours
"""
## 2.  Which airlines appear in at least 1000 records?  Give a table of airline
##     names and number of records for each, in order of record count (largest
##     to smallest).

counts = df["cname"].groupby(df["cname"]).count().sort_values(ascending=False)
#count how many entries there are for the different names and sort the values
counts = counts[counts >=1000] #filter at least 1000 records
print(counts) #print counts
"""
2.
ans = 
cname
DeltaAirLinesInc.            4370
AmericanAirlinesInc.         4296
UnitedAirLinesInc.           4219
USAirwaysInc.                3918
ExpressJetAirlinesInc.       3174
SouthwestAirlinesCo.         2899
JetBlueAirways               2857
FrontierAirlinesInc.         2821
ContinentalAirLinesInc.      2815
AirTranAirwaysCorporation    2801
AlaskaAirlinesInc.           2678
SkyWestAirlinesInc.          2621
AmericanEagleAirlinesInc.    2379
NorthwestAirlinesInc.        2288
MesaAirlinesInc.             1682
ComairInc.                   1671
AtlanticSoutheastAirlines    1460
HawaiianAirlinesInc.         1073
Name: cname, dtype: int64
"""
## 3.  For some reason, the entry under 'flights/delayed' is not always the same
##     as the total of the entries under 'number of delays'.  (The reason for
##     this is not clear.)  Determine the percentage of records for which 
##     these two values are different.
total = df["ndlateaircraft"].astype(int) + df["ndweather"].astype(int) + df["ndsecurity"].astype(int) + df["ndnationalaviationsystem"].astype(int)+ df["ndcarrier"].astype(int)
#add all the reasons for delayed together
subset = total[df["fdelayed"].astype(int) != total]
#see which do not equal the fdelayed column
percentage = len(subset) * 100 /len(total)
#get the percentage
print(percentage) #print percentage
"""
3.
ans = 
29.283690963286617
"""

## 4.  Determine the number of records for which the number of delays due to
##     late aircraft exceeds the number of delays due to weather.
subset = df[df["ndlateaircraft"].astype(int) > df["ndweather"].astype(int)]
#subset the rows which ndlateaircraft is greater than delay in weather
number = len(subset)
#get the len of that subset
print(number)
#print the number
"""
4.
ans = 46890
"""
## 5.  Find the top-10 airports in terms of the total number of minutes delayed.
##     Give a table of the airport names and the total minutes delayed, in 
##     order from largest to smallest.
ans = df["mdtotal"].astype(int).groupby(df["aname"]).sum().sort_values(ascending=False)[0:10]
#group the mdtotal and sum it by the airport names and sort the values in descending order then subset 10 entries
print(ans) #print answer variable
"""
5.
ans = 
aname
ChicagoIL: ChicagoO'HareInternational                66079561
AtlantaGA: Hartsfield-JacksonAtlantaInternational    61818488
Dallas/FortWorthTX: Dallas/FortWorthInternational    39246534
NewarkNJ: NewarkLibertyInternational                 33306693
SanFranciscoCA: SanFranciscoInternational            28980270
DenverCO: DenverInternational                        27020884
LosAngelesCA: LosAngelesInternational                26897269
HoustonTX: GeorgeBushIntercontinental/Houston        24121262
NewYorkNY: LaGuardia                                 22335295
NewYorkNY: JohnF.KennedyInternational                19985703
"""

## 6.  Find the top-10 airports in terms of percentage of on time flights.
##     Give a table of the airport names and percentages, in order from 
##     largest to smallest.
ontime = df["fontime"].astype(int).groupby(df["aname"]).sum()
#group the fontime and sum it by group
ftotal = df["ftotal"].astype(int).groupby(df["aname"]).sum()
#group the ftotal and sum it by group
divide = ontime/ftotal * 100
#divide the ontime by total and multiply by 100 to get percentages
ans2 = divide.sort_values(ascending=False)[0:10]
#sor the values and subset the top 10 airports
print(ans2) #print ans variable
"""
6.
ans = 
aname
SaltLakeCityUT: SaltLakeCityInternational                         84.249328
PhoenixAZ: PhoenixSkyHarborInternational                          82.423895
PortlandOR: PortlandInternational                                 80.759415
MinneapolisMN: Minneapolis-StPaulInternational                    80.342827
ChicagoIL: ChicagoMidwayInternational                             80.317165
CharlotteNC: CharlotteDouglasInternational                        80.310017
BaltimoreMD: Baltimore/WashingtonInternationalThurgoodMarshall    80.268309
DenverCO: DenverInternational                                     80.236443
DetroitMI: DetroitMetroWayneCounty                                80.182134
HoustonTX: GeorgeBushIntercontinental/Houston                     80.117228
"""
## 7.  Find the top-10 airlines in terms of percentage of on time flights.
##     Give a table of the airline names and percentages, in order from 
##     largest to smallest.
ontime = df["fontime"].astype(int).groupby(df["cname"]).sum()
#group the fontime by cname this time and sum
ftotal = df["ftotal"].astype(int).groupby(df["cname"]).sum()
#group the ftotal by cname and then sum
divide = ontime/ftotal * 100
#get the percentage
ans2 = divide.sort_values(ascending=False)[0:10]
#subset the top 10
print(ans2)
#print the answer variable
"""
7. 
ans = 
cname
EndeavorAirInc.            84.050792
AlaskaAirlinesInc.         81.888334
VirginAmerica              81.492009
AlohaAirlinesInc.          80.934150
DeltaAirLinesInc.          80.411719
SkyWestAirlinesInc.        80.102370
SouthwestAirlinesCo.       80.061699
AmericaWestAirlinesInc.    79.373011
HawaiianAirlinesInc.       79.308415
USAirwaysInc.              78.974549
"""

## 8.  Determine the average length (in minutes) of a weather-related delay.

minutuesweather = df["mdweather"].astype(int).mean()
#get the average of minutes delayed by weather
print(minutuesweather) #print the average
"""
8.
ans = 
512.2644548534612 mins
"""
## 9.  For each month, determine which airport had the highest percentage
##     of delays.  Give a table listing the month number, the airport name,
##     and the percentage.
l = [] #list to make df later
df["percentagedelay"] = (df["fdelayed"].astype(int) / df["ftotal"].astype(int))*100
#make a column called percentage delayed which divides fdelayed by ftotal and multiply by 100
for i in range(1,13):
    #for i range from 1 to 12
    sub = df[df["dmonth"] == str(i)]
    #subset the dataframe for the month
    delay = sub["fdelayed"].astype(int).groupby(sub["aname"]).sum()
    #sum the fdelayed by aname groups
    total = sub["ftotal"].astype(int).groupby(sub["aname"]).sum()
    #sum the ftotal by aname groups
    sub = (delay/total * 100)
    #get the percentages
    sub = sub.sort_values(ascending=False).head(1).reset_index()
    #sort the values and get the top row both name and percentage by reset index
    sub = [i,sub["aname"][0], sub[0][0]]
    #make a list that has month cname and percentage
    l.append(sub)
    #add that list to the list for df
ans = pd.DataFrame(l,columns=["month",'aname','percentagedelay'])
#get the list after all the months and make into dataframe
print(ans) #print ans
"""
9.
ans = 
    month                                  aname  percentagedelay
0       1  ChicagoIL: ChicagoO'HareInternational        27.392193
1       2   NewarkNJ: NewarkLibertyInternational        27.909382
2       3   NewarkNJ: NewarkLibertyInternational        31.613341
3       4   NewarkNJ: NewarkLibertyInternational        30.250067
4       5   NewarkNJ: NewarkLibertyInternational        30.339172
5       6   NewarkNJ: NewarkLibertyInternational        32.249598
6       7   NewarkNJ: NewarkLibertyInternational        31.445250
7       8   NewarkNJ: NewarkLibertyInternational        27.601543
8       9   NewarkNJ: NewarkLibertyInternational        23.935120
9      10   NewarkNJ: NewarkLibertyInternational        26.140379
10     11   NewarkNJ: NewarkLibertyInternational        26.961231
11     12   NewarkNJ: NewarkLibertyInternational        33.508850
"""

## 10. For each year, determine the percentage of flights delayed by weather.
df["totalnumdelayed"] = df["ndlateaircraft"].astype(int) + df["ndweather"].astype(int) + df["ndsecurity"].astype(int) + df["ndnationalaviationsystem"].astype(int)+ df["ndcarrier"].astype(int)
#add all the number of delays for all reasons
total = df["totalnumdelayed"].astype(int).groupby(df["dyear"].astype(int)).sum()
#total number delayed by year
weather = df["ndweather"].astype(int).groupby(df["dyear"].astype(int)).sum()
#number delayed by weather by year
ans = weather/total * 100
#get the percentages
ans = ans.reset_index()
#reset the indexs for the dataframe
ans = ans.rename(columns={"dyear":"Year",0:"Percentage"})
##rename the columns
ans = ans.sort_values(["Year"])
#sort by years
print(ans) #print ans
"""
10.
ans = 
    Year  Percentage
0   2003    3.768937
1   2004    4.029022
2   2005    3.577066
3   2006    3.445933
4   2007    3.500137
5   2008    3.236351
6   2009    3.182635
7   2010    2.926723
8   2011    2.711382
9   2012    2.824133
10  2013    2.772830
11  2014    2.873415
12  2015    3.305040
13  2016    3.123764
"""

## 11. Find the top-10 airports in terms of average length (in minutes) of 
##     security-related flight delays.  Give a table listing the airport name 
##     and average, sorted from largest to smallest.
groups = df["mdsecurity"].astype(int).groupby(df["aname"]).mean().sort_values(ascending=False)[0:10]
#minutes delayed by security and group it by aname and then take the mean and sort
print(groups) #print the groups
"""
11.
ans = 
aname
LosAngelesCA: LosAngelesInternational                31.171882
PhoenixAZ: PhoenixSkyHarborInternational             28.088348
HoustonTX: GeorgeBushIntercontinental/Houston        27.581944
AtlantaGA: Hartsfield-JacksonAtlantaInternational    26.835020
ChicagoIL: ChicagoMidwayInternational                25.979872
NewYorkNY: JohnF.KennedyInternational                25.131987
ChicagoIL: ChicagoO'HareInternational                24.656299
LasVegasNV: McCarranInternational                    21.649906
SeattleWA: Seattle/TacomaInternational               21.353691
Dallas/FortWorthTX: Dallas/FortWorthInternational    21.238894
"""

## 12. Determine the top-10 airport/airline combinations that had the lowest
##     percentage of delayed flights.  Give a table listing the airport name,
##     the airline name, and the percentage of delayed flights, sorted in
##     order (smallest to largest) of percentage of delays.
df["combo"] = df["aname"] + " and " + df["cname"]
#make a combo column that combines airline name with airline name
delayed = df["fdelayed"].astype(int).groupby(df["combo"]).sum()
#flights delayed added up by the combo
total = df["ftotal"].astype(int).groupby(df["combo"]).sum()
#flights total added up by combo
ans = (delayed/total*100).sort_values()[0:10]
#get the percentags
print(ans) #print the percentaga
"""
12.
ans = 
combo
LasVegasNV: McCarranInternational and ComairInc.                                          0.000000
PhoenixAZ: PhoenixSkyHarborInternational and PinnacleAirlinesInc.                         0.000000
NewYorkNY: JohnF.KennedyInternational and AlaskaAirlinesInc.                              4.347826
SaltLakeCityUT: SaltLakeCityInternational and AlaskaAirlinesInc.                          8.567829
BaltimoreMD: Baltimore/WashingtonInternationalThurgoodMarshall and AlaskaAirlinesInc.     8.689024
FortLauderdaleFL: FortLauderdale-HollywoodInternational and EndeavorAirInc.               8.695652
FortLauderdaleFL: FortLauderdale-HollywoodInternational and SkyWestAirlinesInc.           9.090909
TampaFL: TampaInternational and SkyWestAirlinesInc.                                      10.000000
OrlandoFL: OrlandoInternational and VirginAmerica                                        10.635226
DetroitMI: DetroitMetroWayneCounty and EndeavorAirInc.                                   10.828148
"""
