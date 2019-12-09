*========================================================;
*========================================================;
*Chapter 7: Some Regression Pitfalls (7.5-7.6)

	- Extrapolation: When you predict y for values of the 
		independent variables that are outside the 
		experimental region
			> Hidden Extrapolation- x's fall within the 
			range of each individual x, but outside the 
			jointly defined experimental region
			
	- Variable transformation
		> transform y variable to better satisfy regression 
			assumptions OR to make the model better at approximating
			the mean of the transformed variable
		> transform x variables to achieve a model that provides
			a better approximation to E(y)
		> examples if x and y are the original variables:
			- x^2
			- e^-x
			- ln(y)
			- ln(x)
			- etc, any combination of transformed x's and y
;
*========================================================;
	*Chapter 8: Residual Analysis (8.1-8.5)

	- To check that the regression assumptions are satisfied, 
		we examine the residuals
		> regression residual: e-hat= y_i=yhat_i
			-Properties: 
			1. mean of ehat_i = 0 because sum of ehat_i = 0
			2. the standard deviation of residuals = s
	
	1. Mean 0 
		> Met => E(e)=0
		> Violated => lack of fit, need new model (transform x)
		> Check: plot residual vs explanatory or predicted values
			look for trends, dramatic changes in variability, etc
		
	2. Constant Variance for all levels of independent variables
		> Met => homoscedastic
		> violated => heteroscedastic (transform y to correct)
		> Check: residuals form a horizontal band around 0 on 
			residual vs explanatory/predicted plot
			look for fanning out/in patterns
		> Test of equal variance can only be performed in SLR

	3. Normally Distributed
		> Violated: residuals do not follow a normal curve (transform y to correct)
		> Check: distribution of errors in histogram or normal probability plot
		> statistical tests tend to have low power
		> Read references about Box-Cox for selecting appropriate transformation

	4. Independent Errors (Chapter 8.7)
			
	- Regression is robust against minor violations to these assumptions,
		especially the normality assumption. However, deviations from
		constant variance often lead to serious prediction errors
;

*========================================================;
*========================================================;
*					EXAMPLE 8.1							 ;
*========================================================;
*========================================================;
*An electric utility company is interested in understanding the 
relationship between peak-hour demand and total energy usage during the 
month to ensure that their generation system is sufficiently large to meet 
the maximum demand. The company randomly selected 53 customers during the 
month of August for the analysis.;

data utility;
 input usage demand;
 cards;
679  0.79
292  0.44
1012  0.56
493  0.79
582  2.7
1156  3.64
997  4.73
2189  9.5
1097  5.34
2078  6.85
1818  5.84
1700  5.21
747  3.25
2030  4.43
1643  3.16
414  0.5
354  0.17
1276  1.88
745  0.77
435  1.39
540  0.56
874  1.56
1543  5.28
1029  0.64
710  4
1434  0.31
837  4.2
1748  4.88
1381  3.48
1428  7.58
1255  2.63
1777  4.99
370  0.59
2316  8.19
1130  4.79
463  0.51
770  1.74
724  4.1
808  3.94
790  0.96
783  3.29
406  0.44
1242  3.24
658  2.14
1746  5.71
468  0.64
1114  1.9
413  0.51
1787  8.33
3560  14.94
1495  5.11
2221  3.85
1526  3.93
;
run;

*========================================================;

*QUESTION: Does a linear relationship seem appropriate?;

proc sgplot data=utility;
 scatter y=demand x=usage;
run;

*There appears to be a linear trend in the data, so a linear relationship 
would be appropriate;

*========================================================;

*QUESTION: Are any of the regression assumptions violated when using total usage to 
explain demand?;

proc reg data=utility plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model demand=usage;
run;


/* 

1. Mean 0 - NO: There is no clear pattern in residual plots to indicate a lack of fit;
2. Constant Variance - YES: There is a fanning out pattern in the residuals 
indicating  increasing variation in the errors;
3. Normally Distributed - YES: distribution of errors in histogram appears skewed left
Additionally, the QQplot deviates from the straight line;

Since the constant variance assumption is violated, we cannot use the model,
we must do a transformation;
*/ 

*========================================================;
 
*QUESTION: What transformation seems most appropriate to correct the violation?;

data utility2;
 set utility;
 sqrtdemand=demand**0.5;
 lndemand=log(demand);
run;

proc sgplot data=utility2;
 scatter y=sqrtdemand x=usage;
run;

proc sgplot data=utility2;
 scatter y=lndemand x=usage;
run;

