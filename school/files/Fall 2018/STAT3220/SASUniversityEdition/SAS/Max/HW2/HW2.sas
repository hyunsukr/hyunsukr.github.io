data streetven;
infile '/folders/myshortcuts/SAS/HW2/streetven.txt' dlm='09'X firstobs=2;
input Venums Earning Age Hours;
run;

proc reg data=streetven plots=none; 
model earning = Age Hours / clb alpha=0.01;
run;

proc reg data=streetven plots=none; 
model earning = Age Hours / clb;
run;

data streetven2;
earning= .;
Age= 45;
Hours = 10;
run;
data streetven3;
set streetven streetven2;
run;
proc reg data=streetven3 plots=none; 
model earning = Age Hours / cli;
run;
proc reg data=streetven3 plots=none; 
model earning = Age Hours / clm;
run;

data streetven_new;
set streetven;
age_hours = Age*Hours;
run;

proc reg data=streetven_new plots=none;
model earning = Age Hours age_hours / clb;
run;

data gasturbine;
infile '/folders/myshortcuts/SAS/HW2/gasturbine.txt' dlm='09'X firstobs=2;
input engine $ shafts rpm cpratio inlet_temp exh_temp airflow power heartrate;
run;

proc reg data=gasturbine plots=none; 
model heartrate = rpm inlet_temp exh_temp cpratio airflow / clb alpha=0.01;
run;

data gasturbine_new;
set gasturbine;
inlet_air = inlet_temp*airflow;
exh_air = exh_temp*airflow;
run;

proc reg data=gasturbine_new plots=none;
model heartrate = inlet_temp exh_temp inlet_air exh_air airflow / clb;
run;
proc reg data=gasturbine_new plots=none;
model heartrate = inlet_temp exh_temp inlet_air exh_air / clb;
run;

data gas_quad_nointer;
set gasturbine;
rpm2= rpm*rpm;
cpratio2 = cpratio*cpratio;
run;

data gas_quad_inter;
set gasturbine;
rpm2= rpm*rpm;
cpratio2 = cpratio*cpratio;
rpmratio = rpm*cpratio;
run;

proc reg data=gas_quad_nointer plots=none;
model heartrate = rpm rpm2 cpratio cpratio2 / clb;
run;

proc reg data=gas_quad_inter plots=none;
model heartrate = rpm rpm2 cpratio cpratio2 rpmratio / clb;
run;

proc reg data=gas_quad_inter plots=none;
model heartrate = rpm rpm2 cpratio cpratio2 rpmratio / clb;
run;

proc reg data=gas_quad_inter plots=none;
model heartrate = rpm cpratio rpmratio / clb;
run;
data gastest;
Fcritical = quantile('F',.90,2 ,61);
proc print data=gastest;
run;
data wafer;
infile '/folders/myshortcuts/SAS/HW2/wafer.txt' dlm='09'X firstobs=2;
input temp failtime;
run;

proc sgplot data=wafer;
scatter y=failtime x=temp; 
run;

proc reg data=wafer plots=none;
model failtime = temp / clb;
run;

data wafer_new;
set wafer;
temp2 = temp*temp;
run;

proc reg data=wafer_new plots=none;
model failtime = temp temp2 / clb;
run;
