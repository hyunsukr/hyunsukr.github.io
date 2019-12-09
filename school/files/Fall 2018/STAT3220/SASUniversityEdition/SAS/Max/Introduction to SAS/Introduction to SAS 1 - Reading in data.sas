*===============================================================*
 
 Data is read into SAS using a data step. There are two ways to 
 use the data step -- you can type the values directly into the 
 SAS code or you can import a file. Various types of files can 
 be read into the data step. In both cases, the input statement
 is where you name the variables you are reading in. SAS can 
 read in both numeric and character variables. A $ following 
 the variable name indicates that the variable should be read
 in as a character variable.

*===============================================================*;
 
*==============================*
 Typing the values in directly
*==============================*;

data hw_scores;
input ID score1 score2 gender $;
cards;
1 9.6 9.1 F
2 10 8.6 F
3 8.5 9.5 M
4 9.1 10 F
5 9.7 8.1 M
6 8.9 9.3 M
7 9.4 9 F
;
run;

** SAS University Edition will only read in these values if they 
   are separated by a space. If you are having trouble reading 
   in your data in this way, try finding and replacing tabs with 
   single spaces.
;


*==============================*
 Reading in a .txt file
*==============================*;

data hw_scores2;
infile '/folders/myshortcuts/SAS/HWScores.txt';
input ID score1 score2 gender $;
run;

** You will need to change the path to whereever the .txt file 
   is saved.
;


*==============================*
 Reading in a .csv file
*==============================*;

data hw_scores2;
infile 'C:\.csv' dsd;
input ID score1 score2 gender $;
run;

** You will need to change the path to whereever the .csv file 
   is saved.
;
