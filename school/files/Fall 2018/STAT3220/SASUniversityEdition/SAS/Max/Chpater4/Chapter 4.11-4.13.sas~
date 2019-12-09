*========================================================;
*========================================================;
*  Chapter 4: Multiple Regression Models (4.11 & 4.13)

 	- Quadratic Regression
 	 	~ Key idea: "linear regression" does not mean the relationship
  	 	between x and y is necessarily linear. It means that
   		the Beta's are a linear function.
  		~ Beta_1 is no longer interpreted as the slope.
  		- Need to also include lower order variable. 
  
 	- Comparing Nested Models
 		~ We can use a "partial F test" to test the significance of
    		a group of Betas at one time.
 		~ We assume that the Betas we are testing are all equal to 0
  
  	> Complete model: The model that includes all k predictors
  	> Reduced (full) model: The model that assumes the null is true (g predictors)
 
    		Fstat = [(SSEr - SSEc)/(k-g)]/[SSEc/(n - k - 1)]
  
  		 ~ If we reject, we conclude the the variables tested contribute 
    		to the model and should all be retained
; 

*========================================================;
*========================================================;
*                EXAMPLE 4.3                ;
*========================================================;
*========================================================; 
*A soft drink bottler is aware that the carbonation level 
of the soft drink is affected by the temperature of the 
product when opened. To better understand this relationship, 
they design an experiment to measure the carbonation level at 
three different temperatures.;


data soda;
input temp bubbles;
cards;
30.5 5.36
30.5 10.17
30.5 2.98
30.5 7.06
30.5 3.96
30.5 9.66
31 2.6
31 2.4
31 6.92
31 3.17
31 3.51
31 5.18
31.5 17.32
31.5 15.6
31.5 16.12
31.5 6.19
31.5 15.3
31.5 14.83
;
run;

*========================================================;

*QUESTION: What seems to be the appropriate regression 
model for this relationship?;

proc sgplot data=soda;
scatter y=bubbles x=temp;
run;

*What relationship does it have?
It seems like a parabola. 
bubbles = B_0 + B_1 temp + B_2 temp^2 + epsilon (model)
y_hat = B_hat_0 + B_hat_1 * temp + B_hat_2 * temp^2
-----Aside---------
E(y) = B_0 + B_1 x
	- Average value of y
y = B_0 + B_1 x + epsilon
	- Particular;

*========================================================;

*QUESTION: What is the estimated relationship between temperature 
and carbonation level?;

*Make a new variable for temp^2;
data soda2;
set soda; *adds the new variable to the existing data set;
*temp2 can hold any value since it is a variable...;
temp2 = temp*temp;
temp3 = temp**2; *exponent;
run;

*run the model using the NEW data set;
proc reg data=soda2 plots=none;
model bubbles = temp temp2;
run;
*
1. First look at the F test!
	- F test tell you at least one of the variables is not equal to zero...
	- If we fail to reject then no variables are significant
2. If temp2 is significant then we keep temp no matter what.
	- Is it significant
		- B_2 is significant NOT B_hat_2
3. We want adjust-R-Sq to be high
	- close to one
4. We want Root MSE to be close to zero (minimum is zero)
;

*========================================================;

*What is the interval estimate for the carbonation level of 
the soft drink when a bottle is opened at a temperature of 31.5 degrees? 
Give an interpretation of the interval.;
* This is asking a confidence interval (prediction interval for one bottle);
* need to put in values for all intervals;
data sodapre;
temp=31.5;
temp2=temp**2;
data soda3;
set soda2 sodapre;
run;
*Y value is missing since its what we want to predict;
* we are 95 % confident that the bubbles will between whatever the interval is;
* some observations have same error and confidence interval which happens since it
has the same x variable;
proc reg data=soda3 plots=none;
model bubbles = temp temp2/cli;
run;


*========================================================;

*QUESTION: What is the interval estimate for the average carbonation 
level when the soft drink is opened at a temperature of 31.5 degrees? 
Give an interpretation of the interval.;
* this is clm (mean average);
* why is it more narrow ( mean is always more narrow)?
	- There is less variability in means means that standard error is smaller making
	a smaller interval;
* Center for the mean and individual will be the same (for confidence interval). ;
proc reg data=soda3 plots=none;
model bubbles = temp temp2/clm;
run;



 
*========================================================;
*========================================================;
*            		 EXAMPLE 4.4               			;
*========================================================;
*========================================================; 

* A naval base is considering modifying or adding to its fleet
of 48 standard aircraft. The final decision regarding the type 
and number of aircraft to be added depends on a comparison of
cost versus effectiveness of the modified fleet. Consequently,
the naval base would like to model the projected percentage
increase y in fleet effectiveness by the end of the decade as
a function of cost x of modifying the fleet. Data were collected
on 10 naval bases.;

data navalbase;
input PERCENT COST BASE $;
cards;
18 125 US
32 160 US
9 80 US
37 162 US
6 110 US
3 90 FOR
30 140 FOR
10 85 FOR
25 150 FOR
2 50 FOR
;
run;

*========================================================;

*QUESTION: Does there appear to be a quadratic relationship
between percentage of movement and cost of modifying the fleet?;
* Maybe...?;
proc sgplot data=navalbase;
scatter y=percent x=cost;
run;

