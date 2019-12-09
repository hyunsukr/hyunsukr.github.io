data Sales;
infile '/folders/myshortcuts/SAS/HW1/sales.txt' dlm='09'X firstobs=2;
input Property Market_Value Sale_Price;
run;

proc reg data=Sales plots=none; 
model Sale_Price = Market_Value / cli;
run;

proc reg data=Sales plots=none; 
model Sale_Price = Market_Value / clb;
run;

* Sale_Price_Hat = 1.36 + 1.41 * Market_Value;

data smeltpot;
infile '/folders/myshortcuts/SAS/HW1/SMELTPOT.txt' dlm='09'X firstobs=2;
input Brick $ Porosity Diameter;
run;

proc reg data=smeltpot plots=none; 
model Porosity = Diameter / cli;
run;

data spill;
infile '/folders/myshortcuts/SAS/HW1/spill.txt' dlm='09'X firstobs=2;
input Time Mass;
run;

proc reg data=spill plots=none; 
model Mass = Time / cli;
run;

data spill;
infile '/folders/myshortcuts/SAS/HW1/spill.txt' dlm='09'X firstobs=2;
input Time Mass;
run;

proc reg data=spill plots=none; 
model Mass = Time / cli;
run;

data students;
infile '/folders/myshortcuts/SAS/HW1/students.txt' dlm='09'X firstobs=2;
input position recall;
run;

proc reg data=students plots=none; 
model recall = position / clm alpha=0.01;
run;

proc reg data=students plots=none; 
model recall = position / cli alpha=0.01;
run;

