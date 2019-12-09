
#########################################################################
#                                                                       #
#  Introduction to R                                                    #
#                                                                       #
#########################################################################

#############
#  General  #
#############

#  R is a program that can be used for statistical computing and        #
#  graphics. It is an interpreted programming language, which means     #
#  that code is submitted interactively line by line. R is an open-     #
#  source software that is maintained by volunteers. All users can      #
#  access and modify source code.                                       #

##############
#  Packages  #
#  Load all packages here in this block #
##############

#  The functionality of R is broken up into various packages. There     #
#  are four packages included in the basic R download - base,           #
#  graphics, stats, utils. In order to use what is in a specific        #
#  package, that package needs to be installed and loaded. You do not   #
#  need to install or load base, graphics, stats, or utils.             #
#                                                                       #
#  In order to install packages, you must have an internet connection.  #
#  Packages only need to be installed once on a computer unless the     #
#  version of R is updated.                                             #

## Installing a package
install.packages("MASS")

#  Packages can also be installed by using the option under Tools.      #
#                                                                       #
#  Packages that you want to use need to be loaded each time that you   #
#  start a new R session, but only need to be loaded once per session.  #

## Loading a package
library("MASS")
require("MASS")

##############
#  Commands  #
##############

#  In order to get R to do what you want it to do, you will need to     #
#  write a complete command. R is ready for a new command when you      #
#  see a > in the console. If your command is incomplete, R will show   #
#  a + instead of a >. You can either complete the command after the +  #
#  or use the ESC key to abort.                                         #
#                                                                       #
#  To execute a complete command from a script, you can highlight the   #
#  command and click on the Run icon at the top right of the script     #
#  window or you can use the keyboard shortcut Ctrl + Enter.            #
#                                                                       #
#  Commands are separated by either a new line or by a semicolon.       #
#  Users tend to prefer the new line as it typically helps to better    #
#  organize their code.                                                 #
#                                                                       #
#  Another feature that leads to better organized code is that R        #
#  ignores spaces. Users can type their command in the script using     #
#  white space to make logical separations.                             #
#                                                                       #
#  Users can also add comments to their R code by using the hashtag or  #
#  pound sign. Once a line has been started as a comment, all           #
#  future # become a part of the comment. Comments are useful to        #
#  explain what has been coded and why to yourself or to collaborators. #
#                                                                       #
#  Comments can also be used to temporarily restrict certain lines of   #
#  code from running. Users can highlight the code they want to         #
#  comment out and use the keyboard shortcut Ctrl + Shift + C. Users    #
#  can remove the comments by using the same keyboard shortcut a        #
#  second time.                                                         #
#                                                                       #
#  A command can be used for multiple purposes. It can be used to       #
#  calculate a value, to evaluate a function, or to create an           #
#  object/variable.                                                     #

#################
#  Calculation  #
#################

#  R can be used as a calculator by using the standard arithmetic       #
#  operators:                                                           #
#  + (addition)                                                         #
#  - (subtraction)                                                      #
#  * (multiplication)                                                   #
#  / (division)                                                         #
#  ^ (power)                                                            #
#                                                                       #
#  R is like any calculator in that these operators follow the          #
#  standard order of operations.                                        #

## Calculation examples
15 + 10
12/6
0.7*5
3^3
15+10*3
(15+10)*3

#  Additional example:                                                  #
#  Determine the final grade for a student whose homework average is    #
#  94.3, whose midterm grade is 86.1, and whose final exam grade is     #
#  90.9 in a course where the homework is worth 40% and each exam is    #
#  worth 30%.                                                           #



###############
#  Functions  #
###############

#  Contained in all of its packages, R has an extensive list of         #
#  existing functions that can be used. Each function has a specific    #
#  name that is followed by a set of parentheses. Using a function      #
#  calls a specific collection of code to be executed. Generally the    #
#  code that will be executed needs specific inputs to run correctly    #
#  and the user provides these values in the parentheses that follow    #
#  the function name.                                                   #
#                                                                       #
#  Functions can be used for basic calculations, for complex            #
#  procedures, and many other things in between. Users can also write   #
#  their own functions.                                                 #
#                                                                       #
#  R is case-sensitive, so functions that you want to use must be       #
#  typed exactly as it was defined.                                     #

## Some function examples
log(2.7)  #this function is the log with base e, sometimes written as ln #
Log(2.7) #will not run since R is case sensitive #
exp(1)
sqrt(9)
factorial(3)
abs(-5)
sum(2,4,6)
floor(5.7)
ceiling(5.7)
trunc(5.7)
round(5.7,0)
round(5.727,2)

