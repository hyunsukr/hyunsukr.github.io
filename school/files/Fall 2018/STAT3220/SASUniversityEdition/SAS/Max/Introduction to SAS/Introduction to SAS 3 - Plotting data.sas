*===============================================================*
 
 There are various ways to plot data.

*===============================================================*;

*=================================*
 Creating a scatterplot
*=================================*;

** These three examples generate the same scatterplot with the 
   first homework score on the y-axis and the second homework 
   score on the x-axis.
;

proc sgplot data=hw_scores;
scatter y=score1 x=score2;
run;

proc gplot data=hw_scores;
plot score1*score2;
run;

** proc gplot is not available in SAS University Edition.
;

proc plot data=hw_scores;
plot score1*score2;
run;


*=================================*
 Creating multiple scatterplots
*=================================*;

** To generate multiple full scale plots using proc sgplot, 
   you will need to use multiple proc sgplot statements as
   shown below
;

proc sgplot data=hw_scores;
scatter y=score1 x=ID;
run;

proc sgplot data=hw_scores;
scatter y=score2 x=ID;
run;

** To generate smaller scale plots, proc sgscatter can be
   used in two different ways shown below.
;

proc sgscatter data=hw_scores;
plot (score1 score2)*ID;
run;

proc sgscatter data=hw_scores;
compare y=(score1 score2) x=ID;
run;

** Both of these sets of plots use different variables for 
   the y-axis. The same code can be used when the different 
   variables are on x-axis by changing the location of the
   parentheses.
;