*Square root transformation seems to remain a linear relationship;

*========================================================;

*QUESTION: Does the transformation correct the violation?;

proc reg data=utility2 plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model sqrtdemand=usage;
 run;
 
*There is no longer a fanning out in the residuals, so the transformation seems
to have corrected the non-constant variance violation; 

*========================================================;

*QUESTION: What is a conservative estimate for peak-hour demand 
when total monthly usage is 679 kWh? HINT: Observation #1;

proc reg data=utility2 plots=none;
 model sqrtdemand=usage /  cli clm;
 run;

* yhat*=1.2292, prediction interval= (0.2842	2.1742)
Confidence interval for the mean of the square root (1.0708, 1.3876);

*We can transform back for the point prediction and say:
We predict the estimate for a peak-hour demand when monthly usage is 679 kWh
to be (1.2292)^2. We are 95% confident that the peak-hour demand 
is between (0.2842)^2 and (2.1742)^2 when the total energy usage is 679 kWh.;

*But we cannot transform to interpret the mean so we must say:
We are 95% confident that the mean of the square root of peak-hour demand 
is between 1.0708 and 1.3876 when the total energy usage is 679 kWh.;

*Since interpreting the mean is sometimes not logical for transformations, 
we sometimes revert to the untransformed model if there is not a serious
violation of constant variance.;

proc reg data=utility plots=none;
 model demand=usage / cli clm;
 run; 
 
*Prediction interval of untransformed data: (-1.5425, 4.8812). 
Since this is not close to our interval from the transformed data, 
we should use the transformation. Additionally the violation of 
constant variance was too severe.;


*========================================================;
*========================================================;
*					EXAMPLE 8.2							 ;
*========================================================;
*========================================================;
*A real estate agency is interested in studying whether home 
size (in hundreds of square feet), home quality (using a niceness 
rating on a scale from 1 to 10), and school district influence the 
selling price of homes (in thousands of dollars). The agency would 
like to understand the relationship between these variables to better 
serve their clients.;
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

*RECALL: We created two dummy variables for the categorical variable "School"
We also determined the relationship between quality and rating was quadratic;

data homesales6; 
set homesales5; 
schooldum1 = 0; 
schooldum2 = 0; 
if school = 'B' then schooldum1 = 1; 
if school = 'C' then schooldum2 = 1; 
quality2 = quality**2; 
run; 

*========================================================;

*QUESTION: Are any of the assumptions violated when using the model 
including size, quality, the square of quality, and school district 
to explain selling price?;

proc reg data=homesales6 plots(only)=(residualbypredicted 
residualplot qqplot residualhistogram);
model price = size quality quality2 schooldum1 schooldum2; 
run;




*There do not appear to be any clear violations of constant variance;

*========================================================;
*========================================================;
*				GROUP PRACTICE EXAMPLES:  			     	
	
1. Are any of the regression assumptions violated?		
    
2. What transformation(s) might be appropriate?	

3. How will you interpret a predicted value?
 
 ;
*========================================================;
*========================================================;



*========================================================;
*========================================================;
*					EXAMPLE 8.3							 ;
*========================================================;
*========================================================;
*The government is conducting a study to understand the 
relationship between gas mileage and various factors. They have chosen
to focus specifically on the effects that the weight of the car (in pounds)
has on gas mileage. Data were collected from a sample of 32 cars.;

data mpg;
 input mpg weight;
 cards;
18.9 3910
17  2860
20  3510
18.25 3890
20.07 3365
11.5 4215
22.12 3020
21.47 3180
34.7 1905
30.4 2320
16.5 3885
36.5 2009
21.5 2655
19.7 3375
20.3 2700
17.8 3850
14.39 5290
14.89 5185
17.8 3910
16.4 3660
23.54 3050
21.47 4250
16.59 3850
31.9 2275
29.4 2150
13.27 5430
23.9 2535
19.73 4370
13.9 4540
13.27 4715
13.77 4215
16.5 3660
;
run;

*========================================================;

*QUESTION: Are any of the regression assumptions violated when using 
the weight to explain mileage?;

proc reg data=mpg plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model mpg=weight;
 run;
 
/*
1. Mean 0 - NO: there is no distinct pattern to indicate a lack of fit;
2. Constant Variance - NO: The errors are evenly spread, but have a pattern;
3. Normally Distributed - NO: distribution of errors in histogram appears bell-shaped
However, the QQplot shows a curved trend;


It would be best to use a quadratic relationship
*/ 

*========================================================;