#  Every function has corresponding documentation that can be accessed  #
#  directly from RStudio. The specific help documentation for a given   #
#  function will be opened by executing either of the commands shown    #
#  below.                                                               #
#                                                                       #
#  These documentation files are only available for the                 #
#  packages that have been loaded. If you attempt to find a             #
#  documentation file for a function in a package that you have not     #
#  loaded, the help file will not be found.                             #

## Opening help documentation
help(round)
help(log)
?round

#  Additional example:                                                  #
#  Determine how the final grade for the same student could be          #
#  calculated using functions.                                          #



#######################
#  Objects/variables  #
#######################

#  In order to write useful and effective R code, users need to be      #
#  able to store items to be used later. Anything that is stored is     #
#  called an object. An object can be a single value resulting from a   #
#  calculation or a collection of information such as a table of        #
#  linear regression coefficients. A variable is a memory location for  #
#  the object, which can be thought of as a label for the object.       #
#  Variables are created when the object is assigned to it, so there    #
#  is no need to declare the variable first.                            #
#                                                                       #
#  Variable names can consist of letters, numbers, periods, and         #
#  underscores. There are a few limitations to how these types of       #
#  characters can be combined. The following are characteristics of     #
#  all variable names:                                                  #
#    1. Variable names cannot begin with a number.                      #
#    2. Variable names cannot contain spaces.                           #
#    3. Variable names can begin with a period as long as they are      #
#       not followed by a number.                                       #
#    4. Since R is case-sensitive, x and X are different variable       #
#       names.                                                          #
#                                                                       #
#  Wherever possible, it is best practice to avoid using the names      #
#  of existing functions (ie. mean, sd, log) and predefined             #
#  variables (ie. pi) to avoid confusion for anyone reading your code   #
#  and possibly R itself.                                               #
#                                                                       #
#  It is also best practice to use variable names that are short and    #
#  descriptive of the information contained in the object.              #
#                                                                       #
#  Once you have decided on a variable name for the object, you will    #
#  need to assign the object to the variable by using either the        #
#  assignment operator <- or = (the first is the more commonly used).   #

## Assigning objects to variables
total1 <- 10+15
value1 <- round(5.7,0)
pi
#  R will recall or show the object stored in a variable when the       #
#  variable name is submitted as a command.                             #

total1
Total1
value1

#  Stored objects can be used in subsequent operations.                 #

total1/5
total1/value1

#  Any object that you would like stored needs to be given a variable   #
#  name.                                                                #

ratio1 <- total1/value1

#  Variables can be overwritten by storing a new object using the same  #
#  variable name.                                                       #

ratio1 <- total1/2

#  Additional example:                                                  #
#  Write a command that will calculate and store any student's final    #
#  grade in a course where homework is worth 40% and each exam is       #
#  worth 30%.                                                           #



#  Additional example:                                                  #
#  Use the command exactly as written above to calculate the final      #
#  grade of a student with a homework average of 98.4, a midterm grade  #
#  of 82.1, and a final exam grade of 85.9.                             #



#####################
#  Data structures  #
#####################

#  The type of data structure that you will use will depend on the      #
#  dimensionality of your data and whether or not they are homogeneous. #
#                                                                       #
#  A single value is considered to have zero dimensions and is called   #
#  a scalar.                                                            #
#                                                                       #
#  A data structure that is either a single column or a single row is   #
#  considered to have one dimension. If everything recorded in a        #
#  one-dimensional data structure is of the same type, then it is       #
#  called a vector. If the items recorded in a one-dimensional data     #
#  structure have varying types, then it is called a list.              #
#                                                                       #
#  A data structure that contains multiple rows and multiple columns    #
#  is considered to have two dimensions. If the contents of a           #
#  two-dimensional data structure are homogeneous, then it is called    #
#  a matrix. If the contents of a two-dimensional data structure are    #
#  heterogeneous, then it is called a data frame.                       #

#############
#  Vectors  #
#############

#  There are five main types or classes of vectors - logical, integer,  #
#  numeric, complex, and character. The class of the vector reflects    #
#  the type of data that is stored.                                     #
#                                                                       #
#  One way to create a vector is to use the concatenate function, c().  #
#  The inputs for this function are the data that you would like stored #
#  in the vector in the order in which you would like them stored.      #

## Creating a variable using the concatenate function
gen_vect <- c(5,10,15,20,25)

#  If you are unsure of what class R has used for your vector, the      #
#  class() function can be used to check.                               #

## Checking the class of a vector
class(gen_vect)

#  The class of the vector will be in part determined by how you enter  #
#  the data.                                                            #

## Creating an integer vector
int_vect <- c(5L,10L,15L,20L,25L)
class(int_vect)

