data honeycough;
input Honey DM Control Treatment $ TotalScore;
cards;
12 4 5 H 12
11 6 8 H 11
15 9 6 H 15
11 4 1 H 11
10 7 0 H 10
13 7 8 H 13
10 7 12 H 10
4 9 8 H 4
15 12 7 H 15
16 10 7 H 16
9 11 1 H 9
14 6 6 H 14
10 3 7 H 10
6 4 7 H 6
10 9 12 H 10
8 12 7 H 8
11 7 9 H 11
12 6 7 H 12
12 8 9 H 12
8 12 5 H 8
12 12 11 H 12
9 4 9 H 9
11 12 5 H 11
15 13 6 H 15
10 7 8 H 10
15 10 8 H 15
9 13 6 H 9
13 9 7 H 13
8 4 10 H 8
12 4 9 H 12
10 10 4 H 10
8 15 8 H 8
9 9 7 H 9
5 3 H 5
12 1 H 12
. . 4 DM 4
. . 3	DM 6
. . . DM 9
. . . DM 4
. . . DM 7
. . . DM 7
. . . DM 7
. . . DM 9
. . . DM 12
. . . DM 10
. . . DM 11
. . . DM 6
. . . DM 3
. . . DM 4
. . . DM 9
. . . DM 12
. . . DM 7
. . . DM 6
. . . DM 8
. . . DM 12
. . . DM 12
. . . DM 4
. . . DM 12
. . . DM 13
. . . DM 7
. . . DM 10
. . . DM 13
. . . DM 9
. . . DM 4
. . . DM 4
. . . DM 10
. . . DM 15
. . . DM 9
. . . C 5
. . . C 8
. . . C 6
. . . C 1
. . . C 0
. . . C 8
. . . C 12
. . . C 8
. . . C 7
. . . C 7
. . . C 1
. . . C 6
. . . C 7
. . . C 7
. . . C 12
. . . C 7
. . . C 9
. . . C 7
. . . C 9
. . . C 5
. . . C 11
. . . C 9
. . . C 5
. . . C 6
. . . C 8
. . . C 8
. . . C 6
. . . C 7
. . . C 10
. . . C 9
. . . C 4
. . . C 8
. . . C 7
. . . C 3
. . . C 1
. . . C 4
. . . C 3
;
run;

proc anova data=honeycough;
class treatment;
model totalscore=treatment;
run;

data name;
infile '/folders/myshortcuts/SAS/HW6/namegame.txt' dlm='09'X firstobs=2;
input Group Recall;
run;

proc sgpanel data=name;
panelby Group;
histogram Recall;
density Recall /type=normal;
run;

*There are too few of observations, let's look at all of the data;

proc sgplot data=name;
histogram Recall;
density Recall /type=normal;
run;

proc sgplot data=name;
vbox Recall/ category=Group;
run;

*levene's test (non-normal);
proc anova data=name;
class Group;
model Recall=Group;
means Group/ hovtest=levene(type=abs);
run;

data test;
f=quantile('F',0.95,3-1,300-3);
run;
proc print data=test;
run;
* f critical value is 3.02615
mst/mse = F
mst/2.355 > 3.02615 (critical)
mst = 2.355 * 3.02615 = 7.12658
;
data test;
pvalue = SDF('F',4.79,3-1,300-3);
f=quantile('F',0.95,3-1,300-3);
run;
proc print data=test;
run;