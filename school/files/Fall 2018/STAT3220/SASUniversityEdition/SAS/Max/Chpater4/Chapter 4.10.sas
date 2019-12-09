*========================================================;
*========================================================;
* 		Chapter 4: Multiple Regression Analysis (4.10)


	- Key idea: The magnitude of the relationship between 
		one explanatory varaible and the response varaible 
		is dependent on a different explanatory variable.
		
	- The model: Interaction terms are multiplicative
			y = Beta_0 + Beta_1*x1 + Beta_2*x2 + Beta_3*x1*x2 + e
			
		> The slope of x1 is (Beta_1 + Beta_3*x2) is dependent on x2
		> The slope of x2 is (Beta_2 + Beta_3*x1) is dependent on x1
		
	-  We need the "parents" (x1 and x2) if we have the "child" (x1*x2)
	so you do not need to test the significance of 
;

*========================================================;
*========================================================;
*             			EXAMPLE 4.2            			 ;
*========================================================;
*========================================================; 
*A market research study is designed to investigate 
the relationship between how much consumers like the brand 
and the moisture content and sweetness of the product.;

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

*========================================================;

*QUESTION: What seems to be the relationship between likeness 
and moisture and sweetness levels?;

proc sgplot data=branding;
scatter y=likeness x=moisture; 
run;


proc sgplot data=branding;
scatter y=likeness x=sweetness;
run;


*========================================================;

*THINK: Do you expect there to be an interaction effect between 
sweetness and moisture? That means, do you expect to have a different 
magnitude of likeness vs moisture when you know the sweetness level? ;

*========================================================;

*QUESTION: Is there evidence of an interaction effect?;

proc sgplot data=branding;
scatter y=likeness x=moisture / group=sweetness datalabel=sweetness;
run;

*Yes, the slope of the relationship between moisture and likeness
is different depending on the sweetness level.;

proc sgplot data=branding;
scatter y=likeness x=sweetness / group=moisture datalabel=moisture;
run;

*========================================================;

*QUESTION: Is the interaction term significant?;

*First we have to make the interaction variable;
data branding1;
set branding; 
moistsweet=moisture*sweetness;
run;

proc reg data=branding1 plots=none;
model likeness = moisture sweetness moistsweet;
run;
*F Test tell u that null is all equal zero. If i fail to reject 
that they are all equal to zero that means
it is all equal to zero. Look at P values of interaction and independent compnents
if it is significant. 


*========================================================;

*QUESTION: What is the interval estimate for how much consumers like the 
brand on average when the moisture level is 7 and the 
sweetness level is 3?;

data branding_new;
moisture = 7;
sweetness = 3;
moistsweet = moisture*sweetness;
run;
data branding2;
set branding1 branding_new;
run;
proc reg data=branding2 plots=none;
model likeness = moisture sweetness moistsweet / clm;
run;


*========================================================;

*QUESTION: If the sweetness level increases by one unit, by how much will
the estimated likeness increase? (assume moistness is constant);



*========================================================;
*========================================================;
*            	 EXAMPLE 4.1 (revisited)         		 ;
*========================================================;
*========================================================;

*A real estate agency is interested in studying whether home size 
(in hundreds of square feet) and home quality (using a niceness rating on 
a scale from 1 to 10) influence the selling price of homes (in thousands 
of dollars). The agency would like to understand the relationship between 
these variables to better serve their clients.;

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

*THINK: Do you expect there to be an interaction effect between 
size and quality? That means, do you expect to have a different 
magnitude of price vs size when you know the quality rating? ;
data homesales_new;
set homesales;
quality_size = quality*size;
run;
proc reg data=homesales_new plots=none;
model price = quality size quality_size / clm;
run;
*Since this is not an experiment we can rely on the "group by"
scatter plot, so we use intuition do decide whether an interaction
might be present.;

*========================================================;

*QUESTION: Is there an interaction between size and quality?;


*========================================================;

*QUESTION: Is this model better than the model without the interaction?
Which would you prefer to use?;




		