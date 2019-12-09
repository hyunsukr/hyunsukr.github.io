data trucking;
infile '/folders/myshortcuts/SAS/Case Study2/TRUCKING.txt' dlm='09'X firstobs=2;  
input PRICPTM DISTANCE WEIGHT PCTLOAD ORIGIN $ MARKET $ DEREG $ CARRIER $ PRODUCT LNPRICE
;
run;

data trucking4;
infile '/folders/myshortcuts/SAS/Case Study2/TRUCKING4.txt' dlm='09'X firstobs=2;  
input PRICPTM DISTANCE WEIGHT PCTLOAD ORIGIN $ MARKET $ DEREG $ CARRIER $ PRODUCT LNPRICE
;
run;

data truckingcase;
set trucking4;
dumba = 0; 
dumbb = 0; 
dumbc = 0;
dumbdereg=0;
dumbmia =0;
if CARRIER = "A" then dumba = 1; 
if CARRIER = "B" then dumbb = 1; 
if CARRIER = "C" then dumbc = 1; 
if DEREG = "YES" then dumbdereg=1;
if ORIGIN = "MIA" then dumbmia=1;
carAdistance = dumba*DISTANCE; 
carBdistance = dumbb*DISTANCE;
carCdistance = dumbc*DISTANCE;

carAweight = dumba*WEIGHT; 
carBweight = dumbb*WEIGHT;
carCweight = dumbc*WEIGHT;
carA2weight = dumba*WEIGHT*WEIGHT;
carB2weight = dumbb*WEIGHT*WEIGHT;
carC2weight = dumbc*WEIGHT*WEIGHT;

weightdistanceA = dumba*WEIGHT*DISTANCE;
weightdistanceB = dumbb*WEIGHT*DISTANCE;
weightdistanceC = dumbc*WEIGHT*DISTANCE;

weightdist= DISTANCE*WEIGHT;

distsqr= DISTANCE * DISTANCE;
weightsqred=WEIGHT*WEIGHT;

deregdist=DISTANCE*dumbdereg;
distorg=DISTANCE * dumbmia;

weightdereg=WEIGHT*dumbdereg;
weightmia = WEIGHT * dumbmia;

distweightdreg= WEIGHT * DISTANCE * dumbdereg;
distweightmia= DISTANCE * WEIGHT * dumbmia;
run;

*significant ----;
*Complete model THIS ONE is significant;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc / clb;
run;

*Calculate the partial F statistic;
data partialFtest9;
Fstat = ((57.75460	- 56.63946)/(3))/(56.63946/(448 -19 -1));
pvalue = SDF('F',Fstat,3 ,448-19-1);
Fcritical = quantile('F',.95,3 ,448-19-1);
run;
proc print data=partialFtest9;
run;

*Complete model THIS ONE doesn't workkkkkkkkkkk;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight carAdistance carBdistance carCdistance/ clb;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;

*Calculate the partial F statistic;
data partialFtest9dash1234;
Fstat = ((56.63946	- 56.60992)/(3))/(56.60992/(448 -21 -1));
pvalue = SDF('F',Fstat,3 ,448-21-1);
Fcritical = quantile('F',.95,3 ,448-21-1);
run;
proc print data=partialFtest9dash1234;
run;

*Complete model THIS ONE doesn't workkkkkkkkkkk;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight carA2weight carB2weight carC2weight/ clb;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;

*Calculate the partial F statistic;
data partialFtest9dash123456;
Fstat = ((56.63946	- 56.52610)/(3))/(56.52610/(448 -22 -1));
pvalue = SDF('F',Fstat,3 ,448-22-1);
Fcritical = quantile('F',.95,3 ,448-22-1);
run;
proc print data=partialFtest9dash123456;
run;


*Complete model THIS ONE doesn't workkkkkkkkkkk;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight weightdistanceA weightdistanceB weightdistanceC/ clb;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;

*Calculate the partial F statistic;
data partialFtest9dash12345678;
Fstat = ((59.20243	- 58.75117)/(3))/(58.75117/(448 -22 -1));
pvalue = SDF('F',Fstat,3 ,448-22-1);
Fcritical = quantile('F',.95,3 ,448-22-1);
run;
proc print data=partialFtest9dash12345678;
run;

*Complete model THIS ONE doesn't workkkkkkkkkkk;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight carA2weight carB2weight carC2weight/ clb;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightdreg distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;

*Calculate the partial F statistic;
data partialFtest9dash12345678;
Fstat = ((59.20243	- 59.07677)/(3))/(59.07677/(448 -22 -1));
pvalue = SDF('F',Fstat,3 ,448-22-1);
Fcritical = quantile('F',.95,3 ,448-22-1);
run;
proc print data=partialFtest9dash12345678;
run;

*Complete model to test interactio of A and distance;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist 
distsqr weightsqred dumbdereg dumbmia deregdist 
distorg weightdereg weightmia distweightdreg 
distweightmia dumba dumbb dumbc / clb;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist 
distsqr weightsqred dumbdereg dumbmia deregdist 
distorg weightdereg weightmia distweightdreg 
distweightmia / clb;
run;

*Calculate the partial F statistic;
data partialFtest;
Fstat = ((72.23628 -57.75460)/(3))/(57.75460/(448 -16 -1));
pvalue = SDF('F',Fstat,3 ,448-16-1);
Fcritical = quantile('F',.95,3 ,448-16-1);
run;

proc print data=partialFtest;
run;

*Lets make model better;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg distweightdreg dumbmia deregdist distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;
*take out distweightdreg;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;
*take out weightsqred;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;
*take out deregdist;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
dumbdereg dumbmia distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;
*take out weightdereg;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
dumbdereg dumbmia distorg weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;



*COMPARE MSE;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
weightsqred dumbdereg distweightdreg dumbmia deregdist distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;

proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT weightdist distsqr 
dumbdereg dumbmia distorg weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;



*take out weightsqred now;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT distsqr 
dumbdereg dumbmia deregdist distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;
*take out deregdist;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT distsqr 
dumbdereg dumbmia distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;
*take out deregdist;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT distsqr 
dumbdereg dumbmia distorg weightdereg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;
*take out weightdereg;
proc reg data=truckingcase plots=none;
model LNPRICE = DISTANCE WEIGHT distsqr 
dumbdereg dumbmia distorg 
weightmia distweightmia dumba dumbb dumbc 
carAweight carBweight carCweight/ clb;
run;