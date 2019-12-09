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
* STAGE 1;

*QUESTION: What relationship does selling price seem to have 
with the quantitative explanatory variables?;
proc sgplot data=homesales5;
scatter y=price x=size;
run;

proc sgplot data=homesales5;
scatter y=price x=quality; 
run;

*There is a linear relationship with size, a quadratic relationship
with quality.

*========================================================;
*QUESTION: Does there seem to be interaction between the 
quantitative explanatory variables?;

data homesales6;
set homesales5;
quality2 = quality**2; 
sizequal= size*quality;
sizequal2= size*quality2;
run;

proc reg data=homesales6 plots=none;
model price= size quality quality2 sizequal sizequal2;
test sizequal, sizequal2;
run;

*The partial F test for testing the interaction terms is not significant.;

*========================================================;

*STAGE 1 MODEL;

proc reg data=homesales6 plots=none;
model price= size quality quality2;
run;

* price = Beta_0 + Beta_1 * size + Beta_2 * quality + Beta_3 * quality^2 + e
;

*========================================================;
*STAGE 2;
*QUESTION: What relationship does selling price seem to have 
with the qualitative explanatory variable?;

proc sgplot data=homesales5;
vline school / response=price stat=mean markers  datalabel;
run;

*The mean price for each school district seems to be different.
So school would be significant in the model;

*There are no qualitative interactions to consider becasue there is only
qualitative variable;

*========================================================;

*QUESTION: What are the dummy variables needed for school
district;

* 
schooldum1 = {1 if school = B
			 {0	otherwise
							   
schooldum2 = {1 if school = C
			 {0	otherwise
 
 NOTE: School district A is the baseline.
;

*========================================================;
*QUESTION: Is "school district" significant?;


data homesales7; 
set homesales6; 
schooldum1 = 0; 
if school = 'B' then schooldum1 = 1; 
schooldum2 = 0; 
if school = 'C' then schooldum2 = 1; 
run; 

proc reg data=homesales7 plots=none;
model price = size quality quality2 schooldum1 schooldum2;
test schooldum1, schooldum2;
run;

*The partial F test is signifiacnt. School district should be
added to the model.;


*========================================================;

*QUESTION: What seems to be the appropriate regression model
for Stage 2?;

* price = Beta_0 + Beta_1 * size + Beta_2 * quality + Beta_3 * quality^2 
				+ Beta_4 * schooldum1 + Beta_5 * schooldum2 + e

			where schooldum1 = {1 if school = B
							   {0	otherwise
							   
			where schooldum2 = {1 if school = C
							   {0	otherwise
 
 NOTE: School district A is the baseline.
;

*========================================================;

*STAGE 3;

*QUESTION: Does there seem to be interaction between the 
quantitaive explanatory variables and school district?;
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

*QUESTION: Are the interactions significant?;

data homesales8;
set homesales7;
sizesch1 = size*schooldum1; 
sizesch2=size*schooldum2;
qualsch1= quality*schooldum1;
qual2sch1= quality2*schooldum1;
qualsch2= quality*schooldum2;
qual2sch2= quality2*schooldum2;
run;

proc reg data=homesales8 plots=none;
model price= size quality quality2 schooldum1 schooldum2 sizesch1 sizesch2;
test sizesch1, sizesch2;
run;

*The interaction between size and school district is not significant;

proc reg data=homesales8 plots=none;
model price= size quality quality2 schooldum1 schooldum2 qualsch1 qual2sch1 qualsch2 qual2sch2;
test qualsch1, qual2sch1, qualsch2, qual2sch2;
run;

*The interaction between quality and school district is not significant;

*========================================================;


*QUESTION: What seems to be the appropriate regression model
for Stage 2?;

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

proc reg data=homesales8 plots=none;
model price= size quality quality2 schooldum1 schooldum2;
run;

* What is the prediction equation 
price-hat = 78.4 + 1.44 * size + 12.98 * quality - 1 * quality^2 
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

proc reg data=homesales8 plots=none;
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
data homesales9; 
set homesales5; 
schooldum1 = 0; 
schooldum2 = 0; 
if school = 'A' then schooldum1 = 1; 
if school = 'C' then schooldum2 = 1; 
quality2 = quality**2; 
run; 


proc reg data=homesales9 plots=none;
model price = size quality quality2 schooldum1 schooldum2/clb;
run;

*We are 95% confident that the average selling price difference
of homes in school districts B and C is between $1,306.93 and $26,528.74.;

