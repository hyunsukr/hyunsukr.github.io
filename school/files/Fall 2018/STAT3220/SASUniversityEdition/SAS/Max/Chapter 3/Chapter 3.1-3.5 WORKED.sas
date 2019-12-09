*========================================================;
*========================================================;
* Chapter 3: SIMPLE LINEAR REGRESSION (3.1-3.5)

	- Simple Linear Regression Analysis:
		1. Determine a straight line relationship between
			a response, y, and one predictor variable, x
		2. Collect the data
		3. Estimate through the least squares method
		4. Check the validity of the random error assumptions (Ch 8) 
		5. Statistically check the usefulness of the model
		6. Use the prediction equation for estimating E(y) or 
			to predict a future value
			
	- First order linear model: y = Beta_0 + Beta_1 * x + e
		~ y = Dependent variable (response)
		~ x = independent variable (predictor)
		~ E(y) = Beta_0 + Beta_1 * x (deterministic component)
		~ e = random error component (epsilon)
		~ Beta_0 = y-intercept of the line
		~ Beta_1 = slope of the line (amount of change in 
			the MEAN OF THE Y for every 1-unit increase in x)
			
	- Method of Least Squares: y-hat = Beta-hat_0 + Beta-hat_1 * x
		~ Idea: fit a line through our data with the smallest errors
			= There are many lines that will have error sum to 0
			= Only one line will have the smallest sum of the squared errors
			= That line (with smallest SSE) is the least 
				squares prediction equation
				
		~ Definitions:
			= Straight-line model: y = Beta_0 + Beta_1 * x + e
			= line of means: E(y) = Beta_0 + Beta_1 * x
			= fitted line: y-hat = Beta-hat_0 + Beta-hat_1 * x
			= residual: y - (y-hat) = obs - pred = y - (Beta-hat_0 + Beta-hat_1* x)
			= SSE: sum (y - (Beta-hat_0 + Beta-hat_1* x))^2
			= Beta-hat_1: SSxy/SSxx
			= Beta-hat_0: ybar - Beta-hat_1*xbar
			
		~ The least squares line:
			= the sum of the errors = 0
			= the SSE is smaller than that of any other line where SE=0
			= NOTE: We do not go through the calculus to finding these 
			estimates, you will do/did that in Stat 3120. See Appendix A.
			
		~ Interpreting Beta-hats
			= Beta-hat_1: For every one (unit increase) in (x variable)
				the MEAN of (y variable) increases by (Beta-hat_1)
			= Beta-hat_0: The estimate of MEAN (y variable) when 
				(x variable) is 0 (units)
				
	- Assumptions of least squares: With a population of y-values 
	existing at every x-value, there also exists a population of error terms, e
		= Describes the effects of the other variables on the dependent variable
		= Explains the variation in the population of y given a specific x
		= We must make assumptions about the error terms in order to use inference
		
	- Regression Assumptions (about e):
		1. At any given value of x, the population of potential error term
			values has a mean equal to 0.
		2. At any given value of x, the population of potential error term
			values has a constant variance, sigma^2
				> The variance of potential errors does not depend on the 
					independent variable
		3. At any given value of x, the population of potential error term
			values has a Normal distribution
		4. Any one value of the error term, e is statistically independent 
			of any other value of e
		NOTATION: 
			e ~iid~ N(0,sigma^2)
			y ~iid~ N(Beta_0 + Beta_1*x, sigma^2)
			
	- Estimating sigma^2 (the unknown, constant variance)
		= Mean Square Error:
			~ SSE/(n-2) Proof omitted again
			~ The point estimate of sigma^2
			~ denoted by MSE or s^2
		= Estimated Standard Error:
			~ The point estimate of sigma
			~ denoted by s
		NOTE: DO NOT ROUND WITH HAND CALCULATIONS- SAVE 6 sig figs
		= How large is too large?
			~ Use your background knowledge
			~ CV = 100(s/ybar)

*========================================================;
*========================================================;


*========================================================;
*========================================================;
*             		EXAMPLE 3. 1            			 ;
*========================================================;
*========================================================;

*The company that produces a particular laundry detergent 
is interested studying the relationship between detergent 
prices and the demand for a large bottle of their detergent. 
The company hires a statistician who collects the number of 
large bottles of their detergent sold (in hundreds of 
thousands of bottles) and the average price difference 
(in dollars) between this company and their competitors for 
30 randomly selected sales periods. The price difference 
is calculated by subtracting their average price from their 
competitor’s average price.;

data detergent;
input sales price;
cards;
7.38 -0.05
8.51  0.25
9.52  0.6
7.5   0
9.33  0.25
8.28  0.2
8.75  0.15
7.87  0.05
7.1  -0.15
8     0.15
7.89  0.2
8.15  0.1
9.1   0.4
8.86  0.45
8.9   0.35
8.87  0.3
9.26  0.5
9     0.5
8.75  0.4
7.95 -0.05
7.65 -0.05
7.27 -0.1
8     0.2
8.5   0.1
8.75  0.5
9.21  0.6
8.27 -0.05
7.67  0
7.93  0.05
9.26  0.55
;
run;

*QUESTION: Does the scatterplot show a linear relationship between 
price difference and demand?;

proc sgplot data=detergent; 
scatter y=sales x=price; 
run;

*Yes, the relationship appears to be linear;

*========================================================;

*QUESTION: What is the prediction equation for laundry detergent?;

proc reg data=detergent plots=none;
model sales=price;
run;

* sales_hat = 7.81 + 2.67 * price
;

*========================================================;
*========================================================;

*QUESTION: The company has made a modification to their prices
that will lead to a price difference of $0.35 for the next sales
period. What should they expect their demand to be?

1. Check that x = $0.35 is in the experimental region
	Yes, 0.35 is in the experimental region
2. Calculate the point prediction for demand.;

data demand;
pt_pred = 7.81 + 2.67*0.35;
run;

proc print data=demand;
run;

*874,450 bottles is the point prediction of the demand for a
single sales period when the difference in average  price is $0.35;

*========================================================;

*QUESTION: The company has found that several sales periods 
have a  price difference of $0.35. What should they expect their 
demand to be over those periods?

1. Check that x = $0.35 is in the experimental region
	Yes, 0.35 is in the experimental region
2. Calculate the point prediction for demand.;

data demand;
set demand;
pt_est = 7.81 + 2.67*0.35;
run;

proc print data=demand;
run;

*874,450 bottles is the point estimate of the average demand
over sales periods when the difference in average price is $0.35;

*========================================================;

*QUESTION: What is the estimate of sigma^2 in the laundry 
detergent example? sigma?;

proc reg data=detergent plots=none;
model sales=price;
run;

*MSE = 0.10021
s = 0.31656
;