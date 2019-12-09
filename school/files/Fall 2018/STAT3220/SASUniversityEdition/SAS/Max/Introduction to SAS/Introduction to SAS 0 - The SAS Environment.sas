*===============================================================*
 
Before we get into loading and analyzing data, let's start with
some SAS terminology and programming basics.

==> SAS Programs:
	- SAS uses a series of "statements" exectued in order to
	create a program.
	
==> SAS Statements:
	### GOLDEN RULE OF SAS: EVERY STATEMENT ENDS WITH A SEMICOLON
	- SAS is not case sensitive
	- statements can contine on to the next line (using a force enter)
	- statements can be in the same line as other statements
	
==> Comments:
	- To annotate your code you can create a comment in two
	different ways
		1. Begin a comment with an * and end with a ; 
		/*2. Begin a comment with "slash-asterisk" and end a 
		comment with "asterisk-slash"  */
*		
==> TIPS:
	- Run programs/statements in small steps

*===============================================================*;

*===============================================================*
						DATA SETS
						
==> Variables (only two types):
	1. numeric: you can add, subtract, etc
	2. character: anything else. can include letters, numbers 
	or special characters
	
==> Missing Data:
	- numeric missing data will have a period (.)
	- character missing data will have a blank space
	
==> Rules for Variables:
	- Names must be fewer than 32 characters
	- Names must start with a letter or underscore (_)
	- Names cannot contain special characters other than underscore
	- Names cannot contain spaces (or it will be read as a new variable)

*===============================================================*;

*===============================================================*
						STEPS in SAS

To execute all programs in SAS there are two basic building blocks:

1. DATA steps
	- begin with DATA statements
	- read or modify data sets
	- create a SAS data set
	* enter data
	
2. PROC steps
	- begin with PROC statements
	- perform specific analysis or function
	- produce results or report
	* PROC = Procedure 
	* Do the analysis
	
==> A step ends when SAS encounters a new step, a RUN, QUIT, 
	STOP, or ABORT statements
	
==> Executing Steps:
	- DATA steps are executed line by line and observation by observation
		~ This means if you have a variable z = x + y, you need to 
		define x and y first





*===============================================================*;