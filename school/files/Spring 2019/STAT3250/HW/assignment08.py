## Assignment08
## Max Ryoo


#### Searching directories

import glob # 'glob' searches for files
import pandas as pd #pandas

# Reminder: Change to directory 'Stocks'

# '*.csv' selects files ending in '.csv'
filelist = glob.glob('*.csv') # 'glob.glob' is the directory search

# The above list allows us to iterate through the files to read
# them in, one at a time.
stocklist = [] #list of stocks
for f in filelist: #for all the files
    df = pd.read_csv(f) #read in 
    df["Name"] = f.split('.')[0] #split by .
    stocklist.append(df) #append to df
    print(df,"\n") #print it to check

# We can concatenate the dataframes into one large dataframe
df = pd.DataFrame() #large df
for f in filelist: #for every file
    newdf = pd.read_csv(f) #read csv
    df = pd.concat([df,newdf]) #add csv
list(df) #see the rows of df

#1
openmean = df["Open"].mean() #get the mean of open of all 
highmean = df["High"].mean() #get the mean of high for all
lowmean = df["Low"].mean() #get the mean of low for all
closemean = df["Close"].mean() #get the close mean for all
print("Mean open: " , openmean) #print ans
print("Mean High: " , highmean) #print ans
print("Mean Low: " , lowmean) #print ans
print("Mean close: ", closemean) #print ans
"""
1. 
ans = 
Mean open:  50.863852209060646
Mean High:  51.45941172575049
Mean Low:  50.25336771426306
Mean close:  50.876481580134694
"""

#2
l = [] #empty list
for frame in stocklist: #for frame in stocklist made before
    mean = frame["Close"].mean() #get each stocks mean for close
    name = frame["Name"].iloc[0] #get the name
    temp = [name, mean] #add the mean and name as a list to the empty list
    l.append(temp) # add teh list
topclose = pd.DataFrame(l, columns=['Name','Avg Closing Price']).sort_values(by = "Avg Closing Price", ascending=False)
#make a dataframe witht eh populated list then sort by the closing price
top5 = topclose[0:5] #get the top 5
bot5 = topclose[len(topclose)-5:len(topclose)] #Get eh bottom 5
print("Top5")  #print ans
print(top5)   #print ans
print("") #print ans
print("Bot5") #print ans
print(bot5)   #print ans
"""
2.
ans = 
Top5
     Name  Avg Closing Price
129   CME         253.956017
123   AZO         235.951950
77   AMZN         185.140534
289   BLK         164.069088
163    GS         139.146781

Bot5
     Name  Avg Closing Price
247  HBAN          13.697483
131  ETFC          12.808103
260   XRX          11.291864
41      F          11.174158
9     FTR           8.969515
"""

#3
ldtd = [] #emtpy list
for frame in stocklist: #for every stock
    mean = (frame["High"] - frame["Low"]).mean() #get the diffrence of high and low and get mean
    name = frame["Name"].iloc[0] #get the name
    temp = [name, mean] #make into small list
    ldtd.append(temp) #add it to the big list
topclose = pd.DataFrame(ldtd, columns=['Name','Avg dtd Price']).sort_values(by = "Avg dtd Price", ascending=False)
#make the list into a dataframe and srot by value
top5 = topclose[0:5] #get the top 5
bot5 = topclose[len(topclose)-5:len(topclose)] #get the bottom 5
print("Top5") #print ans
print(top5)   #print ans
print("") #print ans
print("Bot5") #print ans
print(bot5)   #print ans

"""
3.
ans = 
Top5
     Name  Avg dtd Price
129   CME       7.697287
77   AMZN       4.691407
289   BLK       4.470693
123   AZO       4.330294
135   ICE       4.056189

Bot5
     Name  Avg dtd Price
245    NI       0.363250
247  HBAN       0.343893
41      F       0.323567
260   XRX       0.308743
9     FTR       0.205275
"""

#4
lrv = [] #empty list
for frame in stocklist: #for every stock
    difference = frame["High"] - frame["Low"] #get difference
    openclose = frame["Open"] + frame["Close"] #ge open + clsoe
    mean = difference / (openclose * 0.5) #the equation for vol
    mean = mean.mean() #get the mean
    name = frame["Name"].iloc[0] #get the name
    temp = [name, mean] #make a list
    lrv.append(temp) #add to empty list
topclose = pd.DataFrame(lrv, columns=['Name','Avg relative volatility']).sort_values(by = "Avg relative volatility", ascending=False)
#make into dataframe and sort by value
top5 = topclose[0:5]
#get the top 5
bot5 = topclose[len(topclose)-5:len(topclose)]
#get the bottom 5
print("Top5") #print ans
print(top5)   #print ans
print("") #print ans
print("Bot5") #print ans
print(bot5)   #print ans