## Creating a logical vector
log_vect <- c(TRUE, FALSE, T, F)
class(log_vect)
## Creating a character vector
char_vect <- c("Adam", "Kelly", "Jennifer", "Blake")
class(char_vect)
#  Vectors are the default data structure for variables. Unless         #
#  otherwise specified, R will store objects as vectors. Since vectors  #
#  are homogenous data structures in R, if the object contains          #
#  multiple types of data, R will modify the data to all be of the      #
#  same type. R modifies data according to the following hierarchical   #
#  structure:                                                           #
#  1. character                                                         #
#  2. complex                                                           #
#  3. numeric                                                           #
#  4. integer                                                           #
#  5. logical                                                           #

## Mixed vector types
c(TRUE, 5)
c(2+(0+3i), 5)
c("Blake", 5)
c(TRUE, "Blake", 5)


#  It may be useful to check the class of an object and receive a       #
#  logical answer (T or F). The following functions conduct this type   #
#  of test of the class of an object:                                   # 
#  is.character()                                                       #
#  is.complex()                                                         #
#  is.numeric()                                                         #
#  is.integer()                                                         #
#  is.logical()                                                         #

## Testing the type of a vector
is.character(char_vect)
is.character(gen_vect)

#  The class of an object can be coerced to change by using the         #
#  following functions:                                                 #
#  as.character()                                                       #
#  as.complex()                                                         #
#  as.numeric()                                                         #
#  as.integer()                                                         #
#  as.logical()                                                         #

## Changing the type of vector
as.character(gen_vect)
as.numeric(char_vect)

#  Note that coercing a vector to change will not always yield a        #
#  logical result.                                                      #
#                                                                       #
#  Simply using the coercing functions above will not change a stored   #
#  object. You must overwrite the existing variable or create a new     #
#  variable in which to store the coerced vector.                       #

gen_as_char <- as.character(gen_vect)
class(gen_vect)
class(gen_as_char)

#  The concatenate function can also be used to add a value to a        #
#  vector or to combine preexisting vectors.                            #

char_vect2 <- c(char_vect, "Carson")
tot_vect <- c(char_vect2, gen_vect)

#  It is important to remember that the order in which the objects are  #
#  specified is the order in which they will be saved in the vector.    #   

tot_vect <- c(gen_vect, char_vect2)

#  Additional example:                                                  #
#  Consider all of the courses you are enrolled in on SIS, including    #
#  labs and discussion sections. Create a vector containing your MWF    #
#  and/or MW classes and another containing your TTh classes. If you    #
#  have any single day classes, create additional vectors for each day. #
#  Combine these vectors into a single vector in the best chronological #
#  order you can achieve without breaking the vectors apart.            #



#  There are times when you may need to create a vector that contains   #
#  a sequence of numbers. There are two ways to create this type of     #
#  variable.                                                            #
#                                                                       #
#  If you are wanting to create a vector that contains a sequence of    #
#  consecutive integers, then you can use the syntax a:b to create a    #
#  vector that starts at a and increases or decreases by one until b.   #
#                                                                       #
#  Whether the sequence increases or decreases depends on the           #
#  relationship between a and b. If a is less than b, then the          #
#  sequence will increase, and, if a is greater than b, then the        #
#  sequence will decrease.                                              #

1:5
5:1
-1:-5
-5:-1

#  If you are wanting a sequence where the values have a constant       #
#  difference other than one, then you can use the sequence             #
#  function, seq(). This function takes three inputs - from, to, by.    #
#  These inputs specify the first and last number of the sequence as    #
#  well as the difference between each value in the sequence.           #

seq(1,5, 0.5)
seq(-5,-1, 0.5)

#  The default value for the by input is 1, meaning that if you only    #
#  specify the from and to inputs, the function will yield a sequence   #
#  of consecutive integers between the two provided values.             #

seq(1,5)
seq(-5,-1)

#  There is another optional input for the sequence function - length.  #
#  The length option specifies the length that you want your vector     #
#  to be or how many values you want contained in the vector. The       #
#  sequence function will use this value to determine a constant        #
#  difference between each of the values that yields the number of      #
#  values that you specify.                                             #

seq(1,5, length=5)
seq(1,5, length=9)

#  It is possible to use both the by and length options, but the        #
#  function will not execute if they do not agree. If you use the       #
#  length option, you need to use length= as shown above to tell R to   #
#  use the length option instead of the by option.                      #
#                                                                       #
#  Additional example:                                                  #
#  Create a vector containing all the years that you finished an even   #
#  number grade in school (1st-12th).                                   #

labs <- c(seq(1,4), 0)
labs <- c(1:4, 0)
labs

names(char_vect2) <- labs
names(char_vect2)
#  Another function that creates a useful type of vector is the         #
#  repeat or replicate function, rep(). This function takes two         #
#  inputs - vector and times. These inputs specify what you would       #
#  like R to repeat and how many times. Depending on the format of      #
#  what you provide in the times option, this function will either      #
#  repeat the given vector a specified number of times or repeat the    #
#  elements of the vector a specified number of times.                  #

