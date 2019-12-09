*===============================================================*
 
 You create a data set when you read in data, but you can also
 create or modify data sets using a data step. 

*===============================================================*;

*=================================================*
 Creating a data set to contain a computed value
*=================================================*

** You can use SAS as a calculator using data steps as in the two
   examples below. The first uses SAS to determine the sum of two
   numbers. The second uses the SDF function to find the 
   right-tailed p-value associated with the z-score 2.0.
;

data sum_num;
sum_num = 462+893;
run;

data pvalue;
pvalue = SDF('NORM',2.0);
run;


*=================================================*
 Modifying a data set
*=================================================*

** You may want to create new variables from the variables 
   currently in a data set. The example below finds the 
   average of the two homework scores for each student using 
   the homework scores data from the Introduction to SAS 1
   program.
;

data hw_scores_avg;
set hw_scores;
avg_scores = mean(score1,score2);
avg_scores2 = (score1 + score2)/2;
run;


*=================================================*
 Stacking data sets
*=================================================*

** You may want to combine two data sets into one single data
   set. If you have two data sets with different observations in 
   the rows that you would like to use as one large data set with
   all of the observations from the two data sets, you will 
   stack those data sets together. The example below stacks a data
   set with the homework scores for an additional three students
   onto the original homework scores data set from the Introduction
   to SAS 1 program.
;

data hw_scores_add;
input ID score1 score2 gender $;
cards;
8 7.9 8.5 M
9 9.8 10 M
10 8.3 9.2 F
;
run;

data hw_scores_all;
set hw_scores hw_scores_add;
run;


*=================================================*
 Merging data sets
*=================================================*

** You may have a second data set that contains additional information 
   for the observations you already have. In this case, you would 
   want to merge the additional columns onto the existing data set.
   The example below merges on midterm exam scores for all ten 
   students in the scores data set from the created above.
;

data MT_scores;
input ID MTscore;
cards;
1 85
2 91
3 78
4 81
5 95
6 75
7 82
8 94
9 77
10 88
;
run;

** To merge data sets, you will need to indicate how SAS should identify
   the same observation from both data sets. In this case the ID is the 
   same for each unique student in both data sets. In this example, the 
   data sets to be merged are already sorted by that ID variable, but if 
   that is not the case, you will first need to sort each data set by 
   the identifying variable for SAS to merge the data sets correctly.
;

proc sort data=hw_scores_all;
by ID;
run;

proc sort data=MT_scores; 
by ID; 
run;

data all_scores;
merge hw_scores_all MT_scores;
by ID;
run;
