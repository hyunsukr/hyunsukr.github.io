*========================================================;
*========================================================;
	*Chapter 8: Residual Analysis (8.6-8.7)

	- Outliers: generally standardized residuals are larger than 3
			> To identify outliers in the y direction, we 
			examine studentizied residuals (Student Residual)
			> outliers in the x direction => we examine 
			leverage values (Hat Diag H) h_i > 2*hbar
	
	- Influential points: actually change the regression model
			> Jackknife procedures: deleted residuals (RStudent),
				deleted predictions (DFFITS), changes in parameter
				estimates (Dfbetas)
			> Cook's distance (Cook's D): uses deleted residual
			and leverage values => compare to 50th percentile
			of F distribution with (k+1),(n-k-1) degrees of freedom

	- Detecting correlation of Residuals
		> We test for first order autocorrelation using 
	the Durbin-Watson Statistic (see page 428 for specific tests):

		> Overall summary: 
		H0: The error terms are NOT correlated
		Ha: There error terms are positively or negatively correlated

1. If d<d(L,alpha/2) OR if (4-d)<d(L,alpha/2) we reject H0
2. If d>d(U,alpha/2) AND if (4-d)>d(U,alpha/2) we do not rejct H0
3. If d(L,alpha/2)< d < d(U,alpha/2) OR d(U,alpha/2)< (4-d)< d(U,alpha/2) the test is inconclusive
;			
	
		

*========================================================;
*========================================================;

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

*QUESTION: Are there any outliers or influential points;

proc reg data=homesales6 plots(label)=;*add the plots you need;
model price = size quality quality2 schooldum1 schooldum2 / ;*add thenew options;
run;


*========================================================;

*========================================================;
*========================================================;
*					EXAMPLE 8.	11						 ;
*========================================================;
*========================================================;

*The consumer  purchasing value fo the dollar from 1970 to 2007
is illustrated by the data from the table below. The buying
power of the dollar (compared with 1982) is listed for each year.
The first order model is fit using the method of least squares.;

data buypower;
input Year T VALUE;
cards;
1970 1 2.545
1971 2 2.469
1972 3 2.392
1973 4 2.193
1974 5 1.901
1975 6 1.718
1976 7 1.645
1977 8 1.546
1978 9 1.433
1979 10 1.289
1980 11 1.136
1981 12 1.041
1982 13 1.000
1983 14 0.984
1984 15 0.964
1985 16 0.955
1986 17 0.969
1987 18 0.949
1988 19 0.926
1989 20 0.880
1990 21 0.839
1991 22 0.822
1992 23 0.812
1993 24 0.802
1994 25 0.797
1995 26 0.782
1996 27 0.762
1997 28 0.759
1998 29 0.765
1999 30 0.752
2000 31 0.725
2001 32 0.711
2002 33 0.720
2003 34 0.698
2004 35 0.673
2005 36 0.642
2006 37 0.623
2007 38 0.600
;
run;

*========================================================;

*Question: Is there positive or negative correlation in the errors?;

proc reg data=buypower plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model value = t / ; *add the new option;
run;



*========================================================;
*========================================================;
*				GROUP PRACTICE EXAMPLES:  			     
																	  
1. Are any of the assumptions violated (including correlated errors)
when using the model identified from model selection?		
    
2. What transformation(s) might be appropriate?	

3. Are there any outliers or influential points?
 
 ;
*========================================================;
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


*========================================================;



*========================================================;
*========================================================;
*					EXAMPLE 8.8							 ;
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

*========================================================;
*========================================================;
*					EXAMPLE 8.9							 ;
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
