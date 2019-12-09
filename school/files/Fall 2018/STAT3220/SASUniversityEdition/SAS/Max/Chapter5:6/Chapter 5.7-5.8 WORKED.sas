*========================================================;
*========================================================;
* 		Chapter 5: Principles of Model Building (5.7-5.8)

	- Model Building: writing a model that will provide a 
	good fit to a set of data and that will give good estimates 
	of the mean value of y and good predictions
	
	- Independent variables: quantitative or qualitative

	- We can include a qualitative variable in our model as 
		a predictor by creating a dummy variable
		~ Dummy variables take on the value of 0 or 1
		~ If a categorical variable has k levels then we must create
			k-1 dummy variables
			> We call the level the base level when x1 = 0 for each dummy variable
		~ We interpret the Betas as the difference in the average y between
		the dummy variable i-th level and the base level
		~ We can compare two levels that aren't the baseline by subtracting 
			their Betas
			
	- Interactions for qualitative variables
		~ The number of interaction terms will equal the number
		of main effect terms for one variable times the number 
		of main effect terms for the other
			> When we just calculate sample means, we automatically 
			assume there is no interaction, so we must use least 
			squares estimates
		~ When you have more than a two way interaction, you must add
		interactions at all levels up to the highest interaction.
			
	- NOTE: interval estimates for the difference between two categories
			require redefining the baseline.
			
;
*========================================================;
*========================================================;
*             	 EXAMPLE 5.1 			           		 ;
*========================================================;
*========================================================;
*A real estate agency is interested in studying whether home size 
(in hundreds of square feet) and home quality (using a niceness rating on 
a scale from 1 to 10) influence the selling price of homes (in thousands 
of dollars). The agency would like to understand the relationship between 
these variables to better serve their clients. The real estate agency has 
recently obtained information about school districts and has added this 
information to the analysis.;

*y= price, x1=size, x2=quality, "x3"=school district;

data homesales5;
input price size quality school $;
cards;
180    23  5  C
108.1  11  2  A
173.1  20  9  B
136.5  17  3  A
151    15  8  B
165.9  21  4  C
193.5  24  7  C
127.8  13  3  A
163.5  19  7  B
145.6  23  2  B
143.2  20  7  A
146.8  18  9  B
153.3  19  5  B
155.1  15  4  B
139.1  14  8  A
129.9  17  5  A
192.9  25  5  C
166.5  21  4  C
182.5  20  6  C
181.2  25  9  C
167    15  6  B
166.9  19  3  B
148.7  15  4  A
140.6  12  4  A
153    18  6  B
;
run;

*========================================================;

*QUESTION: What relationship does selling price seem to have 
with the explanatory variables?;
proc sgplot data=homesales5;
scatter y=price x=size;
run;

proc sgplot data=homesales5;
scatter y=price x=quality; 
run;

proc sgplot data=homesales5; 
scatter y=price x=school;
XAXIS DISCRETEORDER=unformatted; *this line puts the qualitative 
variable in alphabetical order, instead of order from the data;
run;

*There is a linear relationship with size, a quadratic relationship
with quality, and a relationship with school district (NOT LINEAR).

*========================================================;

*QUESTION: Does there seem to be interaction between the 
explanatory variables?;
proc sgplot data=homesales5;
scatter y=price x=size / group=school datalabel=school; 
run;

proc sgplot data=homesales5;
scatter y=price x=quality / group=school datalabel=school;
run;

*There does not appear to be an interaction because the SLOPES
are not different depending on school district. Only the intercepts
are different, which further implies the categorical variable is significant.;

*========================================================;

*QUESTION: What seems to be the appropriate regression model?;