rep(1:5, 2)
#one ones two twos 3 threes 2 fours 1 five
rep(1:5, c(1,2,3,2,1))
rep(1:5, c(2,2,2,2,2))

#  If you want to repeat each element in the provided vector a          #
#  specific number of times, you can use the each option in place of    #
#  the times option. In order to use this option, you will need to      #
#  specify it with each=.                                               #

#each index gets repeated #
rep(1:5, each=2)

#  Additional example:                                                  #
#  Create a vector that contains the number of credit hours for each    #
#  course in the chronological vector you created above. The elements   #
#  in the credit hour vector should be in the same respective order.    #



#  Additional example:                                                  #
#  Create a vector that contains the number of hours that each course   #
#  meets in the same order as the chronological vector you created.     #
#  Round to the nearest hour (you do not need to do this in R.)         #



#  Additional example:                                                  #
#  Expand your chronological vector of courses so that each course is   #
#  shown as many times as credit hours it is worth. The resulting       #
#  expanded vector should still be in as chronological an order as      #
#  possible.                                                            #



#  Once a vector is created and stored, it may be useful in subsequent  #
#  analyses to subset that vector. In other words, users may want to    #
#  view or store a portion of the values recorded in the vector. The    #
#  typical notation to subset vectors is a set of square brackets used  #
#  directly after the variable name of the vector. The information      #
#  given inside the brackets specifies which values should be           #
#  extracted from the vector.                                           #
#                                                                       #
#  The most basic way to subset a vector is to include in the square    #
#  brackets the position of the value you would like to be in the       #
#  subset. The position index of any vector begins at 1 and uses        #
#  consecutive positive integers up to the length of the vector.        #

# index of array starts as zero #

char_vect
char_vect[3]

#  Multiple positions can be specified by using a vector in the         #
#  square brackets.                                                     #

#first and third element #
char_vect[c(1,3)]

#second and third element #
char_vect[2:3]

#  If a position is duplicated in the square brackets, the              #
#  corresponding value in the vector will be subset twice.              #

char_vect[c(1,1)]

#  If a negative sign is added to the square brackets, the specified    #
#  value(s) will be omitted instead of included in the subset.          #

#everyone but the first index (-) #
char_vect[-1]
char_vect[-(2:3)]
char_vect[-c(1,4)]

#  Instead of specifying the positions that you would like included or  #
#  excluded from the subset, you can specify a logical vector in the    #
#  square brackets. With this type of input, R will include the         #
#  elements corresponding to TRUE and exclude the elements              #
#  corresponding to FALSE.                                              #


char_vect
#only ouput the true values in the logic vector
char_vect[c(F,T,T,F)]

#  If the number of logical inputs does not match the length of the     #
#  vector, R will repeat the logical inputs until there is a logical    #
#  input corresponding to each vector element.                          #

char_vect[c(F,T)]
# above command repeats ths false or true until it reaches the end of the vector #
# goes in order #

#  The resulting subset vectors will only be stored if you define a     #
#  variable name and assign the subset vector to it.                    #

F_coach <- char_vect[2:3]
# c(2,3) == 2:3 #
char_vect
F_coach

#  Additional example:                                                  #
#  Isolate all of your classes except those that meet on Tuesdays.      #



#  Additional example:                                                  #
#  Isolate the classes that meet earliest in the week.                  #



#  The square brackets following a vector can also be used to replace   #
#  one or more values in a vector.                                      #

coach <- char_vect
coach  # Season 15 coaches

coach[3] <- c("Alicia")
coach  # Season 14 coaches

coach[2:3] <- c("Miley", "Jennifer")
coach  # Season 13 coaches

coach[c(1,4)] <- "Bladam"
coach

#  Note that because the assignment operator <- is being used, the      #
#  updated vector is stored under the same variable name.               #
#                                                                       #
#  It is often best practice to keep a copy of the data used in each    #
#  step of an analysis, in which case, you should create a new copy of  #
#  the vector before making any changes.                                #

coach15 <- char_vect

coach14 <- coach15
coach14[3] <- c("Alicia")

coach13 <- coach14
coach13[2:3] <- c("Miley", "Jennifer")

coach15
coach14
coach13

#  Additional example:                                                  #
#  Create a copy of your classes vector. Replace each class with the    #
#  appropriate one of three designations -- area requirement, major     #
#  course, general elective.                                            #



#  The standard arithmetic operators can be applied to vectors as well  #
#  as to single values. Since there are multiple values stored in a     #
#  vector, there are different ways that the arithmetic operators can   #
#  be used.                                                             #
#                                                                       #
#  To perform the same constant arithmetic operation on each element    #
#  of the vector, you will use the vector name, the arithmetic          #
#  operation symbol, and the constant.                                  #