"""
4.
ans = 
Top5
     Name  Avg relative volatility
198   AAL                 0.055533
240  LVLT                 0.054870
6    EQIX                 0.051295
219  REGN                 0.048172
131  ETFC                 0.045381

Bot5
    Name  Avg relative volatility
98   WEC                 0.015761
220   CL                 0.015521
242    K                 0.014992
74    PG                 0.014192
234  GIS                 0.013966
"""

#5
df5 = df #make a copy of df
df5["Datesdt"] = pd.to_datetime(df5["Date"])
#change into datetime
october = df5[(df5["Datesdt"].dt.year == 2008) & (df5["Datesdt"].dt.month == 10)]
#subset october of 2008
ans = october[["Date","Open","High","Low","Close","Volume"]].groupby(october["Datesdt"]).mean()
#get only date open high low clsoe volume by grouping by dates in october 2008
print(ans)  #print ans
"""
5.
ans = 
                 Open       High        Low      Close        Volume
Datesdt                                                             
2008-10-01  43.147874  44.089999  41.845493  43.095090  7.319004e+06
2008-10-02  43.033478  43.443991  40.642233  41.126958  9.555247e+06
2008-10-03  41.555534  42.923984  39.882176  40.264390  9.184641e+06
2008-10-06  39.408827  40.564248  36.730878  39.176739  1.176339e+07
2008-10-07  39.427268  40.293947  36.644575  36.933873  1.091851e+07
2008-10-08  36.106591  38.785221  35.062443  36.676517  1.378626e+07
2008-10-09  37.250109  38.002160  33.437178  33.848607  1.281094e+07
2008-10-10  32.581401  35.952582  30.432287  33.992102  1.820152e+07
2008-10-13  35.486543  38.041322  34.122389  37.548197  1.148344e+07
2008-10-14  38.581369  39.626962  35.513443  36.784888  1.240928e+07
2008-10-15  36.149596  36.757105  32.879340  33.197032  1.051697e+07
2008-10-16  33.485713  35.096629  31.415127  34.599193  1.258398e+07
2008-10-17  33.735344  36.184362  32.729962  34.400653  9.973754e+06
2008-10-20  34.989340  36.357728  33.968497  35.909339  7.657442e+06
2008-10-21  35.390477  36.344741  34.189521  34.665477  7.599813e+06
2008-10-22  33.751940  34.344688  31.386153  32.373295  9.425614e+06
2008-10-23  32.889517  33.987036  30.561443  32.516369  1.189890e+07
2008-10-24  30.046028  32.498308  29.403749  31.395146  9.726575e+06
2008-10-27  30.638140  31.924868  29.501411  29.877173  8.362392e+06
2008-10-28  30.860222  33.145389  29.345018  32.955575  1.091700e+07
2008-10-29  32.864871  34.887581  31.854395  33.179376  1.036944e+07
2008-10-30  34.273941  35.292079  32.884269  34.284817  8.928569e+06
2008-10-31  33.995771  35.761028  33.294631  34.976910  9.213693e+06
"""

#6.
df6 = df #make a copy of df
df6["Datesdt"] = pd.to_datetime(df6["Date"])
#make date col into datetime
df2011 = df6[(df6["Datesdt"].dt.year == 2011)]
#subset 2011 entries
difference = df2011["High"] - df2011["Low"]
#get the difference of high low
openclose = df2011["Open"] + df2011["Close"]
#get sum of open and close
df2011["Vol"] = (difference / (openclose * 0.5))
#equation for volatility
maxdate = df2011["Vol"].groupby(df2011["Datesdt"]).mean().sort_values(ascending=False)[0:1]
#get the max
print("Max") #print ans
print(maxdate) #print ans
mindate = df2011["Vol"].groupby(df2011["Datesdt"]).mean().sort_values()[0:1]
#get the min
print("Min") #print ans
print(mindate) #print ans
"""
6.
ans = 
Max
Datesdt
2011-08-08    0.073087
Name: Vol, dtype: float64

Min
Datesdt
2011-12-30    0.014162
Name: Vol, dtype: float64
"""

