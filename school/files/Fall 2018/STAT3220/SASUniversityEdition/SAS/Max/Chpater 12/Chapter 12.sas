*========================================================;
*========================================================;
*			Chapter 12: The Analysis of Variance 
		for Designed Experiments (12.1-12.3,12.7,12.9) 
		
	- ANOVA: Method used to compare means across treatments
	
~ NOTE: the notation for sum of squares is a bit different
	
	- within sample variation: SSE/(n1+n2-2)
		> SSE = variability unexplained by the difference 
		in sample means
	- between sample variation: SST/1
		> SST = variability explained by the difference 
		in sample means
	- SS(Total) = SSE + SST
	- [SST/(p-1)]/[SSE/(n1+n2-2)] ~ F(p-1, n1+n2-2)
	
	- Completely Randomized Design (CRD) for p treatments
		= p treatments are randomly assigned to experimental units
		OR
		= independent samples are drawn from each of the p populations
		
	- ANOVA through regression:
		- One Factor with p levels (CRD)
		- Use p-1 dummy variables, arbitrarily select 
			a base level treatment
		- Conduct a nested F test on p-1 dummy variables
			> Reduced model is E(y) = Beta_0
		- The test statistic will just be the overall F test
		
	- ANOVA through computing formulas:
		- If the treatments differ SSE should be much smaller than SST	 
		- F = [SST/(p-1)]/[SSE/(n1+n2-2)] ~ F(p-1, n1+n2-2)
		- Again, this is the same as overall F test (ANOVA TABLE)
		
	- Confidence intervals for means: use methods for one sample
		or difference in 2 samples (Ch 1.8,1.10- Intro Stats)
		
	- Post-Hoc Analysis (Tukey's Multiple Comparison)
		> WHEN: Only when the overall ANOVA is significant, do we
			perform a follow up analysis to compare individual means
		> WHY: If we conduct a series of confidence intervals or 
			hypothesis tests at an alpha significance, the true
			probability of a Type I error is much higher than alpha
		> HOW: Compute an absolute cutoff of difference in means
			based on the studentized range. Any difference in sample 
			means that exceed that difference lead to a conclusion that 
			the population means differ. This is done also by setting
			an "experimentwise error rate"
		> NOTE: We will only use this method for balanced designs
		
	- ANOVA Assumptions:
		1. Populations for EACH TREATMENT are normal
			> Check histogram or probability plot for y 
				for each treatment. If samples are too small, 
				combine all the data and check one plot
			> Test of significance are available, but have low power
			> ANOVA is robust against nonnormal populations, but
				if there is a serious violation, you should transform
				the response (ie sqrt or ln)
		2. Population variances of treatments are equal
			> Look at a boxplot or dot plot and compare spread visually
			> Test of significance: Bartlett's (normal populations) 
				or Levene's (nonnormal populations)
				= Null for both is that populations have equal variance
			> ANOVA is robust against unequal variance for balanced designs, 
				but in other cases or if the violation is severe, 
				perform a variance stabilizing transformation

;
*========================================================;
*========================================================;


*========================================================;
*========================================================;
*					EXAMPLE 12.1						 ;
*========================================================;
*========================================================;

*The Journal of Hazardous Materials (July 1995) published 
the results of a study of the chemical properties of three 
different types of hazardous organic solvents used to clean 
metal parts: aromatics, chloroalkanes, and esters. One variable 
studied was sorption rate, measured as mole percentage. Independent
samples of solvents from each type were tested and their 
sorption rates were recorded.;

data sorprate;
input SOLVENT $ RATE;
cards;
1 1.06
1 0.95
1 0.79
1 0.65
1 0.82
1 1.15
1 0.89
1 1.12
1 1.05
2 1.58
2 1.12
2 1.45
2 0.91
2 0.57
2 0.83
2 1.16
2 0.43
3 0.29
3 0.43
3 0.06
3 0.06
3 0.51
3 0.09
3 0.44
3 0.10
3 0.17
3 0.61
3 0.34
3 0.60
3 0.55
3 0.53
3 0.17
;
run;
*========================================================;

*QUESTION: What kind of experimental designed is employed here?;
*Completely randomized design;
*Three factors;


*========================================================;

*QUESTION: Is there evidence of differences among the mean
sorption rates of the three organic solvent types?;

proc sgplot data=sorprate;
scatter x=solvent y=rate;
run;

proc sgplot data=sorprate;
	vline solvent /response=rate stat=mean markers datalabel;
run;

proc sgplot data=sorprate;
vbox rate/ category=solvent;
run;

*========================================================;

*QUESTION: Test is there is a statistical difference between
the three means.;

*Regression method;
*chose esters as base level;
data sorprate2;
set sorprate;
aroma=0;
chloro=0;
if solvent='1' then aroma=1;
if solvent='2' then chloro=1;
run;

proc reg data=sorprate2 plots=none;
model rate=aroma chloro;
test aroma,chloro;
run;
*nested f test check if two or more betas are equal to each other;

*Computation method;
proc anova data=sorprate;
class solvent;
model rate=solvent;
run;


*========================================================;

*QUESTION: Determine the pairs of solvent types that are 
significantly different. Use an experiment error rate of 0.05;

proc anova data=sorprate;
class solvent;
model rate=solvent;
means solvent/ tukey lines;
run;


*========================================================;

*QUESTION: Use an experiment error rate of 0.1. What changes?;




*========================================================;

*QUESTION: Do these data violate the assumptions of ANOVA?;

*1. Populations for EACH TREATMENT are normal;

proc sgpanel data=sorprate;
panelby solvent;
histogram rate;
density rate /type=normal;
run;


proc sgplot data=sorprate;
histogram rate;
density rate /type=normal;
run;



*2. Population variances of treatments are equal;

*Boxplot;
proc sgplot data=sorprate;
vbox rate/ category=solvent;
run;

*Bartlett's test (are variances different);
proc anova data=sorprate;
class solvent;
model rate=solvent;
means solvent/ hovtest=bartlett;
run;

*Levene's test (only if response is non normal);
proc anova data=sorprate;
class solvent;
model rate=solvent;
means solvent/ hovtest=levene(type=abs);
run;


data sorprate3;
set sorprate;
sqrtrate=sqrt(rate);
lnrate=log(rate);
run;

proc anova data=sorprate3;
class solvent;
model sqrtrate=solvent;
means solvent/ hovtest=bartlett;
run;

proc anova data=sorprate3;
class solvent;
model lnrate=solvent;
means solvent/ hovtest=bartlett;
run;


*========================================================;

*QUESTION: What is a 95% confidence interval for the difference 
in mean of the square root of sorption rate between aromatics 
and esters? ;



*========================================================;
*========================================================;
*					EXAMPLE 12.2						 ;
*========================================================;
*========================================================;

*A sample of 44 healthy male college students participated 
in an experiment, Each student was asked to memorize a 
list of 40 words (20 on a green list and 20 on a red list).
The students were then randomly assigned of one of 4 treatments: 
Group A: received 2 alcoholic drinks
Group AC: received 2 alcoholic drinks with caffeine
powder dissolved in their drinks
Group AR: received 2 alcoholic drinks and a monetary 
reward for correct responses on the task
Group P: were told they received 2 alcoholic drinks,
but instead just received a carbonated drink

After consuming their drinks and resting for 25 minutes,
the students performed the word completion task. The response
variable "task score" represents the difference between 
the proportion of correct responses on the green list and
incorrect on the red list.;

data drinkers;
input GRP $ SCORE;
cards;
AR 0.51
AR 0.58
AR 0.52
AR 0.47
AR 0.61
AR 0.00
AR 0.32
AR 0.53
AR 0.50
AR 0.46
AR 0.34
AC 0.50
AC 0.30
AC 0.47
AC 0.36
AC 0.39
AC 0.22
AC 0.20
AC 0.21
AC 0.15
AC 0.10
AC 0.02
A 0.16
A 0.10
A 0.20
A 0.29
A -0.14
A 0.18
A -0.35
A 0.31
A 0.16
A 0.04
A -0.25
P 0.58
P 0.12
P 0.62
P 0.43
P 0.26
P 0.50
P 0.44
P 0.20
P 0.42
P 0.43
P 0.40
;
run;

*========================================================;

*QUESTION: What kind of experimental designed is employed here?;
*compeltely randomized design;
*randomly assigned two treatments;
*balanced design for each group;
*four factors;

*========================================================;

*QUESTION: Is there evidence of differences among the mean
task score of the four groups?;

*========================================================;

*QUESTION: Test is there is a statistical difference between
the three means. Use whichever method you prefer.;

*========================================================;

*QUESTION: Determine the pairs of solvent types that are 
significantly different. Use an experiment error rate of 0.05;


*========================================================;

*QUESTION: Use an experiment error rate of 0.025. What changes?;


*========================================================;

*QUESTION: Do these data violate the assumptions of ANOVA?;


*========================================================;

*QUESTION: The question of interest is: Does coffee or some other 
form of stimulation really allow a person suffering from 
alcohol intoxication to "sober up"? What is your conclusion?
Include any relevant inferences and confidence intervals. Use alpha=0.05. ;