*QUESTION: What transformation might be appropriate?;
data mpg2;
set mpg;
sqrtmpg=mpg**.5;
run;

proc reg data=mpg2 plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model sqrtmpg=weight;
run;


*========================================================;

*========================================================;
*========================================================;
*					EXAMPLE 8.4							 ;
*========================================================;
*========================================================;
*A company is interested in evaluating the impact of its 
marketing expenditure (in thousands of dollars) on profit 
(in thousands of dollars). To conduct this analysis, the company 
has collected data from 36 randomly selected months.;

data profit;
 input marketing profit;
 cards;
1000  1050
1125  1150
1087  1213
1070  1275
1100  1300
1150  1300
1250  1400
1150  1400
1100  1250
1350  1730
1275  1350
1375  1450
1175  1300
1200  1300
1175  1275
1300  1375
1260  1285
1330  1400
1325  1400
1200  1285
1225  1275
1090  1135
1075  1400
1080  1275
1080  1150
1180  1250
1225  1370
1175  1225
1250  1280
1250  1300
750    1050
1125  1175
1275  1600
900    1250
900    1300
850    1200
;
run;

*========================================================;

*QUESTION: Does a linear relationship seem appropriate?;

proc sgplot data=profit;
 scatter y=profit x=marketing;
run;
*A linear relationship appears to be appropriate;

*========================================================;

*QUESTION: Are any of the regression assumptions violated when using marketing 
expenditure to explain profit?;

proc reg data=profit plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model profit=marketing;
 run;
 
*There do not appear to be any severe violations of the assumptions;


*========================================================;


*========================================================;
*========================================================;
*					EXAMPLE 8.5							 ;
*========================================================;
*========================================================;
*A research engineer who wants to study the relationship 
between the wind velocity and the DC output generated from 
a windmill collects data from 25 randomly selected times.;

data windmill;
 input velocity DCoutput;
 cards;
5  1.582
6  1.822
3.4  1.057
2.7  0.85
10  2.236
9.7  2.386
9.55  2.294
3.05  0.858
8.15  2.166
6.2  1.866
2.9  0.953
6.35  1.93
4.6  1.562
5.8  1.737
7.4  2.088
3.6  1.137
7.85  2.179
8.8  2.112
7  1.8
5.45  1.501
9.1  2.303
10.2  2.31
4.1  1.194
3.95  1.144
2.45  0.823
;
run;

*========================================================;

*QUESTION: Are any of the regression assumptions violated when using velocity to 
explain DC output?;

proc reg data=windmill plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model DCoutput=velocity;
 run;
*The residuals indicate decreasing variation (fanning in);

*========================================================;

*QUESTION: What transformation seems appropriate?;

data windmill2;
set windmill;
transdc=DCoutput**.5;
velsq=Velocity**2;
run;

proc reg data=windmill2 plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model transdc=velocity velsq;
 run;
 
*it appears that a square root transformation of Y and adding a quadratic term
of X is appropriate to correct for the assumptions.;

 
*========================================================;


 
*========================================================;
*========================================================;
*					EXAMPLE 8.6							 ;
*========================================================;
*========================================================;
*A medical researcher is interested in the relationship 
between weight and systolic blood pressure in men aged 25 to 35. 
Information is gathered from a random sample of 26 men.;

data bp;
 input weight bp;
 cards;
165 130
167 133
180 150
155 128
212 151
175 146
190 150
210 140
200 148
149 125
158 133
169 135
170 150
172 153
159 128
168 132
174 149
183 158
215 150
195 163
180 156
143 124
240 170
235 165
192 160
187 159
;
run;

*========================================================;

*QUESTION: Are any of the regression assumptions violated when using weight to 
explain blood pressure?;

proc reg data=bp plots(only)=(residualbypredicted residualplot qqplot 
  residualhistogram);
 model bp=weight;
 run;
*There appears to be clear violations of normality. ;

*========================================================;

*QUESTION: What transformation seems appropriate?;

*It does not appear that there are any transformations to correct for these assumptions
analyzing this model would not be appropriate;

*========================================================;


*========================================================;
*========================================================;
*					EXAMPLE 8.7							 ;
*========================================================;
*========================================================;
*A marketing research firm has obtained prescription sales 
data for 20 independent pharmacies. The firm has collected the average 
weekly prescription sales over the past year (in thousands of dollars), 
the floor space (in square feet), the percentage of floor space allocated 
to the prescription department, the number of parking spaces available to 
the store, the weekly per capita income for the surrounding community 
(in hundreds of dollars), and an indicator for whether the pharmacy is 
located in a shopping center.;

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

