*========================================================;
*========================================================;
*  Chapter 5: Principles of Model Building (5.6, 5.10)

 - Coding: transforming a set of independent variables
 into a new set of independent variables.
 
 - Benefits to coding quantitative variables:
  1. computations are easier for computers and 
   lead to less rounding errors
  2. the correlation between independent variables
   is reduced (multicollinearity)
   
 - Coding procedure: u = (x - xbar) / s_x
 
 NOTE: Intepretations of Betas are now Beta/s_x
 
 - General steps to model building:
  1. write a model relating the quantitative predictors
  2. add the qualitative predictors and their interactions
  3. add interactions between quantitative and qualitative 
   variables
  - NOTE: you should perform nested F tests and coding of 
   variables as necessary
   
;
*========================================================;
*========================================================;

*========================================================;
*========================================================;
*               EXAMPLE 5.2                  ;
*========================================================;
*========================================================;
*As part of the first-year evaluation for new salespeople, 
a large food processing firm projects the second-year sales
based on his or her sales for the first year.;

data sales;
input SALESYR1 SALESYR2;
cards;
75.2 99.3
91.7 125.7
100.3 136.1
64.2 108.6
81.8 102.0
110.2 153.7
77.3 108.8
80.1 105.4
;
run;



*========================================================;
*QUESTION: What is the equation relating first year sales to
second year sales?;

proc sgplot data=sales;
scatter y=salesyr2 x=salesyr1;
run;


*y = Beta_0 + Beta_1 *x + Beta_2 *x^2 + e;


*========================================================;
*QUESTION: Is multicollinearity a concern?;



*Yes, becasue we are including x and x^2;

*========================================================;
*QUESTION: What is the equation relating the coding variable
to first year sales?;

proc univariate data=sales;
var salesyr1;
run;



*u = x - xbar / s_x = x - 85.1 / 14.81;

*========================================================;
*QUESTION: Calculate the coded values of u.;

data sales2;
set sales;
salesyr1sq= salesyr1**2;
u = (salesyr1 - 85.1)/14.81;
u2 = u**2;
run;


*========================================================;
*QUESTION: Calculate the correlation between x and x^2. 
u and u^2?;

proc corr data=sales2;
run;

*0.99 vs 0.37;

*========================================================;
*QUESTION: What is the estimated regression between y and 
u and u^2?;

proc reg data=sales2 plots=none;
model salesyr2 = u u2;
run;








