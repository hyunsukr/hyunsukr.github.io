*========================================================;
*========================================================;
*Chapter 6: Variables Screening Methods (6.1-6.4)
		
	- Variable Screening Procedures: determining which
		predictors are most important and which are least
		important
		
	- ITERATIVE SELECTION PROCEDURES:
		> Stepwise Regression: Adds new predictors to the model one at a time,
			does remove predictors if they become insignificant
		> Forward Selection: Adds new predictors to the model one at a time,
			does not remove predictors if they become insignificant
		> Backwards Elimination: Begins with a model of all independent variables,
			removes them one at a time beginning with the least significant	
	
	- All-Possible-Regression (CRITERIA BASED) SELECTION:
		> R^2 : not necessarily the model with the largest R^2
			= larger desired
		> Adjusted R^2 or MSE: adjusted R^2 increases IFF MSE decreases
			= larger adj R^2
			= smaller MSE desired
		> Cp- Statistic: ratio of SSE from a subset model with p predictors
			and the MSE of an all predictors particular model (k predictors)
			= smaller preferred
			= ideal: p+1
		> PRESS Statistic: sum of the squared "deleted residuals"
			= smaller desired

	- IMPORTANT NOTES:
		> the probability of a type I or type II error is high
		> You still want to consider higher order terms and interactions
		> When we use an iterative process, we still must still assess our model(s)
		> When we use criteria based selection must evaluate the 
		significance of our model(s)
		> USE YOUR COMMON SENSE AND FOLLOW THE RULES FOR MODEL BUILDING
  ;
  
  
*========================================================;
*========================================================;
*             			EXAMPLE 6.1            			 ;
*========================================================;
*========================================================;
*A marketing research firm has obtained prescription sales data for 
20 independent pharmacies. The firm has collected the average weekly 
prescription sales over the past year (in thousands of dollars), 
the floor space (in square feet), the percentage of floor space allocated 
to the prescription department, the number of parking spaces available 
to the store, the weekly per capita income for the surrounding 
community (in hundreds of dollars), and an indicator for whether the 
pharmacy is located in a shopping center.;

*y=Prescription Sales;

data prescript;
	input Sales FloorSp PresPct Parking Income ShopCtr;
	cards;
22 4900 9 40 18 1
19 5800 10 50 20 1
24 5000 11 55 17 1
28 4400 12 30 19 0
18 3850 13 42 10 0
21 5300 15 20 22 1
29 4100 20 25 8 0
15 4700 22 60 15 1
12 5600 24 45 16 1
14 4900 27 82 14 1
18 3700 28 56 12 0
19 3800 31 38 8 0
15 2400 36 35 6 0
22 1800 37 28 4 0
13 3100 40 43 6 0
16 2300 41 20 5 0
8 4400 42 46 7 1
6 3300 42 15 4 0
7 2900 45 30 9 1
17 2400 46 16 3 0
;
run;

*========================================================;

*QUESTION: Do any of the variables seem to have a relationship with 
prescription sales?;

*As usual to answer this question we will begin to examine the
relationships from scatterplots.;



proc sgplot data=prescript;
	scatter y=Sales x=FloorSp;
run;
*weak, positive;

proc sgplot data=prescript;
	scatter y=Sales x=PresPct;
run;
*moderate negative;

proc sgplot data=prescript;
	scatter y=Sales x=Parking;
run;
*weak negative;

proc sgplot data=prescript;
	scatter y=Sales x=Income;
run;
*moderate positive;

proc sgplot data=prescript;
	scatter y=Sales x=ShopCtr;
	
run;

proc sgplot data=prescript;
	vline shopctr /response=sales stat=mean markers datalabel;
run;
*stores in a shopping center have a slightly lower average sales;

*Create one step for all plots;
proc sgscatter data=prescript;
	plot sales*(FloorSp prespct parking income shopctr);
run;

*========================================================;

*QUESTION: Do any of the explanatory variables seem to have a 
relationship with any other explanatory variable?;

proc sgscatter data=prescript;
matrix FloorSp PresPct Parking Income ShopCtr; 
run;

proc corr data=prescript;
var FloorSp PresPct Parking Income ShopCtr; 
run;


*Floor space appears to have a strong relationship with the other 
explanatory variables. As does, floor space allocated to the
prescription department.;


*Income & FloorSp and income & PresSp have strong relationships;

*========================================================;
*========================================================;

*QUESTION: Which model results from using forward selection?;

proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / 
selection=forward SLentry=0.05;
*The defaults of SLEntry (SLE) are 0.50 for FORWARD and 0.15 for STEPWISE.;
run;

proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / 
selection=forward SLentry=0.05 details;
run;

*sales = Beta_0 + Beta_1*PresPct + Beta_2*FloorSp + e;

*========================================================;

*QUESTION: Which model results from using stepwise selection?;

proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / 
selection=stepwise SLentry=0.05 SLstay=0.10 details; 
*The defaults for SLStay (SLS) are 0.10 for BACKWARD and 0.15 for STEPWISE.;
run;

*sales = Beta_0 + Beta_1*PresPct + Beta_2*FloorSp + e;

*========================================================;

*QUESTION: Which model results from using backward selection?;
proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / 
selection=backward SLstay=0.05 details=steps;
run;

*sales = Beta_0 + Beta_1*PresPct + Beta_2*FloorSp + e;

*========================================================;
*========================================================;

*QUESTION: Which models yield the highest adjusted R^2?;

proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / selection=ADJRSQ RMSE CP;
run;

proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / selection=ADJRSQ best=3 RMSE CP;
run;

*The model with FloorSp, PresPct, and ShopCtr yields the highest adjusted R^2 = 0.6327.
The model with FloorSp and PresPct yields the second highest adjusted R^2 = 0.6263.
The model with FloorSp, PresPct, and Parking yields the third highest adjusted R^2 = 0.6193.
;

*========================================================;

*QUESTION: Which models yield the lowest Mallow’s Cp?;

proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / selection=CP ADJRSQ RMSE;
run;
proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / selection=CP best=3 ADJRSQ RMSE;
run;

*The model with FloorSp and PresPct yields the lowest Mallow's Cp = 1.6062.
The model with 	FloorSp, PresPct, and ShopCtr yields the second lowest Mallow's Cp = 2.4364.
The model with 	PresPct and ShopCtr yields the third lowest Mallow's Cp = 2.4744.
;

*========================================================;
*QUESTION: Of the models from iterative selection and 
criteria-based selection, which models yield the lowest PRESS statistic?;

proc reg data=prescript plots=none outest=sales3;
all_selctions: model Sales = FloorSp PresPct / PRESS ADJRSQ; *all iterative and criteria based;
criteria: model sales = FloorSp PresPct ShopCtr /PRESS adjrsq; * both criteria based;
adjr: model sales = FloorSp PresPct Parking/ PRESS adjrsq; *adjrsq;
cp: model sales = PresPct Parking/ PRESS adjrsq; *mallows cp;
run;

proc print data=sales3;
run;

*all_selctions: Sales = FloorSp PresPct has a PRESS statistic of 347.007;

*========================================================;

*QUESTION: Which of the "best" models identified above
gives the shortest prediction interval for the 
first observation in the data?;


*all iterative and criteria based;
proc reg data=prescript plots=none;
all_selctions: model Sales = FloorSp PresPct; 
output out=PIvalues1 LCL=lb1 UCL=ub1;
run;
data diff1;
set PIvalues1;
PIlength1= ub1-lb1;
run;
proc print data=diff1;
run;
*s=3.84200 interval is (15.4784, 32.9749). Prediction length is 17.49;


* both criteria based;
proc reg data=prescript plots=none;
criteria: model Sales = FloorSp PresPct ShopCtr; 
output out=PIvalues2 LCL=lb2 UCL=ub2;
run;
data diff2;
set PIvalues2;
PIlength2= ub2-lb2;
run;
proc print data=diff2;
run;

*s=3.80893	interval is (13.853, 31.9611). Prediction length is 18.1;

*adjrsq;
proc reg data=prescript plots=none;
adjr: model sales = FloorSp PresPct Parking;
output out=PIvalues3 LCL=lb3 UCL=ub3;
run;
data diff3;
set PIvalues3;
PIlength3= ub3-lb3;
run;
proc print data=diff3;
run;


* s= 3.87783 interval is (15.5515, 33.3292) Prediction length is 17.7777;

*mallows cp;
proc reg data=prescript plots=none;
cp: model sales = PresPct Parking;
output out=PIvalues4 LCL=lb4 UCL=ub4;
run;
data diff4;
set PIvalues4;
PIlength4= ub4-lb4;
run;
proc print data=diff4;
run;

*s= 4.54836 interval is (13.5331, 34.2620) prediction lenght is 20.7289;

*data for all prediction lengths;

data alldf;
merge diff1 diff2 diff3 diff4;
keep PIlength1 PIlength2 PIlength3 PIlength4;
run;


*========================================================;
*========================================================;

*FINAL DECISION: Which of the models identified should be used?;


proc reg data=prescript plots=none;
all_selctions: model Sales = FloorSp PresPct / PRESS ADJRSQ; *all iterative and criteria based;
adjr: model sales = FloorSp PresPct Parking/ PRESS adjrsq; *adjrsq;
run;

*========================================================;
*========================================================;

*QUESTION: Which of the variables seem most important?;

*========================================================;

*QUESTION: Now consider higher order terms and interactions.
Can you improve the model?

*========================================================;

*FINAL DECISION: What is the best model you created?

