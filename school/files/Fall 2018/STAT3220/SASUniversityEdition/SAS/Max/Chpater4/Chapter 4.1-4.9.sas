*========================================================;
*========================================================;
* 	Chapter 4: Multiple Regression Models (4.1-4.9)
		
	- Multiple Linear Regression model
  		~ The simple linear regression model is 
				y	  = Beta_0 + Beta_1 * x1 + Beta_2 * x2 + ...+ Beta_k * xk+ e
		-MLR model = 
				y = Beta_0 + Beta_1 * x1 +... + Beta_k * xk + epsilon
	
		~ Parameter interpretation of Beta_i: if xi is increased by one unit while
			keeping all other explanatory variables held constant, then
			the average of the response will increase by Beta_i
		~ Experimental region: Range of the combinations of the observed values
			of x1, x2, ..., xk
		~ independent variables can be quantitative (raised to any 
			power) or qualitative

	- STEPS TO MLR:
		1. Collect data
		2. Hypothesize a model through Exploratory Data Analysis
			= Check the individual relationship between xi's and y
			= Check the relationship between explanatory variables (Ch 7)
		3. Estimate parameters using least squares
			- in SLR 
				- Minumum sum squares error
				- Zero error
			- in MLR
				- For a k dimension plane the minimum squares error and zero error
				- ?Constant variance?
		4. Specify the distribution of the errors, by calculating the estimated 
			standard deviation
		5. Evaluate the utility of the model
		6. Check the assumptions (Ch 8)
			= They are the same as SLR, but we instead are looking at 
				"a set of xi's"
		7. Use the model for prediction or estimation
	- NOTES ON PARAMETER ESTIMATOR ESTIMATOR
		- Parameters
			- Unknown
			- Constant
			- Comes from the population. 
			- u (Mu)
			- B_i (regression parameter)
			- sigma^2 (regression paramter
			- sigma (popilation) (standard deviation)
		- Estimator
			- Random Variable
				- Have a probability distribution.
			- Before we collect data
			- X_bar
			- B_hat_i (sometimes uses b_i)
				- Least squares estimate
				- Becuase we have assumptions about the errors.
			- s^2 = MSE
			- s = (MSE) ^0.5
		- Estimate
			- Calculated from data
			- x_bar = #
			- "parameter estimate" = #
			- "mean squared error" = #
			- "Root MSE" = #
	- Model Assumptions
		~ For any given set of x values of x1,...,xk, e has
			1. A normal probability distribution
			2. Centered at 0
			3. with a variance of sigma^2
			4. additionally all errors are statistically independent
		~ NOTE: "linear" regression implies E(y) is a linear function
			of the unknown parameters
			
	- First order model
		~ does not include higher-order terms
		~ x's are not functions of other independent variables
	
	- Fitting the model: Least Squares
		~ We are still minimizing SSE, but the full calculation
		requires matrix algebra (Appendix B)

	- Estimation of sigma^2
		~ We will still estimate sigma^2 with MSE and sigma with s
	
			MSE = SSE/(n-k-1) , where k is the number of predictors
								and k+1 is the number of parameters including Beta_0
			- In simple linear regression k = 1 which is why we do MSE = SSE/(n-2) for SLR
			- s^2 = MSE = SSE/(n-k-1)
		~ the error of the estimation will be approximately 2*s
		~ Smaller s, means smaller residuals on average (what we want)
			> more accurate prediction
			> smaller intervals	
  			
  	- Model Utility: F-test
  		- Is the model good...
  			- For SLR we only needed to do T-test for beta_1
  				- Only needed to test for slope
  			- For MLR
  				- Why can't we do multiple T-Test for multiple betas?
  					- Probability of a type one error
  					- For each individual test we have alpha = 0.05
  						- We can get alpha inflation. 
		~ null: all Beta_i = 0
		~ Alternative: at least one Beta_i does not equal 0
		~ test statistic: F = MSR/MSE has k, n-k-1 DF
			- How to get MSE
				- MSE = SSE / (n-k-1)
					- SSE = Unexplained
				- MSR = SSR / (k)
					- SSR = explained
					- k = number of predictors 
				- F distribution is scewed right. Only has positive values
		~ NOTE: Just because we have a "significant" model, does not
			mean it is necessarily the "best" model

	- Inference about individual Beta parameters		
		~ our test in MLR is the same as SLR, EXCEPT our DF are n-k-1
			> SLR k = 1, so df is n-2
			
	- Multiple Coefficients of Determination: R^2, adj R^2, 
		~ R^2: multiple coefficient of determination = SSR/SST
		> always increases when more parameters are added,
			whether they contribute new information or not
	- Adjusted R^2 = 1- [(n-1)/ (n-k-1)]*(1 - R^2)
		> Only increases if additional predictors add information to the model
		
	- Estimation and Prediction: Let x_p be a specific point of interest
		> The "confidence interval" is an interval estimate for E(y)
			~ The mean value of y given a particular set of x values
		> The "prediction interval" is an interval estimate for y
			~ predicting a particular value of y for a given 
			particular set of x values
			
  ;  
*========================================================;
*========================================================;


*========================================================;
*========================================================;
*             			EXAMPLE 4.1            			 ;
*========================================================;
*========================================================; 
*A real estate agency is interested in studying whether home size 
(in hundreds of square feet) and home quality (using a niceness 
rating on a scale from 1 to 10) influence the selling price of 
homes (in thousands of dollars). The agency would like to understand 
the relationship between these variables to better serve their clients.;

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
;
run;

*========================================================;

*QUESTION: Do the scatterplots show a linear relationship between 
the explanatory variables and selling price?;

proc sgplot data=homesales;
scatter y=price x=size;
run;

proc sgplot data=homesales;
scatter y=price x=quality;
run;



*========================================================;

*QUESTION: What is a potential multiple linear regression 
model for home sales? 

;

*========================================================;

*QUESTION: What is the corresponding potential prediction equation?;



*========================================================;

*QUESTION: What are the estimated coefficient values?;
proc reg data=homesales plots=none;
model price = size quality;
run;



*========================================================;

*QUESTION: What is the estimated standard deviation of the model?;



*========================================================;

*QUESTION: What is the predicted selling price for a home 
that is 1500 square feet and has a quality rating of 8?;

*"plug in directly method";
data hsest;
yhat = 29.34681 + 5.61281*15 + 3.83442*8;
*Make a dataset since SAS is not a calculator...;

proc print data=hsest;
run;

*If the desired prediction was a recorded observation we can use
  "/p" in the MODEL statment (This was observation # 5);
proc reg data=homesales plots=none;
model price = size quality / p;
run;

*If the desired prediction was not a recorded observation we have two options;

*1a. add a line to the original data with a missing y value;
* put a period for missing value in the dataset;
data homesalesp;
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
. 15 8
;
run;

*1b. Then run the "/p" statement the last line will be the prediction;

proc reg data=homesalesp plots=none;
model price = size quality / p;
run;

proc reg data=homesalesp plots=none;
model price = size quality / clm;
run;

*2a. Or we can make a data set of a single observation and "set" it
	with the original data
	- This is just one line of data 
		- price is missing
	;
	
data homesalespre;
price= .;
size= 15;
quality = 8;
run;

* This is merging the two datasets together; 
data homesales1;
set homesales homesalespre;
run;


*2b. Then run the "/p" statement the last line will be the prediction;

proc reg data=homesales1 plots=none;
model price = size quality / p;
run;

*========================================================;

*QUESTION: What is the predicted selling price for a home that is 1900 
square feet and has a quality rating of 6?;




*========================================================;

*QUESTION: What proportion of the variation in selling price 
can be explained by the relationship with home size and home quality?;

proc reg data=homesales plots=none;
model price = size quality;
run;



*========================================================;

*QUESTION: What proportion of the variation in selling price 
can be explained by the relationship with home size?;

proc reg data=homesales plots=none;
model price = size;
run;



*========================================================;

*QUESTION: What proportion of the variation in selling price 
can be explained by the relationship with home quality?;

proc reg data=homesales plots=none;
model price = quality;
run;



*========================================================;

*QUESTION: Does adding "quality" as a predictor really account for more variance?;
proc reg data=homesales plots=none;
model price = size quality;
run;




*Compare to F value from rejection region;
data cutoff;
fcritical=quantile('F',.95,2,7);
proc print data=cutoff;
run;

*========================================================;

*QUESTION: Which of the predictor variables is least significant in 
explaining home selling prices?;

proc reg data=homesales plots=none;
model price = size quality;
run;


*========================================================;

*QUESTION: What are the 99% confidence intervals for 
Beta_1 and Beta_2?;




*========================================================;

*What is the 95% interval estimate for the average 
selling price for homes that are 1500 square feet and have a quality 
rating of 8?;

proc reg data=homesales1 plots=none;
model price = size quality / clm;
run;


*Finding t critical value to calculate "by hand";
data cutoff;
fcritical=quantile('T',.975,7);
proc print data=cutoff;
run;

*========================================================;

*QUESTION: What is the 95% interval estimate for the selling 
price for a new listed home that is 1500 square feet and has a quality 
rating of 8?;
*cli = prediciton;
proc reg data=homesales1 plots =none;
model price = size quality / cli clm clb;
run;


*========================================================;

*QUESTION: What is the 95% interval estimate for the selling price for 
a newly listed home that is 1900 square feet and has a quality rating of 6?;
data homesalespre2;
price= .;
size= 19;
quality = 8;
run;

* This is merging the two datasets together; 
data homesales3;
set homesales homesalespre2;
run;
proc reg data=homesales3 plots =none;
model price = size quality / cli clm clb;
run;