* price = Beta_0 + Beta_1 * size + Beta_2 * quality + Beta_3 * quality^2 
				+ Beta_4 * schooldum1 + Beta_5 * schooldum2 + e

			where schooldum1 = {1 if school = B
							   {0	otherwise
							   
			where schooldum2 = {1 if school = C
							   {0	otherwise
 
 NOTE: School district A is the baseline.
;

*========================================================;

*QUESTION: What is the estimated regression line for this model?;
data homesales6; 
set homesales5; 
schooldum1 = 0; 
schooldum2 = 0; 
if school = 'B' then schooldum1 = 1; 
if school = 'C' then schooldum2 = 1; 
quality2 = quality**2; 
run; 

proc reg data=homesales6 plots=none;
model price = size quality quality2 schooldum1 schooldum2;
run;

* price-hat = 78.4 + 1.44 * size + 12.98 * quality - 1 * quality^2 
				+ 16.6 * schooldum1 + 30.5 * schooldum2

			where schooldum1 = {1 if school = B
							   {0	otherwise
							   
			where schooldum2 = {1 if school = C
							   {0	otherwise
;

*========================================================;

*QUESTION: What are the estimated lines of means?;

*School District A:
		price-hat(size, quality, A) = 78.4 + 1.44 * size + 12.98 * quality - 1 * quality^2 
										+ 16.6 * 0 + 30.5 * 0
				  					= 78.4 + 1.44 * size + 12.98 * quality - 1 * quality^2
				  
School District B:
		price-hat(size, quality, B) = 78.4 + 1.44 * size + 12.98 * quality - 1 * quality^2 
										+ 16.6 * 1 + 30.5 * 0
				 					= 95 + 1.44 * size + 12.98 * quality - 1 * quality^2
				  
School District C:
		price-hat(size, quality, C) = 78.4 + 1.44 * size + 12.98 * quality - 1 * quality^2 
										+ 16.6 * 0 + 30.5 * 1
				  					= 108.9 + 1.44 * size + 12.98 * quality - 1 * quality^2 

;

*========================================================;

*QUESTION: What is the interval estimate for the average difference in the 
selling prices of homes in school districts A and B?;

proc reg data=homesales6 plots=none;
model price = size quality quality2 schooldum1 schooldum2 / clb;
run;

*We are 95% confident that the average selling price difference
of homes in school districts A and B is between $5,852.34 and $27,299.29.;

*========================================================;

*QUESTION: What is the interval estimate for the average difference in the 
selling prices of homes in school districts A and C?;

*We are 95% confident that the average selling price difference
of homes in school districts A and C is between $13,991.56 and $46,995.74.;

*========================================================;

*QUESTION: What is the interval estimate for the average difference in the 
selling prices of homes in school districts B and C?;

*We can only use the SAS output to find a point estimate for this difference.
We cannot find the interval estimates this with the SAS output because we used 
A as the baseline, so we must redefine our baseline to find the intervals;
data homesales7; 
set homesales5; 
schooldum1 = 0; 
schooldum2 = 0; 
if school = 'A' then schooldum1 = 1; 
if school = 'C' then schooldum2 = 1; 
quality2 = quality**2; 
run; 


proc reg data=homesales7 plots=none;
model price = size quality quality2 schooldum1 schooldum2/clb;
run;

*We are 95% confident that the average selling price difference
of homes in school districts B and C is between $1,306.93 and $26,528.74.;

*========================================================;

*QUESTION: Does school district have a significant effect on 
selling price of homes?;

*Complete model;
proc reg data=homesales6 plots=none;
model price = size quality quality2 schooldum1 schooldum2;
run;

*Reduced model (ie. the model if the null is true);
proc reg data=homesales6 plots=none;
model price = size quality quality2;
run;

*Calculate the partial F statistic;
data partialFtest;
Fstat = ((2987.11839 -1626.31860)/(5-3))/(1626.31860/(25 -5 -1));
pvalue = SDF('F',Fstat,5 - 3 ,25 - 5 - 1);
Fcritical = quantile('F',.95,5 - 3 ,25 - 5 - 1);
run;

proc print data=partialFtest;
run;

* F test statistic: 7.94899	
P-value of the statistic: 0.003	
Critical F value: 3.52189
;

proc reg data=homesales6 plots=none;
model price = size quality quality2 schooldum1 schooldum2;
partialf: test schooldum1 schooldum2;
run;

*By both the p-value method and rejection method, we reject the null
hypothesis of the partial F test. We conclude that at least one of Beta_4
or Beta_5 is not equal to zero. Therefore, we conclude that school
district has a significant effect on price.;

*========================================================;

 