## Create vectors of interest
x <- c(14,1,1,14)
y <- c(3,1,0,6)
x
y
## Multiply each element in vector x by 2
2*x

## Divide each element in vector y by 5
y/5

## Take each element in vector y to the power of 3
y^3

#  You may have related information stored in two vectors and you       #
#  may want to perform an arithmetic operation on each pair of          #
#  related values.                                                      #

## Add each element pair
x+y

## Multiply each element pair
x*y

## Divide each element pair
y/x
#NOTE U CAN"T ADD OR DO ANYTHING WITH DIFFERENT SIZe VECTORS unless the size is a multiple? idk lool #

#  Using standard arithmetic operators with two vectors will apply the  #
#  arithmetic operator to the pair of first values, then to the pair    #
#  of second values, and so on. If your related data are not in the     #
#  same order within the vectors, you will need to modify one or both   #
#  until they are in the same order.                                    #
#                                                                       #
#  Additional example:                                                  #
#  Are the credit hours and time you spend in each class the same?      #
#  Hint: What is the difference between the two for each class?         #



#  Vectors can also be used as inputs to several functions. Functions   #
#  may also output a vector.                                            #

## Some functions that use vectors as inputs
sum(x)
mean(y)
median(x)
var(y)
sd(y)
max(y)
min(x)
range(x) #this will give you the min and max #
cor(x,y)
sort(y)
rev(x)
quantile(x) # This function has an optional second input to specify which 
            # quantile you want shown
            # Give you the quarter percentile
quantile(x, 0.95) #this gives you the 95 % percentile
quantile(x, 0) # minimum #
summary(x)
cumsum(y)
cumprod(y)

#  Additional example:                                                  #
#  How many credit hours will you earn this semester?                   #



#  Additional example:                                                  #
#  Use a function to determine whether the credit hours and time you    #
#  spend in each class the same.                                        #



#  It may be useful to use a logical expression to determine which,     #
#  if any, elements in a vector have certain qualities. When a logical  #
#  expression is applied to a vector, the result will be a vector       #
#  containing TRUE where the condition is satisfied and a FALSE where   #
#  the condition is not satisfied.                                      #

x

## Are any elements greater than 1?
x > 1 #This returns the logic value for all index which this statment satisfies #


## Are any elements greater than or equal to 1?
x >= 1

## Are any elements exactly equal to 1?
x == 1 #this is equality check (a single = ' = ' is a assignment) #

## Are any elements not equal to 1?
x != 1

#  Multiple logical expressions can be combined using either and or or. #

## Are any elements in x greater than 1 and the same element in y is equal to zero?
x > 1 & y == 0 

## Are any elements greater than 5 or less than 1?
x > 5 | x < 1

#  The logical vectors that result from logical expression statements   #
#  can be used in the square brackets to subset a vector just to the    #
#  values that satisfy the condition.                                   #

x[x>3]

#  Instead of yielding a logical vector for each entry in a vector,     #
#  the which function, which(), yields the positions in the vector      #
#  where the condition is satisfied. The which function can also be     #
#  used in the square brackets to subset a vector to just the values    #
#  that satisfy the condition.                                          #

which(x>3) #positions where ths parameter satisfies #
x[which(x>3)] #get the values #
x

#  Additional example:                                                  #
#  Isolate your 3 credit hour courses.                                  #



#  Additional example:                                                  #
#  Isolate your courses that do not meet for the same number of hours   #
#  as credits given.                                                    #



##############
#  Matrices  #
##############

#  Recall that a matrix is a two-dimensional homogeneous data           #
#  structure.                                                           #
#                                                                       #
#  There are numerous ways to create a matrix. The first way to create  #
#  a matrix is to use the matrix() function. This function takes four   #
#  inputs - vector, nrow, ncol, and byrow. These inputs instruct R what #
#  values to put in the matrix, how many rows and columns the matrix    #
#  should have, and whether values should be assigned across the rows   #
#  or down the columns. The default for the byrow option is false,      #
#  meaning that the values will be assigned down the columns if the     #
#  byrow option is not provided.                                        #

matrix(c(14,1,1,14,3,1,0,6), nrow=2, ncol=4, byrow=TRUE)


matrix(c(14,1,1,14,3,1,0,6), nrow=4, ncol=2, byrow=TRUE)
matrix(c(14,1,1,14,3,1,0,6), nrow=2, ncol=4, byrow=FALSE)

#  Another way to create a matrix is to use either the cbind() or       #
#  rbind() function. Both of these functions use vectors as inputs.     #
#  The cbind() function will bind these vectors together as columns     #
#  and the rbind() function will bind these vectors together as rows.   #

