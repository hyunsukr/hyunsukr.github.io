*========================================================;
*========================================================;
*Chapter 7: Some Regression Pitfalls (7.1-7.4)

	- With observational data, a statistically significant 
	relationship between a response y and a predictor variable
	x does not necessarily imply a cause-and-effect relationship.
	
	- Fitting a pth-order polynomial
		1. The number of levels of x must be greater than or
			equal to (p+1)
		2. The sample size n must be greater than (p+1)
			to allow sufficient degrees of freedom for
			estimating sigma^2
			
	- Interpretation of Beta parameters becomes more
		difficult as our model becomes more complex
	
	- The magnitude of the Beta-hat estimate does not imply
		that predictor is "more important". We must rely on
		t-test to determine which predictors are important
		
	- MULTICOLLINEARITY:
		> When explanatory variables are dependent on each other, 
			multicollinearity is present. Two or more explanatory
			variables are giving redundant information
		> Problems with Multicollinearity:	
			1. Increased the likelihood of rounding errors
			2. results are misleading or confusing (individual 
				Betas are insignificant)
			3. Signs of parameter estimates may be opposite
		> Detecting Multicollinearity: 
			1. Correlation tells of the pairwise linear relationships
				= correlation greater than 0.9 are strong, but even moderate 
				correlations present an issue
			2. VARIANCE INFLATION FACTOR (VIF)
				= VIF is a numerical statistic used to determine the presence of multicollinearity
				= VIF greater than 10 or average VIF >> 1 implies severe multicollinearity
				
						VIF_i = 1/(1 - R_i^2)
						

;
  

*========================================================;
*========================================================;
*             			EXAMPLE 7.1            			 ;
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

*QUESTION: Are any of the pairwise relationships between 
explanatory variables strong?;

proc corr data=prescript nosimple; 
var FloorSp PresPct Parking Income ShopCtr; 
run;

*Income & FloorSp and income & PresSp;

*========================================================;

*QUESTION: Is there any evidence that the variable income is 
providing redundant information?;

proc reg data=prescript plots=none;
model Income = FloorSp PresPct Parking ShopCtr; 
run;

*R^2 = 87.2% and Adj R^2 = 83.8%
Yes, there is evidence that income is providing redundant information.
Over 83% of its variation is explained by the other explanatory variables.; 

*========================================================;

*QUESTION: Is there any evidence of multicollinearity due to 
income or other explanatory variables?;

proc reg data=prescript plots=none;
model Sales = FloorSp PresPct Parking Income ShopCtr / vif; 
run;

*Although no VIF is greater than 10, the average VIF is greater 
than 1, so multicollinearity may be present.;