#7.
df7 = df
#make copy of df
days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
#make list of days
daysofweek = pd.DataFrame(days, columns=["Dayofweek"])
#make dataframe of the days of week
df7["Dayofweek"] = daysofweek.iloc[df7["Datesdt"].dt.weekday.tolist()]["Dayofweek"].tolist()
#find the correspoindnig value in the days list
df1112 = df7[(df7["Datesdt"].dt.year == 2011) | (df7["Datesdt"].dt.year == 2012) | (df7["Datesdt"].dt.year == 2010)]
#subset 2011 2012 and 2010
difference = df1112["High"] - df1112["Low"]
#get the difference of high and low
openclose = df1112["Open"] + df1112["Close"]    
#open + close
df1112["Vol"] = (difference / (openclose*0.5))    
#the equation for volatility
ans = df1112["Vol"].groupby(df1112["Dayofweek"]).mean()
#get the mean for dayfoweek for volatility
print(ans) #print ans
"""
7.
ans = 
Dayofweek
Friday       0.023018
Monday       0.022109
Thursday     0.024865
Tuesday      0.023836
Wednesday    0.023443
Name: Vol, dtype: float64
"""

#8.
listdf = [] #make empty dataframe
for frame in stocklist: #for all different stocks
    frame["Datesdt"] = pd.to_datetime(frame["Date"])
    #change to datetime
    subset2009 = frame[frame["Datesdt"].dt.year == 2009]
    #subset 2009
    subset2009["month"] = subset2009["Datesdt"].dt.month
    #get the monnth
    difference = subset2009["High"] - subset2009["Low"]
    #get the difference of high and low
    openclose = subset2009["Open"] + subset2009["Close"]
    #get the sum of open and close
    subset2009["Vol"] = difference / (openclose * 0.5)
    #equation of volatility
    means = subset2009["Vol"].groupby(subset2009["month"]).mean().reset_index()
    #group by month and get the avg vol then reset index
    means["Name"] = frame["Name"].iloc[0]
    #get the name of stock
    listdf.append(means)
    #add teh df into empty list
maxdf = pd.concat(listdf) #make the list into one big dataframe
ans = maxdf[maxdf.groupby('month')['Vol'].transform('max') == maxdf['Vol']].sort_values(by="month")
#get the row with the highest Vol for each month
print(ans)
"""
8.
ans = 
    month       Vol  Name
0       1  0.190686   GGP
1       2  0.275587  HBAN
2       3  0.241744   GGP
3       4  0.212291   GGP
4       5  0.187383   GGP
5       6  0.131522   GGP
6       7  0.121527   AIG
7       8  0.141233   AIG
8       9  0.103328   GGP
9      10  0.071610   AAL
10     11  0.089010   GGP
11     12  0.112847   GGP
"""

#9.
df9 = df #make a copy of df
df9["Openvol"] = df9["Open"] * df9["Volume"]
#numerator for open
df9["Highvol"] = df9["High"] * df9["Volume"]
#numerator for high
df9["Lowvol"] = df9["Low"] * df9["Volume"]
#numerator for low
df9["Closevol"] = df9["Close"] * df9["Volume"]
#numerator for close
df9["Datesdt"] = pd.to_datetime(df9["Date"])
#make date into date time
sub2013 = df9[(df9["Datesdt"].dt.year == 2013) & (df9["Datesdt"].dt.month == 1)]
#subset janurary 2013
openvol = sub2013["Openvol"].groupby(sub2013["Datesdt"]).sum() / sub2013["Volume"].groupby(sub2013["Datesdt"]).sum()
#get the python index
highvol = sub2013["Highvol"].groupby(sub2013["Datesdt"]).sum() / sub2013["Volume"].groupby(sub2013["Datesdt"]).sum()
#get the python index
lowvol = sub2013["Lowvol"].groupby(sub2013["Datesdt"]).sum() / sub2013["Volume"].groupby(sub2013["Datesdt"]).sum()
#get the python index
closevol = sub2013["Closevol"].groupby(sub2013["Datesdt"]).sum() / sub2013["Volume"].groupby(sub2013["Datesdt"]).sum()
#get the python index
dates = openvol.reset_index()["Datesdt"].tolist()
#make dates into list format
dictdf = {"Dates": dates,"Open" : openvol.tolist(),"High" : highvol.tolist(),"Low": lowvol.tolist(),"Close" : closevol.tolist()}
#make dictionary for df
final = pd.DataFrame(dictdf) #make df out of dictionary
print(final) #print answer
"""
9.
ans = 
        Dates       Open       High        Low      Close
0  2013-01-02  37.218240  37.669825  36.804244  37.394700
1  2013-01-03  36.683928  37.175883  36.309854  36.730561
2  2013-01-04  37.735301  38.197961  37.471489  37.969676
3  2013-01-07  39.433973  39.952425  39.087880  39.596959
4  2013-01-08  39.403554  39.748143  38.922081  39.354890
5  2013-01-09  35.033924  35.411876  34.651302  35.014333
6  2013-01-10  37.137210  37.527043  36.757483  37.295754
7  2013-01-11  37.932903  38.256677  37.579063  37.991448
8  2013-01-14  38.348330  38.759699  37.980530  38.388938
9  2013-01-15  38.323527  38.880771  38.003460  38.487561
10 2013-01-16  39.353471  39.731879  38.887220  39.347620
11 2013-01-17  35.884004  36.233690  35.551895  35.877188
12 2013-01-18  40.277388  40.652477  39.865453  40.376961
13 2013-01-22  40.567323  41.068261  40.241281  40.851074
14 2013-01-23  44.417554  45.121563  44.065735  44.770209
15 2013-01-24  48.814446  49.728573  48.237470  49.174833
16 2013-01-25  58.340138  62.089706  58.052795  61.453043
17 2013-01-28  50.844625  51.450083  49.590466  50.007070
18 2013-01-29  41.631649  42.499318  41.221507  42.174208
19 2013-01-30  45.212780  45.587135  44.354852  44.792994
20 2013-01-31  44.310451  45.061372  43.789490  44.518366
"""