x <- c(14,1,1,14)
z <- c(1,2,3)
rbind(x,z)
y <- c(3,1,0,6)

rbind(x,y)
cbind(x,y)

#  As with the concatenate function, R will bind the vectors together   #
#  in the order you specify.                                            #

cbind(x,y)
cbind(y,x)

#  Additional example:                                                  #
#  Combine your vectors of credit hours and time spent in each course   #
#  into a matrix where each course's information is given in a row.     #



#  As matrices are a homogeneous data structure, matrix values          #
#  follow the same hierarchical order as vectors:                       #
#  1. character                                                         #
#  2. complex                                                           #
#  3. numeric                                                           #
#  4. integer                                                           #
#  5. logical                                                           #

char_vect <- c("Adam", "Kelly", "Jennifer", "Blake")
coach_stat <- cbind(char_vect,x,y)
coach_stat

colnames(coach_stat) <- c('hello', 'he', 'hi')

#  Additional example:                                                  #
#  What is the class of the values in your matrix when you add your     #
#  vector of courses?                                                   #



#  There are times when it is useful to know what the dimensions of     #
#  a matrix are. The dimension function, dim() will provide this        #
#  information for a matrix. The dimensions provided are not the same   #
#  as the dimensionality of the data structure that determines what     #
#  type of data structure is being used. The dimensions provided by     #
#  this function are the number of rows and number of columns contained #
#  in the matrix.                                                       #

dim(coach_stat)

#  The dimension function can also be used to turn a vector into a      #
#  matrix.                                                              #

coach_vect <- c("Adam","Kelly","Jennifer","Blake",14,1,1,14,3,1,0,6)
dim(coach_vect) <- c(4,3)
coach_vect

#  To subset a matrix, the same square bracket notation is used.        #
#  However, because of the fact that the structure of a matrix is       #
#  more complex than that of a vector, more inputs are required in      #
#  the square brackets. The first input references the row and the      #
#  second input references the column.                                  #

## Subsetting the value in the first row and first column
coach_stat[1,1]

## Subsetting the values in the first two rows and first two columns
coach_stat[1:2,1:2]

## Subsetting the values in multiple rows and the first two columns 
coach_stat[c(1,4),1:2]

## Subsetting the entire first row
coach_stat[1,]
coach_stat[-(2:4),]

## Subsetting the entire second column
coach_stat[,2]
coach_stat[,-c(1,3)]

## Subsetting all but the first row
coach_stat[-1,]

## Subsetting all but the third column
coach_stat[,-3]

## Subsetting the third column twice
coach_stat[,c(3,3)]

## Duplicating the third column
coach_stat[,c(1:3,3)]

#  Additional example:                                                  #
#  How many credit hours will you earn for the first class that meets   #
#  each week?                                                           #



#  Additional example:                                                  #
#  How much time do you spend in the last class that meets each week?   #



#  Additional example:                                                  #
#  How many hours would you spend in class each week if you always      #
#  skipped your last class?                                             #



#  The standard arithmetic operators can be used with matrices in the   #
#  same general manner that they can be used with vectors.              #
#                                                                       #
#  To perform the same constant arithmetic operation on each element    #
#  of the matrix, you will use the matrix name, the arithmetic          #
#  operation symbol, and the constant.                                  #

A <- matrix(1:6, nrow=2, ncol=3)
A
A+2 #apply to every position
A*3
A/4

#  Additional example:                                                  #
#  There are 14 weeks in a semester. Modify your matrix to show the     #
#  number of credit hours and time spent in class over the entire       #
#  semester for each class.                                             #



#  Using standard arithmetic operators with two matrices will apply the #
#  arithmetic operator to the pair of corresponding elements in each    #
#  matrix. Thus, the value in the first row and first column of the     #
#  first matrix will be treated with the value in the first row and     #
#  first column of the second matrix.                                   #

B <- matrix(1:6, nrow=2, ncol=3)
A+B
A*B
B/A

#  Many functions can be applied to an entire matrix. In order to apply #
#  a function to a portion of a matrix, you can use the apply function, #
#  apply(). This function uses three inputs - matrix, margin, and       #
#  function. The matrix input specifies the matrix to which you would   #
#  like the function to be applied, margin specifies whether you want   #
#  the function applied to the rows, columns, or individual values, and #
#  function specifies the function to be applied. Since the apply       #
#  function separates the matrix into a collection of vectors, users    #
#  can use a pre-existing R function that applies to vectors or write   #
#  their own function.                                                  #

## Sum the entire matrix A
A
sum(A)

## Sum the rows of matrix A show each rows answer
apply(A,1,sum)

## Sum the columns of matrix A show each column answer
apply(A,2,sum)

## Find the mean of the rows of matrix A
apply(A,1,mean)