*RECALL: In chapter 5.1 we used model selection and decided the best model
for these data was: Sales = FloorSp PresPct;



*========================================================;

*QUESTION: Are any of the assumptions violated when using the model 
identified from model selection?;
proc reg data=prescript plots(only)=(residualbypredicted 
residualplot qqplot residualhistogram);
model Sales = FloorSp PresPct;
run;

*No clear violations;

*========================================================;


*========================================================;
*========================================================;
*					EXAMPLE 8.8						 ;
*========================================================;
*========================================================;
*A soft drink bottler is aware that the carbonation level of 
the soft drink is affected by the temperature of the product when opened. 
To better understand this relationship, they design an experiment to 
measure the carbonation level at three different temperatures.;

data soda;
input temp bubbles;
cards;
30.5 5.36
30.5 10.17
30.5 2.98
30.5 7.06
30.5 3.96
30.5 9.66
31  2.6
31  2.4
31  6.92
31  3.17
31  3.51
31  5.18
31.5 17.32
31.5 15.6
31.5 16.12
31.5 6.19
31.5 15.3
31.5 14.83
;
run;

*RECALL: We determined that a quadratic relationship was appropriate in Chapter 4;
data soda2;
set soda;
temp2=temp**2;
run;


*========================================================;

*QUESTION: Are any of the assumptions violated when using the quadratic 
model of temperature to explain the carbonation level?;
proc reg data=soda2 plots(only)=(residualbypredicted 
residualplot qqplot residualhistogram);
model bubbles = temp temp2;
run;

*A fanning out pattern in the residuals indicate a violation of nonconstant variance;
*The QQ plot and Histogram also indicate violations of normality;

*========================================================;


*========================================================;

*========================================================;
*========================================================;
*					EXAMPLE 8.9						 ;
*========================================================;
*========================================================;
*A market research study is designed to investigate the 
relationship between how much consumers like the brand and the moisture 
content and sweetness of the product.;
data branding;
input likeness moisture sweetness;
cards;
59 4 2
56 4 2
73 4 4
76 4 4
70 6 2
65 6 2
80 6 4
83 6 4
79 8 2
81 8 2
87 8 4
93 8 4
95 10 2
94 10 2
95 10 4
100	10 4
;
run;

*RECALL: We determined that there was an interaction between moisture and sweetness;

data branding2;
set branding;
moistsweet = moisture*sweetness; 
run;


*========================================================;

*QUESTION: Are any of the assumptions violated when using the model 
including moisture, sweetness, and their interaction to explain brand 
preference?;
proc reg data=branding2 plots(only)=(residualbypredicted 
residualplot qqplot residualhistogram);
model likeness = moisture sweetness moistsweet;
run;

*There do not appear to be any clear violations of constant variance;
*The QQPlot might indicate a violation of Normality;

*========================================================;


*========================================================;

*========================================================;
*========================================================;
*					EXAMPLE 8.10						 ;
*========================================================;
*========================================================;
*Scientists are testing several variables to see what variables 
most influence the measure of heat treating and they determine to focus 
on two variables – the duration of the carburizing cycle of the process 
and the duration of the diffuse cycle of the process.;

data heat;
input soaktime difftime pitch;
cards;
0.58  0.25  0.013
0.66  0.33  0.016
0.66  0.33  0.015
0.66  0.33  0.016
0.66  0.33  0.015
0.66  0.33  0.016
0.66  0.5 0.014
1 0.58  0.021
1.17  0.58  0.018
1.17  0.58  0.019
1.17  0.58  0.021
1.17  0.58  0.019
1.17  0.58  0.021
1.2 1.1 0.025
2 1 0.025
2 1.1 0.026
2.2 1.1 0.024
2.2 1.1 0.025
2.2 1.1 0.024
2.2 1.1 0.025
2.2 1.1 0.027
2.2 1.5 0.026
3 1.5 0.029
3 1.5 0.03
3 1.5 0.028
3 1.66  0.032
3.33  1.5 0.033
4 1.5 0.039
4 1.5 0.04
4 1.5 0.035
12.5  1.5 0.056
18.5  1.5 0.068
;
run;

*========================================================;


*========================================================;

*QUESTION: Are any of the assumptions violated when using the lengths 
of the two processes to estimate the pitch?;
proc reg data=heat plots(only)=(residualbypredicted residualplot 
qqplot residualhistogram);
model pitch = soaktime difftime;
run;

*Possible violations of constant variance, could be due to influential observations;

*========================================================;