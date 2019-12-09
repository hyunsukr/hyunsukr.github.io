*========================================================;
*========================================================;
*			Chapter 10: Introduction to Time Series 
Modeling and Forecasting (Ch 10.1-10.2,10.4-10.5,10.7-10.9)

	- The procedure for time series regression is essentially 
		the same as multiple regression, except that we are now using 
		time a the predictor variable
		
	- The time series model: y_t =    E(y_t)   	   + R_t 
								 = T_t + C_t + S_t + R_t
	
	- Regression approach:
		> explanatory variables could represent trend over time
			(1 through n), seasonal variation (dummy variable 
			or trig functions), and cyclical variation
		> R_t represents the typical regression random error, e
		> Issues: extrapolation, violation of independent errors
		
	- Autocorrelation: correlation of errors at different points in time
		> first-order: residuals one time period apart are correlated
		> autoregressive model: R_t = phi*R_t-1 + e_t
			- e_t is "white noise" and unocrrelated with any other error
			
	~ NOTE: We will only cover models with first order autocorrelation
			
	- Time Series Model: y_t = E(y_t) + R_t 
							where R_t = phi*R_t-1 + ...+  e_t
		> in this class our model will be:
			 y_t = Beta_0 + Beta_1 *t + phi*R_t-1 + e_t
			 
		> After the autoregressive term is added, assess the model using
			- Significance testing for parameters
			- MSE and standard error of paramter estimates
			- Regression R^2
			- Total R^2

			 
	~ NOTE: We will only cover secular trend models, 
		not lagged or seasonal variation
			 
	- Drawbacks to forecasting with a time series autoregressive model
		> The form of the model could change, unexpectedly at any time
		> The forecast variance increases as you predict further in the future
		> Additional, almost negligible, variablity comes from parameter estimates
		==> therefore, use caution when predicting too far into the future,
			additionally confidence intervals are wider as time goes on
			
	~ NOTE: See textbook for hand calculations of predictions, we will demonstrate 
		exact forecasting in SAS
		
;
*========================================================;
*========================================================;

*========================================================;
*========================================================;
*					EXAMPLE 10.1						 ;
*========================================================;
*========================================================;
*A journalist is writing a story on the history of craft 
beer in Australia and would like to explore the trend of 
craft beer sales through the 60s and 70s. The journalist 
is able to find quarterly values for the number of megalitres 
produced from 1960 to 1974.;

data beer;
input quarter $ produced;
cards;
1960-Q1 253.1
1960-Q2 256.5
1960-Q3 250.4
1960-Q4 254.4
1961-Q1 264.7
1961-Q2 260.6
1961-Q3 267.2
1961-Q4 269.2
1962-Q1 272.1
1962-Q2 265.8
1962-Q3 269.8
1962-Q4 275.7
1963-Q1 273.8
1963-Q2 270.7
1963-Q3 277.5
1963-Q4 283.4
1964-Q1 288.4
1964-Q2 282.8
1964-Q3 300.1
1964-Q4 289.5
1965-Q1 300.8
1965-Q2 307.8
1965-Q3 305.9
1965-Q4 316.1
1966-Q1 305.2
1966-Q2 311
1966-Q3 308.3
1966-Q4 312.3
1967-Q1 322.8
1967-Q2 316.1
1967-Q3 324.9
1967-Q4 334.8
1968-Q1 323
1968-Q2 318.9
1968-Q3 327
1968-Q4 322.3
1969-Q1 329.1
1969-Q2 331.6
1969-Q3 341.4
1969-Q4 335.9
1970-Q1 346.6
1970-Q2 347.2
1970-Q3 343.6
1970-Q4 356.2
1971-Q1 359.6
1971-Q2 349.8
1971-Q3 368.6
1971-Q4 367
1972-Q1 359.2
1972-Q2 366.7
1972-Q3 362.8
1972-Q4 366.1
1973-Q1 373.4
1973-Q2 371.4
1973-Q3 376.9
1973-Q4 382
1974-Q1 397.8
1974-Q2 384.5
1974-Q3 389.5
1974-Q4 396.1
;
run;

data sganno;
   retain function 'text' x1space 'datavalue' y1space 'datapercent' 
          rotate 90 anchor "right" width 30;
   set beer;
   label=quarter;
   xc1=quarter;
   y1=-5;
    m2 = substr(quarter,7,1);
   if m2 in (1,3) then label='';
run;

*========================================================;

*QUESTION: Is there a trend in the craft beer production in Australia?;

proc sgplot data=beer sganno=sganno pad=(bottom=15%);
series x=quarter y=produced / markers;
xaxis display=(nolabel novalues);
run;



*========================================================;

*QUESTION: What is the appropriate model for the production of craft beer 
in Australia during this period?


;

*========================================================;

*QUESTION: What is the prediction equation for this model?;

*First convert quarters to time from 1;
data beer2;
set beer;
time=_n_;
run;

*Run the model as usual with time as the predictor;
proc reg data=beer2 plots=none;
model produced = time;
run;


*========================================================;


*QUESTION: What is the estimate for the average craft beer 
production in the last quarter of 1974? (this is the last observation);
proc reg data=beer2 plots=none;
model produced = time / p;
run;