## Find the standard deviation of the columns of matrix A
apply(A,2,sd)

## Find the quantiles of the columns of matrix A
apply(A,2,quantile)

## Find the first quartile of the columns of matrix A
apply(A,2,quantile,0.25)
## apply(matrix, column or row (2|1), function, extra parameter)

#APPLY FUNCTION WILL NOT EXECUTE IF IS OF TYPE ...?
C <- matrix(c('a','b','c','d'), nrow=2, ncol=2)
C
apply(C,2,sum)
B <- matrix(c(FALSE,TRUE,TRUE,TRUE), nrow=2, ncol=2)
B
apply(B, 2, sum)
# A. logical
# B. Character
# C. Both
# D. neither

#Logicals become zero and ones. 

#  Additional example:                                                  #
#  Determine the total number of credit hours and time you will spend   #
#  in class this semester over all your classes.                        #



#  Additional example:                                                  #
#  What is the average number of credit hours and hours spent in class  #
#  each week for all our classes?                                       #



#  Additional example:                                                  #
#  What is the difference between the credit hours and time spent in    #
#  class each week for all your classes?                                #



#  Logical expressions can be used with matrices to determine which,    #
#  if any, elements in a matrix have certain qualities. When a logical  #
#  expression is applied to a matrix, the result will be a matrix       #
#  containing TRUE where the condition is satisfied and FALSE where     #
#  the condition is not satisfied.                                      #

A>2

#  Specific rows or columns can be subset before applying the logical   #
#  expression.                                                          #

A[2,]>4

#  The logical vectors that result from logical expression statements   #
#  can be used in the square brackets to subset a matrix just to the    #
#  rows and/or columns that satisfy the condition. Note that the        #
#  logical vector used to subset a matrix must be the same length as    #
#  number of rows/columns in the matrix.                                #

col_sum <- apply(A,2,sum)
A[,col_sum>5]

#  The which function can also be used in the square brackets to        #
#  subset a matrix in terms of rows or columns or both.                 #

A[,which(col_sum>5)]

#  Additional example:                                                  #
#  Which of your courses meet for more time than credit hours you will  #
#  receive?                                                             #



################
#  Dataframes  #
################

#  A data frame is a two-dimensional data structure that can contain    #
#  heterogeneous data. Thus, data frames are commonly used to store     #
#  data. There is typically a row for each observation and a column     #
#  for each variable measured on the observations.  A data frame can    #
#  be created using the data.frame() function. The inputs to this       #
#  function are the vectors you would like to be in the data frame and, #
#  optionally, the names of those vectors.                              #

char_vect <- c("Adam", "Kelly", "Jennifer", "Blake")
x <- c(14,1,1,14)
y <- c(3,1,0,6)
gender <- c("M","F","F","M")
gender
coach_data <- data.frame(Name=char_vect, Seasons=x, Wins=y, Gender=gender)
coach_data

#  Alternatively, vector names can be added to an existing data frame   #
#  using the names function.                                            #

coach_data <- data.frame(char_vect,x,y,gender)
coach_data

names(coach_data) <- c("Name","Seasons","Wins","Gender")
coach_data

colnames(coach_data) <- c('hello', 'he', 'hi', 'interesting')
coach_data

rownames(coach_data) <- c('hello', 'he', 'hi', 'interesting')
coach_data

#col names and rownames work for data frams as well.

#  The names function can also be used to display the names of the      #
#  columns.                                                             #

names(coach_data)

#  Data frames can be subset by using the square brackets and           #
#  specifying the row and column numbers to be included or excluded.    #

coach_data[c(1,4),]
coach_data[,1:2]
coach_data[,2]
coach_data[,4]

#  Categorical data are read into data frames as factors. Thus, in      #
#  any analysis using this data, numerical values representing the      #
#  different levels will be used.                                       #
#                                                                       #
#  The coercion functions can be used to turn factor vectors into       #
#  categorical vectors and vice versa.                                  #
coach_data
as.character(coach_data[,4])
as.factor(char_vect)

#  When the columns of a data frame have headers, the data frame can    #
#  be subset using the name of the column as well.                      #
# Data frames will always have column names #
coach_data$Seasons
coach_data$Name
coach_data

#  The resulting vectors can be subset using the square brackets.       #
coach_data$Seasons[3]
coach_data$Name[1]

#  There are testing and coercion functions to transform back and       #
#  forth between matrices and data frames - is.matrix(),                #
#  is.data.frame(), as.matrix(), as.data.frame().                       #

is.data.frame(coach_data)
as.matrix(coach_data)

A <- matrix(c(1:6),nrow=2,ncol=3,byrow=FALSE)
as.data.frame(A)