#10.
df10 = df #make a copy of df
df10["Openvol"] = df10["Open"] * df10["Volume"]
#numerator for open
df10["Highvol"] = df10["High"] * df10["Volume"]
#numerator for high
df10["Lowvol"] = df10["Low"] * df10["Volume"]
#numerator for low
df10["Closevol"] = df10["Close"] * df10["Volume"]
#numerator for close
df10["Datesdt"] = pd.to_datetime(df9["Date"])
#make into datetimeobject
df10["YearMonth"] = df10["Datesdt"].dt.year.astype(str) + "-" + df10["Datesdt"].dt.month.astype(str)
#make date into date time
df20072012 = df10[(df10["Datesdt"].dt.year == 2007) | (df10["Datesdt"].dt.year == 2008) | (df10["Datesdt"].dt.year == 2009) | (df10["Datesdt"].dt.year == 2010) | (df10["Datesdt"].dt.year == 2011) | (df10["Datesdt"].dt.year == 2012)]
#subset janurary 2013
openvol = df20072012["Openvol"].groupby(df20072012["YearMonth"]).sum() / df20072012["Volume"].groupby(df20072012["YearMonth"]).sum()
#get the python index
highvol = df20072012["Highvol"].groupby(df20072012["YearMonth"]).sum() / df20072012["Volume"].groupby(df20072012["YearMonth"]).sum()
#get the python index
lowvol = df20072012["Lowvol"].groupby(df20072012["YearMonth"]).sum() / df20072012["Volume"].groupby(df20072012["YearMonth"]).sum()
#get the python index
closevol = df20072012["Closevol"].groupby(df20072012["YearMonth"]).sum() / df20072012["Volume"].groupby(df20072012["YearMonth"]).sum()
#get the python index
dates = openvol.reset_index()["YearMonth"].tolist()
#get the yearmonth
volume = df20072012["Volume"].groupby(df20072012["YearMonth"]).sum()
#get the volume
dictdf = {"Dates": dates,"Openvol" : openvol.tolist(),"Highvol" : highvol.tolist(),"Lowvol": lowvol.tolist(),"Closevol" : closevol.tolist()}
#make dictionary for df
final = pd.DataFrame(dictdf) #make df out of dictionary
difference = final["Highvol"] - final["Lowvol"]
#get the diff of high and low python index
openclose = final["Openvol"] + final["Closevol"]
#get the adddition of open and close
pythonindex = difference / (0.5 * openclose)
#get the average volality
final["PythonIndex"] = pythonindex
#make a new columns
sorteddf = final.sort_values(by="PythonIndex", ascending=False)[0:5]
#get the top 5
sorteddf["Year"] = sorteddf["Dates"].str.split("-").str[0]
#separate the year
sorteddf["Month"] = sorteddf["Dates"].str.split("-").str[1]
#separte the month
dictfinal = {"Year":sorteddf["Year"], "Month": sorteddf["Month"], "Volality":sorteddf["PythonIndex"]}
#make dictionary for df
ans = pd.DataFrame(dictfinal)
#make df
print(ans) #print answer
"""
10.
ans =
    Year Month  Volality
13  2008    10  0.105393
14  2008    11  0.085645
23  2008     9  0.074730
15  2008    12  0.067571
29  2009     3  0.066853
"""




