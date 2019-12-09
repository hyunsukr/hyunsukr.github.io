proc import datafile='/folders/myshortcuts/SAS/Jenny/P1/World Happiness Report 2017 - Sheet1.csv'
out=world_happiness
dbms=CSV
;
run;

*scatterplots;
proc sgplot data=world_happiness;
scatter y=rank x=generosity;
run;

proc reg data=world_happiness plots=none;
model rank = generosity;
run;

proc sgplot data=world_happiness;
vline hemisphere / response=rank stat=mean markers datalabel;
run;

proc sgplot data=world_happiness;
vline developed / response=rank stat=mean markers datalabel;
run;

proc sgplot data=world_happiness;
vline trust / response=rank stat=mean markers datalabel;
run;

* dummy variables;
data whhemispheredum; 
set worldhappiness; 
hemisdum1 = 0; 
if Hemisphere = 'East' then hemisdum1 = 1; else hemisdum1=0;
run; 

proc reg data=whhemispheredum plots=none;
model Score = hemisdum1 ;
run;

data developdum;
set worldhappiness;
developdum1 = 0;
if Developed ='Yes' then developdum1 = 1; else developdum1 = 0;
run;

proc reg data=developdum plots=none;
model Score = developdum1;
run;

data trustdum;
set worldhappiness;
trustdum1 = 0;
trustdum2 = 0;
if Trust = 'High' then trustdum1 = 1; else trustdum1 = 0;
if Trust = 'Neutral' then trustdum2 = 1; else trustdum2 = 0;
run;

proc reg data=trustdum plots=none;
model Score = trustdum1 trustdum2;
run;