#  Example for class avg #
# scores[scores$Fcourse < 60, 2:3 ] #
#           or                      #
# scores[scores$Fcourse < 60, c("HW", "Proj") ] #
# scores[which(scores$Fcourse < 60),  ]

## highest and lowest course grades ##
# scores[scores$Fcourse == min(scores$Fcourse) | max(scores$Fcourse), c("names")] #


#  Additional example:                                                  #
#  Store your weekly course matrix as a data frame with appropriate     #
#  column names.                                                        #



#  Additional example:                                                  #
#  Isolate the number of hours you spend in your first two 3-credit     #
#  hour courses each week.                                              #



#  Additional example:                                                  #
#  Determine the course names of the course(s) you spend the most time  #
#  in each week.                                                        #



###########
#  Lists  #
###########

#  A list is a one-dimensional data structure that can contain          #
#  heterogeneous data. Heterogenous in type and structure #
#  Lists are the most flexible type of object in    #
#  R. Lists are similar to vectors in that there is one row containing  #
#  multiple values. However, in a list, those values can be objects of  #
#  varying types and sizes.                                             #
#                                                                       #
#  A list is created using the list function, list(). The inputs        #
#  specify what you would like in each element of the list.             #

voice_data <- list(Name=char_vect, Seasons=x, Host="Carson", 
                   Former=c("Christina","Ceelo","Usher","Shakira","Pharrell","Gwen","Miley","Alicia"), 
                   F_Seasons=c(6,4,2,2,4,3,2,3))

#  A list is subset to any of its elements by using double square       #
#  brackets, [[ ]]. You can either use the postition or the name of     #
#  the element.                                                         #
voice_data
voice_data[[4]]
voice_data[["Former"]]
# this above gives you a vector #

#  A list can also be subset by using the name of the element after     #
#  a dollar sign.                                                       #

voice_data$Former

#  If a subset list element is a vector, the values in the vector can   #
#  be subset by using single square brackets after the double square    #
#  brackets or after the dollar sign and name.                          #

voice_data[[4]][2]
voice_data[["Former"]][2]
voice_data$Former[2]

#  Double square brackets are limited to one value. In order to subset  #
#  multiple elements of a list, single square brackets can be used.     #
#  This syntax will result in a list with fewer elements instead of     #
#  multiple vectors.                                                    #

voice_data[4:5]

#  Thus, subsetting a value from the subset object does not work when   #
#  using single brackets. Instead you will further subset your list.    #

voice_data[4][2]
voice_data[4:5][2]

#  Clicker Question: #
#  it is possible to add multiple elements to a list with a single command #
#  Append function you need to load and install this package from rlist #
help(append)

#  There is a testing and coercion function to transform objects into   #
#  lists - is.list() and as.list().                                     #

is.list(voice_data)
as.list(char_vect)

#  Additional example:                                                  #
#  Add the number of wins to the list of The Voice information. For     #
#  the current coaches: 3,1,0,6. The following former coaches have      #
#  each won one season: Usher, Pharrell, Christina, and Alicia.         #



#  Additional example:                                                  #
#  Isolate the names of coaches who have won at least 1/3 of the        #
#  seasons they have been on the show.                                  #



#####################
#  Importing files  #
#####################

#  Typically, the data you will want to use will be stored in another   #
#  file that is saved somewhere on your computer. Users are able to     #
#  specify a particular location that R will then use to look for and   #
#  save files. This location is called the working directory. The       #
#  working directory is set by using the function setwd(). R requires   #
#  path names to use either the forward slash or a double backslash.    #

setwd("/Users/maxryoo/Documents/Fall 2018/STAT3080/Lecture Material")

#  You can check the location of the working directory by using the     #
#  function getwd().                                                    #

getwd()

#  Once the working directory is set to the appropriate location,       #
#  users are able to import data files that are saved there. The most   #
#  reliable function for reading in data from an external file is to    #
#  use the function read.table(), which will read in a .txt file and    #
#  create a data frame. This function requires two inputs - the file    #
#  name and whether the data being read in have headers. The default    #
#  for the headers option is FALSE, so if you do have headers in your   #
#  data file, they will be read in as the first row of the table        #
#  unless you specify TRUE for this option.                             #

read.table("Data1.txt", header=TRUE)
read.table("Data1.txt")

#  If you have not set a working directory, the entire path to the      #
#  data file needs to be specified.                                     #
#                                                                       #
#  The read.table() function will fail if any of the column headers     #
#  contain spaces. Any space issues need to be fixed in the data file   #
#  before reading it into R.                                            #
#                                                                       #
#  If the data file is comma separated (.csv), the function read.csv()  #
#  can be used to read in the data. This function takes three           #
#  inputs - file, header, separation. The default for header is TRUE    #
#  and the default for separation is comma.                             #

read.csv("Data1.csv")

#########################################################################