*========================================================;

*QUESTION: Is the quadratic term significant? (at alpha =0.1);

data naval2;
set navalbase;
cost2=cost**2;
run;

proc reg data=naval2 plots=none;
model percent= cost cost2;
run;
*F test is significant and cost2 is also significant (at alpha = 0.1) ;
* Alpha is probability of making a type 1 error;
* Cost is not significant, but we must keep it in the model since
cost^2 is significant;
* This also goes for the cubic relationship ( must keep all lower order );

*========================================================;

*Does there appear to be an interaction between cost and
base location?;
* Interaction is when slope of x_1 vs y depends on levels of x_2;

proc sgplot data=navalbase;
scatter y=percent x=cost / group=base datalabel=base;
run;
*group by base;


*========================================================;
*Consider a complete second order model:
percent = Beta_0 + Beta_1*cost + Beta_2*cost^2 + Beta_3*base
		+ Beta_4*cost*base + Beta_5*cost^2*base + e
		
Is there evidence to indicate that the type of base is a 
useful predictor?;

*define the new variables;
data naval3;
set naval2;
basecode = 0; *dummy variable;
if base = 'US' then basecode = 1;
costbase= cost*basecode;
cost2base=cost2*basecode;
run;
* want to test all three values at the same time. Are they different from zero?;
* 	- Nested Model (F) Test;

*Complete model;
proc reg data=naval3 plots=none;
model percent= cost cost2 basecode costbase cost2base;
run;



*Reduced model;
* - Assumes
	- That the null hypothesis is true.
	- Whatever betas im testing goes away;
proc reg data=naval3 plots=none;
model percent= cost cost2 ;
run;



*Nested F-test;
data nestedFtest;
Fstat = ((144.82499 -116.08519)/(5-2))/(116.08519/(10 -5 -1));
pvalue = SDF('F',Fstat,5 - 2 ,10 - 5 - 1); 
* 	- Name of distribution, point of probaility greater than, degree of freedom, k-g -1;
Fcritical = quantile('F',.95,5 - 2 ,10 - 5 - 1);
proc print data=nestedFtest;
run;
*what is my conclusion...
	- Fail to reject since the p value 
	is greater than 0.05 and f stat is less than critical value
	- We should keep the reduced...;

*========================================================;
*========================================================;
*             EXAMPLE 4.1 (Revisited)               ;
*========================================================;
*========================================================; 

data homesales;
input price size quality;
cards;
180.0  23  5
98.1  11  2
173.1  20  9
136.5  17  3
141.0  15  8
165.9  21  4
193.5  24  7
127.8  13  6
163.5  19  7
172.5  25  2
. 20 8
;
run;

*========================================================;
*QUESTION: Create a scatter plot of price vs quality.
Does there appear to be a quadratic relationship?;


proc sgplot data=homesales;
scatter y=price x=quality;
run;


*========================================================;

*QUESTION: Compare the model using the quadratic form of quality and the model 
using only the linear form of quality.;

data homesales2;
set homesales;
quality2=quality**2;
run;
proc reg data=homesales2 plots=none;
model price= quality size quality2 /cli;
run;

proc reg data=homesales2 plots=none;
model price= quality size quality2;
run;

*activity----no work---;
data homesalesparam;
size = 20;
quality=8;
quality2=64;
price = .;
data homesalespredict;
set homesalesparam homesales;
run;
proc reg data=homesalespredict plots=none;
model price= quality size quality2 /cli;
run;
*end-----------;
*Y value is missing since its what we want to predict;
* we are 95 % confident that the bubbles will between whatever the interval is;
* some observations have same error and confidence interval which happens since it
has the same x variable;
proc reg data=soda3 plots=none;
model bubbles = temp temp2/cli;
run;

*end------;
*this has lower rootmse;
proc reg data=homesales plots=none;
model price= quality size;
run;

*The quadratic form model will be better for prediction of price due to the smaller Root MSE;

*========================================================;
*QUESTION: Consider again, the interaction between size and 
quality. What is the complete model with an interaction,
if quality has a quadratic relationship with price?
(Hint: you should have Beta_0 through Beta_5);

*price = Beta_0 + Beta_1*quality + Beta_2*quality^2 + Beta_3*size
		+ Beta_4*size*quality + Beta_5*quality^2*size + e
		;

*========================================================;

*QUESTION: Now, using the complete model above test the 
significant of the curvilinear relationship between quality and
price;
data homesales3;
set homesales2;
sizequality= quality*size;
sizequality2=quality2*size;
run;

proc reg data=homesales3 plots=none;
model price= quality quality2 size sizequality sizequality2;
run;

data homesalesguess;
temp=31.5;
temp2=temp**2;
data soda3;
set soda2 sodapre;
run;
*========================================================;

*QUESTION: Compare all of the models you have considered 
throughout this example (chapters 4.1-4.13). Which homesales
model would you recommend? Remember that we are looking for the
best model with the fewest predictors.;



*========================================================;

*QUESTION: Use your "best" model to answer the following:
A client of the agency is planning to sell their 
current home and purchase a new home. For budgeting purposes, 
the client needs an estimate of the selling price of their 
current home which is 2000 square feet and has been given a 
quality rating of 8. What should that estimate be?;


