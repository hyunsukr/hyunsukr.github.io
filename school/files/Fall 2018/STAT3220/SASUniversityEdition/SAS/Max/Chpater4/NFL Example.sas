
*###################################################################################################

The purpose of this case study is to explore the concepts we have covered in the beginning of Chapter 4
 as well as to get more comforatble with SAS, as this will be the format for exams.

Answer each question below using a comment in this format 
(starting with a star and ending with a semi-colon). 
You should manually create line breaks so that your entire 
answer can be viewed without scrolling right or left.

Any written model should be in the form shown below:
y = beta0 + beta1*(Name of variable 1) + beta2*(Name of variable 2) + ... + epsilon

Leave all relevant code in the program under the problem prompt.

 The data set below records the number of wins and various factors for NFL teams during a 
 previous season.

 The variables are ordered as:
 Games won
 Rushing yards during the season
 Passing yards during the season
 Punting average (yards/punt)
 Field goal percentage (FG made/FG attempted)
 Turnover differential (turnovers acquired - turnovers lost)
 Penalty yards during the season
 Percent rushing (rushing plays/total plays)
 Opponents' rushing yards during the season
 Opponents' passing yards during the season

 The Washington Redskins data is the last row of data and is missing the number of wins. 


###################################################################################################;


data nfl;
input wins r_yards p_yards punt_avg field_percentage turn_diff pent_yards percent_rush op_rush op_pass;
cards;
11 2003 2855 38.8 61.3 3 615 55 2096 1575
11 2957 1737 40.1 60 14 914 65.6 1847 2175
13 2285 2905 41.6 45.3 -4 957 61.4 1903 2476
10 2971 1666 39.2 53.8 15 836 66.1 1457 1866
11 2309 2927 39.7 74.1 8 786 61 1848 2339
10 2528 2341 38.1 65.4 12 754 66.1 1564 2092
11 2147 2737 37 78.3 -1 761 58 1821 1909
4 1689 1414 42.1 47.6 -3 714 57 2577 2001
2 2566 1838 42.3 54.2 -1 797 58.9 2476 2254
7 2363 1480 37.3 48 19 984 67.5 1984 2217
10 2109 2191 39.5 51.9 6 700 57.2 1917 1758
9 2295 2229 37.4 53.6 -5 1037 58.8 1761 2032
9 1932 2204 35.1 71.4 3 986 58.6 1709 2025
6 2213 2140 38.8 58.3 6 819 59.2 1901 1686
5 1722 1730 36.6 52.6 -19 791 54.4 2288 1835
5 1498 2072 35.3 59.3 -5 776 49.6 2072 1914
5 1873 2929 41.1 55.3 10 789 54.3 2861 2496
6 2118 2268 38.2 69.6 6 582 58.7 2411 2670
4 1775 1983 39.3 78.3 7 901 51.7 2289 2202
3 1904 1792 39.7 38.1 -9 734 61.9 2203 1988
3 1929 1606 39.7 68.8 -21 627 52.7 2592 2324
4 2080 1492 35.5 68.8 -8 722 57.8 2053 2550
10 2301 2835 35.3 74.1 2 683 59.7 1979 2110
6 2040 2416 38.7 50 0 576 54.9 2048 2628
8 2447 1638 39.9 57.1 -8 848 65.3 1786 1776
2 1416 2649 37.4 56.3 -22 684 43.8 2876 2524
0 1503 1503 39.3 47 -9 875 53.5 2560 2241
. 2113 1985 38.9 64.7 4 868 59.7 2205 1917
;
run;

*1.  Decide on a group name and write it here;
* A5
*2. Properly create the data command (using a data name and variable names). You want to shorten
	the variable names from what are listed above.;

*3.  Create a scatterplot of number of wins vs.  each explanatory variable;
proc sgplot data=nfl;
scatter y=wins x=r_yards;
run;
proc sgplot data=nfl;
scatter y=wins x=p_yards;
run;
proc sgplot data=nfl;
scatter y=wins x=punt_avg;
run;
proc sgplot data=nfl;
scatter y=wins x=field_percentage;
run;
proc sgplot data=nfl;
scatter y=wins x=turn_diff;
run;
proc sgplot data=nfl;
scatter y=wins x=pent_yards;
run;
proc sgplot data=nfl;
scatter y=wins x=percent_rush;
run;
proc sgplot data=nfl;
scatter y=wins x=op_rush;
run;
proc sgplot data=nfl;
scatter y=wins x=op_pass;
run;
*4.  From each scatterplot, determine whether each explanatory variable has a 
	linear relationship with number of wins or not. Comment on the strength and direction for each.;

*5.  List the variables you think have a linear relationship with number of wins.
	Write your hypothesized model;

*6.  Run the regression model for number of wins using the variables that you have listed and 
	determine if the overall relationship is significant. How do you know?;
proc reg data=nfl plots =none;
model wins = p_yards percent_rush op_rush/ clm;
run;
proc reg data=nfl plots =none;
model wins = p_yards / cli clm clb;
run;
proc reg data=nfl plots =none;
model wins = punt_avg / cli clm clb;
run;
proc reg data=nfl plots =none;
model wins = field_percentage / cli clm clb;
run;
proc reg data=nfl plots =none;
model wins = turn_diff / cli clm clb;
run;
proc reg data=nfl plots =none;
model wins = pent_yards / cli clm clb;
run;
proc reg data=nfl plots =none;
model wins = percent_rush / cli clm clb;
run;
proc reg data=nfl plots =none;
model wins = op_rush / cli clm clb;
run;
proc reg data=nfl plots =none;
model wins = op_pass / cli clm clb;
run;

* interaction;
proc reg data=nfl plots =none;
model wins = p_yards percent_rush/ clm;
run;
data nfl_new;
set nfl;
wins_interaction = p_yards*percent_rush;
run;
proc reg data=nfl_new plots=none;
model wins = wins_interaction percent_rush p_yards / clm;
run;
*7.  List the explanatory variables that are significant in the model;

*8.  If any explanatory variables are not significant in the model,remove the variable that is 
	the least significant and rerun your model;

*9.  Repeat the previous step 8 until all variables remaining in your model are significant;

*10.  Write the prediction equation with the significant variables remaining in your model;

*11. Use the model with all the variables listed in the previous step
	to predict the number of wins for the Washington Redskins;
