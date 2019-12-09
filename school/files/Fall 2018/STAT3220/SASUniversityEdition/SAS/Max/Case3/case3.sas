data calirain;
infile '/folders/myshortcuts/SAS/Case3/CALIRAIN.txt' dlm='09'X firstobs=2;
input Station   Name $   Precip   Altitude   Latitude   Distance   Shadow $;
run;

data calirain1; 
set calirain; 
Shadowdum = 0; 
if Shadow = 'L' then shadowdum = 1; 
run; 


proc reg data=calirain1 plots=none;
model precip = altitude latitude distance shadowdum;
run;

proc reg data=calirain1 plots(label)=(cooksd rstudentbypredicted
rstudentbyleverage);
model precip = altitude latitude distance shadowdum / r influence;
run;

data teststat;
t=quantile('T',0.975,30-4-2);
run;
proc print data=teststat;
run;
** t= 2.06 --> use for Rstudent

** 19 and 29 student residual is greater than 2
** no outlier in x (leverage) 2(4+1)/30 = 0.33333
** 3, 10, 29 overall influence. 4/30 = 0.13333
** 19 Rstudent is greater than 2


** Leverage > 0.3333;
	** None;
	** obs 3
** Studentized Residual +-2  (this is y);
	** obs 19, 29;
	
** we must check the influence of each observation;
** Cooks Distance;
	** BOTH are influential;
** RStudent > 2.06;
	** BOTH are influential;

**takeout 29;
data caliraintakeout;
infile '/folders/myshortcuts/SAS/Case3/CALIRAINtakeout29.txt' dlm='09'X firstobs=2;
input Station   Name $   Precip   Altitude   Latitude   Distance   Shadow $;
run;
data caliraintakeout12; 
set caliraintakeout; 
Shadowdum = 0; 
if Shadow = 'L' then shadowdum = 1; 
run; 

proc reg data=caliraintakeout12 plots(label)=(cooksd rstudentbypredicted
rstudentbyleverage);
model precip = altitude latitude distance shadowdum / r influence;
run;
** take out 29 and 19;
data caliraintakeout19;
infile '/folders/myshortcuts/SAS/Case3/CALIRAINtakeout2919.txt' dlm='09'X firstobs=2;
input Station   Name $   Precip   Altitude   Latitude   Distance   Shadow $;
run;
data caliraintakeout1234; 
set caliraintakeout19; 
Shadowdum = 0; 
if Shadow = 'L' then shadowdum = 1; 
run; 

proc reg data=caliraintakeout1234 plots(label)=(cooksd rstudentbypredicted
rstudentbyleverage);
model precip = altitude latitude distance shadowdum / r influence;
run;

**interaction x2;
data calirain2; 
set calirain; 
Shadowdum = 0; 
if Shadow = 'L' then shadowdum = 1; 
latalt= latitude*altitude;
latdist= latitude*distance;
latshadow= latitude*shadowdum;
run; 

proc reg data=calirain2 plots=none;
model precip = altitude latitude distance shadowdum latalt latdist latshadow;
run;

proc reg data=calirain2 plots(label)=(cooksd rstudentbypredicted
rstudentbyleverage);
model precip = altitude latitude distance shadowdum latalt latdist latshadow / r influence;
run;

data teststat;
t=quantile('T',0.975,30-7-2);
run;
proc print data=teststat;
run;


* Transformation of dependent variable; 
data calirain3;
set calirain2;
sqrtprecip=precip**.5;
run;

*Residual Analysis of transformed model; 
proc reg data=calirain3 plots(only)=(residualbypredicted residualplot qqplot 
residualhistogram);
model sqrtprecip = altitude latitude distance shadowdum latalt latdist latshadow ;
Run;


** t= 2.07
** 9 and 29 student residual is greater than 2
** 29 outlier in x (leverage) 2(7+1)/30 = 0.533333
** 1, 9, 19, 29 overall influence. 4/30 = 0.13333
** 1, 6, 29 Rstudent is greater than 2

** Leverage > 0.533333;
	** None;
** Studentized Residual +-2  (this is y);
	** obs 19, 29;
	
** we must check the influence of each observation;
** Cooks Distance (0.13333);
	** BOTH are influential;
** RStudent > 2.07;
	** BOTH are influential;