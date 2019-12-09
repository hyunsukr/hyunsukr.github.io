data tires2;
infile '/folders/myshortcuts/SAS/HW3/TIRES2.txt' dlm='09'X firstobs=2;
input xpsi yths;
run;

proc univariate data=tires2;
var xpsi;
run;

data tires3;
set tires2;
tires2lsq = xpsi ** 2;
u = (xpsi - 33)/2.16;
u2 = u**2;
run;

proc print data=tires3;
run;

proc corr data=tires3;
run;


proc reg data=tires3 plots=none;
model yths = u u2;
run;

data flag;
infile '/folders/myshortcuts/SAS/Max/HW3/FLAG2.txt' dlm='09'X firstobs=2;
input Lowbid dottest lberation status district numids daysest rdlngth pctasph pctbase pctexcav pctmobil pctstruc pcttraf subcount;
run;

data flag2;
set flag;
distdum2 = 0; 
distdum3 = 0;
distdum4 = 0;
distdum5 = 0;
if district = 2 then distdum2 = 1; 
if district = 3 then distdum3 = 1; 
if district = 4 then distdum4 = 1;
if district = 5 then distdum5 = 1;
run;
 

proc reg data=flag2;
model Lowbid = distdum2 distdum3 distdum4 distdum5 dottest status numids daysest rdlngth pctasph pctbase pctexcav/ 
selection = stepwise SLentry=0.10 SLstay=0.10; 
run;

data flag4;
infile '/folders/myshortcuts/SAS/Max/HW3/FLAG2.txt' dlm='09'X firstobs=2;
input LOWBID DOTEST LBERATIO STATUS DISTRICT NUMIDS DAYSEST RDLNGTH PCTASPH PCTBASE PCTEXCAV PCTMOBIL PCTSTRUC PCTTRAF SUBCONT;
run;


data flag5; 
set flag4; 
districdum1 = 0; 
districdum2 = 0;
districdum3 = 0;
districdum4 = 0;

if DISTRICT = 1 then districdum1 = 1;
if DISTRICT = 2 then districdum2 = 1;
if DISTRICT = 3 then districdum3 = 1;
if DISTRICT = 4 then districdum4 = 1; 

run; 

proc reg data=flag5 plots=none;
model LOWBID = DOTEST STATUS districdum1 districdum2 districdum3 districdum4 NUMIDS DAYSEST RDLNGTH PCTASPH PCTBASE PCTEXCAV PCTMOBIL PCTSTRUC PCTTRAF SUBCONT/ 
selection=stepwise SLentry=0.10 SLstay=0.10 details; 

run;
