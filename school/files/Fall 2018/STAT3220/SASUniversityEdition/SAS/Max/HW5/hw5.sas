data life;
infile '/folders/myshortcuts/SAS/HW5/LIFEINS.txt' dlm='09'X firstobs=2;
input Year Policies;
run;

data life2;
 set life;
 time = Year - 1979;
run;

proc reg data=life2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model Policies = time/ r clb;
run;

data life3;
Policies = .;
time = 28;
run;

data life3_1;
Policies = .;
time = 29;
run;

* This is merging the two datasets together; 
data life3_2;
set life3 life3_1;
run;

data life3tot;
set life3_2 life2;
run;

proc reg data=life3tot plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model Policies = time/ r cli;
run;



data intrate;
infile '/folders/myshortcuts/SAS/HW5/INTRATE30.txt' dlm='09'X firstobs=2;
input Year rate;
run;

data intrate2;
set intrate;
time=Year - 1984;
run;

*Run the model as usual with time as the predictor;
proc reg data=intrate2 plots=none;
model rate = time;
run;

*QUESTION: Is there first-order autocorrelation in the errors?;
proc reg data=intrate2 plots = none;
model rate = time / dwprob;
run;

proc arima data=intrate2 plots=none; 
identify var=rate(1);
estimate p= 2;
run;

data intrate3;
set intrate2;
time=_n_;
run;

proc arima data=intrate3 plots=none; 
identify var=rate crosscor=(time) noprint;
estimate input=(time) p=(1);
run;

data growth;
input Hours Cells;
cards;
1 2
5 3
10 4
20 5
30 4
40 6
45 8
50 9
60 10
70 18
80 16
90 18
100 20
110 14
120 12
130 13
140 9
;
run;

proc sgplot data=growth;
scatter y=Cells x=Hours;
run;

data growth2;
 set growth;
 dum1 = 0;
 if Hours > 70 then dum1 = 1;
 diff = (Hours - 70)*dum1;
run;

proc reg data = growth2 plots=none;
model Cells = Hours diff dum1;
run;

proc reg data=growth2 plots=none;
model Cells = Hours diff dum1 / clb;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=growth2 plots=none;
model Cells = Hours/ clb;
run;

data partialFtest9;
Fstat = ((256.47373- 256.47373	)/(2))/(256.47373/(17 -3 -1));
pvalue = SDF('F',Fstat,2 ,17-3-1);
Fcritical = quantile('F',.95,3 ,17-19-1);
run;

proc print data=partialFtest9;
run;