*========================================================;

*QUESTION: What is the prediction interval for the craft beer 
production in the first quarter of 1960? (first observation);
proc reg data=beer2 plots=none;
model produced = time / cli;
run;


*========================================================;

*QUESTION: Are any of the regression assumptions violated?;

proc reg data=beer2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model produced = time;
run;


proc reg data=beer2 plots=none noprint; 
model produced = time ;
output out=beerres r=resid;
run;
quit;
proc sgplot data=beerres sganno=sganno pad=(bottom=15%);
series x=quarter y=resid / markers;
xaxis display=(nolabel novalues);
run;


*========================================================;

*QUESTION: Is there first-order autocorrelation in the errors?;
proc reg data=beer2 plots = none;
model produced = time / dwprob;
run;

*There is no first-order autocorrelation in the errors;

*========================================================;

* QUESTION: What is the appropriate model for the historic 
quantity of craft beer produced in Australia?

;

*========================================================;

*========================================================;
*========================================================;
*					EXAMPLE 10.2						 ;
*========================================================;
*========================================================;
*The marketing department for John Frieda has decided to 
review the sales for their Sheer Blonde shampoo. They 
record the number of bottles sold (in hundreds of thousands) 
for each month over three consecutive years.;

data shampoo;
input month $ sales;
cards;
2011-01 266
2011-02 145.9
2011-03 183.1
2011-04 119.3
2011-05 180.3
2011-06 168.5
2011-07 231.8
2011-08 224.5
2011-09 192.8
2011-10 122.9
2011-11 336.5
2011-12 185.9
2012-01 194.3
2012-02 149.5
2012-03 210.1
2012-04 273.3
2012-05 191.4
2012-06 287
2012-07 226
2012-08 303.6
2012-09 289.9
2012-10 421.6
2012-11 264.5
2012-12 342.3
2013-01 339.7
2013-02 440.4
2013-03 315.9
2013-04 439.3
2013-05 401.3
2013-06 437.4
2013-07 575.5
2013-08 407.6
2013-09 682
2013-10 475.3
2013-11 581.3
2013-12 646.9
2014-01 .
2014-02 .
2014-03 .
2014-04 .
2014-05 .
2014-06 .
2014-07 .
2014-08 .
2014-09 .
2014-10 .
2014-11 .
2014-12 .
;
run;

data sganno;
   retain function 'text' x1space 'datavalue' y1space 'datapercent' 
          rotate 90 anchor "right" width 30;
   set shampoo;
   label=month;
   xc1=month;
   y1=-5;
run;

*========================================================;

*QUESTION: 
Is there a trend in Sheer Blonde sales over time?;
proc sgplot data=shampoo sganno=sganno pad=(bottom=15%);
series x=month y=sales / markers;
xaxis display=(nolabel novalues);
run;

*========================================================;

*QUESTION: What is the appropriate model for Sheer Blonde shampoo sales?


;

*========================================================;

*QUESTION: Which of the possible models better fits the data?;

data shampoo2; 
set shampoo; 
time=_n_;
time2 = time**2;
run;


*========================================================;

*QUESTION: Which of the possible models yields shorter prediction intervals?;

proc reg data=shampoo2 plots=none;
model sales = time / cli clm;
output out=linpi lcl=lbpi ucl=ubpi; *stores the PI bounds in the data set;
run;

proc reg data=shampoo2 plots=none;
model sales = time time2 / cli clm;
output out=quadpi lcl=lbpi2 ucl=ubpi2;
run;

data predictionint;
merge linpi quadpi;
keep lbpi ubpi lbpi2 ubpi2;
data predlength;
set predictionint;
linlength= ubpi-lbpi;
quadlength= ubpi2-lbpi2;
run;

proc print predlength;
run;

*========================================================;

*QUESTION: Which of the possible models should be used?;



*========================================================;

*QUESTION: Are any of the regression assumptions violated in the more quadratic model?;
proc reg data=shampoo2 plots(only) = (ResidualbyPredicted QQPlot ResidualPlot);
model sales = time time2;
run;

proc reg data=shampoo2 plots=none noprint; model sales = time time2;
output out=shampres r=resid;
run;
quit;
proc sgplot data=shampres sganno=sganno pad=(bottom=15%); series x=month y=resid / markers;
xaxis display=(nolabel novalues);
run;

*========================================================;

*QUESTION: Is there first-order autocorrelation in the errors?;

*========================================================;
 
*QUESTION: What is the appropriate model for the sales 
of Sheer Blonde shampoo?;


*========================================================;
 
*QUESTION: What is the appropriate prediction for the sales 
of Sheer Blonde shampoo?;

* NOTE: proc autoreg (used in the textbook) is not available 
 in SAS University edition, we will use proc arima;

proc arima data=shampoo2 plots=none; 
identify var=sales crosscor=(time time2) noprint;
estimate input=(time time2) p=(1);
run;



*========================================================;
 
*QUESTION: What are the forecasted values for the next year?;

proc arima data=shampoo2 plots(only)=forecast(forecast); 
identify var=sales crosscor=(time time2) noprint;
estimate input=(time time2) p=(1);
forecast lead=12;
run;
