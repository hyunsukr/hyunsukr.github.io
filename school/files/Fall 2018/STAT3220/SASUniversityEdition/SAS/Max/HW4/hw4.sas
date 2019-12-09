data mois;
infile '/folders/myshortcuts/SAS/HW4/MOISSANITE.txt' dlm='09'X firstobs=2;
input VOLUME	PRESSURE;
run;

data mois2;
 set mois;
 PRESSURE2=log(PRESSURE);
 PRESSURE3= PRESSURE*2;
 PRESSURE4 = PRESSURE2**0.5;
run;

proc reg data=mois2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model VOLUME = PRESSURE2/ r cli clm;
run;
proc reg data=mois2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model VOLUME = PRESSURE3/ r cli clm;
run;
proc reg data=mois2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model VOLUME = PRESSURE4/ r cli clm;
run;

data aswell;
infile '/folders/myshortcuts/SAS/HW4/ASWELLS.txt' dlm='09'X firstobs=2;
input WELLID UNION$ VILLAGE$ LATITUDE LONGITUDE DEPTH_FT YEAR KIT_COLOR$ ARSENIC;
run;

proc reg data=aswell plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model ARSENIC = LATITUDE LONGITUDE DEPTH_FT/ r cli;
run;

data LIFEINS;
infile '/folders/myshortcuts/SAS/HW4/LIFEINS.txt' dlm='09'X firstobs=2;
input Year Policies;
run;
data LIFEINS2;
 set LIFEINS;
 Year2=Year-1979;
run;
proc reg data=LIFEINS2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model Policies = Year2/ r cli;
run;

proc reg data=LIFEINS2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model Policies = Year2 / dwprob;
run;
proc reg data=LIFEINS2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model Policies = Year2 / dw;
run;
data naval;
infile '/folders/myshortcuts/SAS/HW4/NAVALFLEET.txt' dlm='09'X firstobs=2;
input IMPROVE	COST;
run;
data naval2;
 set naval;
 cost2=cost*cost;
run;
proc reg data=naval2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model IMPROVE = cost cost2 /r influence;
run;

data print;
infile '/folders/myshortcuts/SAS/HW4/PRINTSHOP.txt' dlm='09'X firstobs=2;
input ABSRATE QTR1DUM	QTR2DUM	QTR3DUM;
run;
proc reg data=print plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model ABSRATE = QTR1DUM QTR2DUM QTR3DUM;
run;
data print2;
 set print;
 absrate2=sqrt(ABSRATE);
run;
proc reg data=print2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model absrate2 = QTR1DUM QTR2DUM QTR3DUM;
run;

data ezz;
infile '/folders/myshortcuts/SAS/HW4/ex7_20.txt' dlm='09'X firstobs=2;
input x y;
run;

data ezz2;
 set ezz;
 y2=exp(1.0)**(log(y));
run;

proc reg data=ezz2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model y2 = x;
run;

data testing;
y= .;
x= 30;
run;

* This is merging the two datasets together; 
data ezz3;
set ezz2 testing;
run;

proc reg data=ezz3 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model y2 = x/cli;
run;


