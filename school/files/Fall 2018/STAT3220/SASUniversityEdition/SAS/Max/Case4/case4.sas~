data score;
infile '/folders/myshortcuts/SAS/Case4/cohortscore1.csv' dlm=',' firstobs=2;
input OPEID	State $ Type Num Denom Drate Region;
run;

data score2;
 set score;
where Drate ne . ;
run;

data score3;
set score2;
if Type ='5' then Type ='4';
if Type ='6' then Type ='4';
if Type ='7' then Type ='4';
run;

proc sort data=score3;
by Type;
run;

proc surveyselect data= score3 method=srs n=50 seed=540 out=frontrow;
strata Type;
run; 

proc sort data = frontrow;
by Type;
run;

proc print data = frontrow;
run;

proc sgplot data=frontrow;
   title 'By group';
   scatter x=Type y=Drate;
run;
*check;

data frontrow2;
set frontrow;
sqrt = sqrt(drate);
run;

data frontrow3;
set frontrow;
ln = log(drate);
run;

*sqrt;
proc sgplot data=frontrow2;
scatter x=Type y=sqrt;
run;

proc sgplot data=frontrow2;
	vline Type /response=sqrt stat=mean markers datalabel;
run;

proc sgplot data=frontrow2;
vbox sqrt/ category=Type;
run;

proc sgpanel data=frontrow2;
panelby type;
histogram sqrt;
density sqrt /type=normal;
run;
proc sgplot data=frontrow2;
histogram sqrt;
density sqrt /type=normal;
run;

*endsqrt;

*ln;
proc sgplot data=frontrow3;
scatter x=Type y=ln;
run;

proc sgplot data=frontrow3;
	vline Type /response=ln stat=mean markers datalabel;
run;

proc sgplot data=frontrow3;
vbox ln/ category=Type;
run;

proc sgpanel data=frontrow3;
panelby type;
histogram ln;
density ln /type=normal;
run;
proc sgplot data=frontrow3;
histogram ln;
density ln /type=normal;
run;


*endln;
proc sgplot data=frontrow;
scatter x=Type y=Drate;
run;

proc sgplot data=frontrow;
	vline Type /response=Drate stat=mean markers datalabel;
run;

proc sgplot data=frontrow;
vbox Drate/ category=Type;
run;
*check assumption;
proc sgpanel data=frontrow;
panelby type;
histogram drate;
density drate /type=normal;
run;

*There are too few of observations, let's look at all of the data;

proc sgplot data=frontrow;
histogram drate;
density drate /type=normal;
run;

*non normal we must do levene terst;

proc anova data=frontrow;
class type;
model drate=type;
means type/ hovtest=levene(type=abs);
run;

proc anova data=frontrow2;
class type;
model sqrt=type;
means type/ hovtest=levene(type=abs);
run;


data finscore;
set frontrow;
dumb2 = 0;
dumb3 = 0;
dumb4 = 0;
if Type ='2' then dumb2 =1;
if Type ='3' then dumb3 =1;
if Type ='4' then dumb4 =1;
run;

proc reg data=finscore plots=none;
model drate=dumb2 dumb3 dumb4;
test dumb2,dumb3, dumb4;
run;

*Computation method;
proc anova data=frontrow;
class type;
model drate=type;
run;

*trans;

data finscore2;
set frontrow2;
dumb2 = 0;
dumb3 = 0;
dumb4 = 0;
if Type ='2' then dumb2 =1;
if Type ='3' then dumb3 =1;
if Type ='4' then dumb4 =1;
run;

proc reg data=finscore2 plots=none;
model sqrt=dumb2 dumb3 dumb4;
test dumb2,dumb3, dumb4;
run;

*Computation method;
proc anova data=frontrow3;
class type;
model ln=type;
means type/ tukey cldiff lines alpha=0.05;
run;

proc anova data=frontrow2;
class type;
model drate=type;
means type/ tukey cldiff lines alpha=0.05 ;
run;

proc anova data=frontrow;
class type;
model drate=type;
means type/ tukey cldiff lines alpha=0.05;
run;


