* Chapter 3: SIMPLE LINEAR REGRESSION (3.6-3.9)

	- Simple Linear Regression Analysis:
		1. Determine a straight line relationship between
			a response, y, and one predictor variable, x
		2. Collect the data
		3. Estimate through the least squares method
		4. Check the validity of the random error assumptions 
		5. Statistically check the usefulness of the model
		6. Use the prediction equation for estimating E(y) or 
			to predict a future value
			
	- SLR Model Utility: Inference on the Slope
		> Assume x and y are unrelated AKA assume Beta_1 = 0
		> Sampling Distribution of b_1 (assuming the regression
			assumptions hold): b_1 ~iid~ N(Beta_1, sigma^2/SSxx)
		> Test statistic: follows a t distribution with n-2
			degrees of freedom
			
					  t = (Beta-hat_1 - Beta_1 under null)/ (s/sqrt(SSxx))
(assume Beta_1 = 0, 	= (Beta-hat_1)/ (s/sqrt(SSxx)
	under null)   
	
	> Confidence Interval: Estimate Beta_1
	
				Beta-hat_1 +/- [(t_alpha/2)(s/sqrt(SSxx)]
				
				
	- Coefficient of Correlation (r)
		> Quantitative measure of the strength of the linear 
		relationship between x and y
		> unitless
		> always the same sign as Beta-hat_1
		> r = SSxy/sqrt(SSxx * SSyy)
		> HIGH CORRELATION DOES NOT IMPLY CAUSALITY
		> Test of significance is equivalent to the test of Beta_1

	- Coefficient of determination, r^2
		> How much the errors of prediction of y are reduced
		by using the information provided by x
		> INTERPRETATION : The proportion (or percent) of sample 
		variation in the y that is explained by the presence of 
		the x in the regression model.
		> r^2 = (SSyy-SSE)/SSyy = explained variation/total variation
		
	- Estimation and Prediction: Let x_p be a specific point of interest
		> The "confidence interval" is an interval estimate for E(y)
			~ The mean value of y given x_p
		> The "prediction interval" is an interval estimate for y
			~ predicting a particular value of y for a given x_p
			
		> The difference between these is the accuracy of the prediction
			~ SE of mean value = sigma*sqrt[(1/n) + (x_p - xbar)^2/SS_xx]
			~ SE of individual predicted value = sigma*sqrt[1 + (1/n) + (x_p - xbar)^2/SS_xx]
				
		> Comments about estimation/prediction		
			~ The closer x_p lies to xbar, the more information we obtain
			from the interval
				= When x_p = xbar intervals are the narrowest
			~ Prediction intervals will ALWAYS be wider than confidence
			intervals (why?)
			~ We can only estimate/predict accurately when x_p is within the
			experimental region
;


*========================================================;
*========================================================;
*             			EXAMPLE 1            			 ;
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

*========================================================;

*QUESTION: When the competing detergents are sold at the same price, 
should the company expect any demand?;

proc reg data=detergent plots=none;
model sales = price;
run;

*When competing detergents are sold at the same price (price diff = x = 0)
the company should expect a demand of 781,409 bottles. This interpretation
does make practical sense in context.;


*========================================================;

*QUESTION: By how much do you expect the average demand to change
when the competing detergents have a price difference of $1?;


* We expect the average demand to increase by 267, 000 bottes 
when the competing detergents have a price difference of $1;

*========================================================;

*QUESTION: Is there a significant relationship between price 
difference and detergent demand?;



*Beta-hat_1 = 2.68
s_b1 = 0.259
t = 10.31
pvalue: <0.001

Find critical t-value of t(n-2,alpha/2)==> t(28,0.025);
data criticalval;
tcrit= quantile("t",.025,28);
proc print data=criticalval;
run;
*t(28,.025) = -2.05

PVALUE METHOD: Yes, there is a significant relationship between
price difference and detergent demand since pvalue < 0.05.

REJECTION METHOD: Yes, there is a significant relationship between
price difference and detergent demand since 10.31> |-2.05|.
;

*========================================================;

*QUESTION: If the price difference were to increase by $1.00, 
what is an estimate for how much would we expect the detergent 
demand to increase?;

*Calculate a 95% (default) confidence interval for parameter estimates;
proc reg data=detergent plots=none;
model sales = price / clb;
run;

*We are 95% confident that the amount that the true mean detergent 
demand will change for a one dollar increase in the price difference
is between 213,570 bottles and 319,473 bottles.;


*Calculate a 90%  confidence interval for parameter estimates;
proc reg data=detergent plots=none;
model sales = price / clb alpha=0.1;
run;

*We are 90% confident that the amount that the true mean detergent 
demand will change for a one dollar increase in the price difference
is between 222,547 bottles and 310,496 bottles.;

*========================================================;

*QUESTION: How strong is the linear relationship between demand 
and price difference?;

proc reg data=detergent plots=none; 
model sales = price;
run;

*r = +sqrt(0.7915) = 0.889 ==> The linear relationhsip between
demand and price difference is positive and very strong.;


*========================================================;

*QUESTION: How much of the variation in demand can be explained 
by the price difference?;


* 79.15% of the variation of in detergent demand is explained by the 
presence of price difference in the model.;

*========================================================;

*QUESTION: The company has found that several sales periods
have a price difference of $0.35. What is a conservative estimate of their 
average demand for the sales periods? (NOTE: this is observation 15);

proc reg data=detergent plots=none; 
model sales = price / clm;
run;

*This is a "confidence interval".
We are 95% confident that the true mean value of the detergent demand
when the price difference is $0.35 is between 860,820 bottles and 888,570 bottles.

"standard error mean predict = s*sqrt[(1/n) + (x_p - xbar)^2/SS_xx]"
;

*========================================================;

*QUESTION: The company has just made a modification to their 
prices that will lead to a price difference of $0.35 for the 
next sales period. What is a conservative estimate of their 
demand for the next sales period? (NOTE: this is observation 15);

proc reg data=detergent plots=none; 
model sales = price / cli;
run;

*This is a "prediction interval".
We are 95% confident that the individual value of the detergent demand
when the price difference is $0.35 is between 808,380 bottles and 941,000 bottles.

"standard error mean predict = s*sqrt[(1/n) + (x_p - xbar)^2/SS_xx]"
;

data PGA;
infile '/folders/myshortcuts/SAS/PGADRIVER.txt' dlm='09'X firstobs=2;
input Player $ Distance Accuracy Index;
run;


