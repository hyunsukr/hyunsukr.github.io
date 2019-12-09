
#########################################################################
#                                                                       #
#  Graphics in R                                                        #
#                                                                       #
#########################################################################

install.packages("ggplot2")
install.packages("datasets")
install.packages("car")
install.packages("gcookbook")
install.packages("MASS")
install.packages("Hmisc")

library(ggplot2)
library(car)
library(gcookbook)
library(MASS)
library(Hmisc)

#############
#  General  #
#############

#  There are several different ways to produce graphics in R. Many      #
#  exist in the base graphics package.                                  #

## Scatterplot of tree circumference vs. tree age
plot(Orange$age, Orange$circumference)

## Histogram of tree circumference
hist(Orange$circumference)

#  A commonly used package for graphics is ggplot2.                     #

#####################
#  ggplot2 package  #
#####################

#  The main idea behind graphics in ggplot2 is that different layers    #
#  of the plot are specified by the user and then added together.       #
#  Layers have one of three purposes:                                   #
#     1. Display the data                                               #
#     2. Display a statistical summary of the data                      #
#     3. Add metadata, context, and annotations                         #
#                                                                       #
#  A graph is not displayed until there is at least one layer.          #
#  Generally, the first layer is specified by using the function        #
#  ggplot(). In this function, the data to be used for the entire       #
#  graphic and/or the aesthetic features for the entire graphic can     #
#  be specified. If these are not given in the ggplot() statement,      #
#  they must be specified in each layer. Aesthetic features for the     #
#  entire graphic are specified within the aes() function.              #

##################
#  Scatterplots  #
##################

## Look at the first 5 rows of the Davis data (contained in the car package)
Davis[1:5,]

## Define the first layer of a scatterplot of reported weight vs.
## measured weight
## Datasert = Davis
## x and y are columns from the dataset
## You will get a base plot (no data)
DavisPlot <- ggplot(Davis, aes(x=weight, y=repwt))
DavisPlot

#  A layer can contain any of many different elements. One of the most  #
#  basic elements that will be contained in a graphics layer is a       #
#  geometric object (ie. points, lines, bars, etc.). These are added    #
#  using one of many functions of the form geom_"object name"(). A full #
#  list of possible geometric objects is given on the ggplot2 website   #
#  or by typing geom_ into the console of RStudio and pressing Tab.     #
#                                                                       #
#  Any layer is added to a graphic by using the + operator.             #

## Adding points to the axes
## Add on layers with '+' 
DavisPlot + geom_point()
help(geom_point)
DavisPlot + geom_point(colour="blue")
DavisPlot + geom_point(fill="blue")

#  The aesthetics that are either default or specified in the aes()     #
#  function can be overwritten by providing new values for aesthetic    #
#  options in the geometric object function. Some of the aesthetics     #
#  that users may be interested in changing are the position, the       #
#  color, the fill color, the shape, and the size.                      #

## Modifying aesthetic features of points
DavisPlot + geom_point(shape=21, size=2, colour="darkred", fill="blue")
DavisPlot + geom_point(shape=22, size=2, fill="pink")
DavisPlot + geom_point(shape=1, size=2, fill="pink")
DavisPlot + geom_point(shape=22, size=2)



#  Additionally, the points can be made more transparent for cases      #
#  when several points are plotted on top of each other.                #

## Adjusting transparency of data points
## Transparancy ranges between 0 to 1
DavisPlot + geom_point(alpha=0.2)

#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age. #



#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with triangle outlines that are green for the points.                #



#  Alternatively for the case when several points are obscured          #
#  together, a layer can be created that groups points into rectangles  #
#  and shades each rectangle according to how many points are           #
#  contained in that space. This type of layer is created using the     #
#  function stat_bin2d().                                               #

## Binning the data points
DavisPlot + stat_bin2d()

#  If a scatterplot contains points belonging to different groups,      #
#  different shapes or colors can be used to differentiate the groups.  #
#  Automatically varying shapes or colors for the entire graphic        #
#  should be specified in the aesthetics function, aes().               #

## Setting varying colors for different groups
ggplot(Davis, aes(x=weight, y=repwt, colour=sex)) + geom_point() 

## Specifying colors for different groups
## Scale color = changing the scale
## change this manually
ggplot(Davis, aes(x=weight, y=repwt, colour=sex)) + geom_point() +
  scale_colour_manual("sex", values=c("M"="blue","F"="red"))

ggplot(Davis, aes(x=weight, y=repwt, colour=sex)) + geom_point(shape = 21, fill="green")

Davis



Davis

help(ggplot)
## Setting varying colors and shapes for different groups
help(geom_point)
ggplot(Davis, aes(x=weight, y=repwt, colour=sex, shape=sex)) + geom_point()

#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with triangle outlines that vary by color to represent the five      #
#  different trees.                                                     #



#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with varying shapes that represent the five different trees and      #
#  that are all green.                                                  #



#  Differing colors can be used to designate the scale of a continuous  #
#  variable as well.                                                    #

## Setting varing colors for levels of a continuous variable
ggplot(Davis, aes(x=weight, y=repwt, colour=repht)) + geom_point() 
ggplot(Davis, aes(x=weight, y=repwt, colour=sex)) + geom_point() 



#  The value of another continuous variable can be represented by the   #
#  size of the point.                                                   #

## Setting size of point for value of a continuous variable
ggplot(Davis, aes(x=weight, y=repwt, size=repht)) + geom_point()
#  Differing groups can also be plotted in separate grids.              #

## Separating groups into plots separated vertically
## facet_grid takes in a formula
## ~ replaces the =
DavisPlot + geom_point() + facet_grid(sex~.)

## Separating groups into plots separated horizontally
DavisPlot + geom_point() + facet_grid(.~sex)
DavisPlot + geom_point() + facet_grid(.~sex)
Davis


#  Additional example:                                                  #
#  Create five separated scatterplots for the orange tree               #
#  circumference vs. tree age with green triangle outlines.             #



#  For data sets with more than one grouping variable, the plots can    #
#  be split by two of the grouping variables to create a scatterplot    #
#  matrix.                                                              #

## Look at the first five rows of the mpg data set
mpg[1:5,]
names(mpg)

## Create mpg plot of highway mpg vs. engine displacement and add points
mpgPlot <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
mpgPlot

## Separate plots based on type of drive (front, rear, all)
mpgPlot + facet_grid(.~drv)

## Separate plots based on number of cylinders 
mpgPlot + facet_grid(cyl~.)

## Separate plots based on both type of drive and # of cylinders
mpgPlot + facet_grid(cyl~drv)

#  By default all of the axes will have the same range. Users can allow #
#  the horizontal axis, vertical axis, or both to vary.                 #

## Varying vertical axes
mpgPlot + facet_grid(cyl~drv, scales="free_y")

## Varying horizontal axes
mpgPlot + facet_grid(cyl~drv, scales="free_x")

## Varying vertical and horizontal axes
mpgPlot + facet_grid(cyl~drv, scales="free")

#  Additional example:                                                  #
#  Create five separated scatterplots for the orange tree               #
#  circumference vs. tree age with green triangle outlines and let      #
#  both axes vary.                                                      #



#  For grouping variables with too many levels to make side-by-side     #
#  unfeasible, a facet wrap can be used.                                #

## Using facet wrap to create subplots based on vehicle class
mpgPlot + facet_wrap(~class)
mpgPlot + facet_wrap(.~drv)
mpgPlot + facet_grid(.~drv)

mpgPlot + facet_wrap(~class, nrow=2)

#######################################
#  Scatterplots with regression line  #
#######################################

#  A smoothing line can be added to any scatterplot using the           #
#  geom_smooth() function. The default smoothing line will attempt to   #
#  smooth out the data into a curve that best fits the data.            #

## Adding default smoothing line
## Doesn't account for outlier
DavisPlot + geom_point() + geom_smooth()
DavisPlot  + geom_smooth()


#  Options can be specified in the geom_smooth() function for the       #
#  smoothing line to use a particular method, such as linear regression.#

## Adding the linear regression line
## lm = linear models (parameter of which line to add)
## Default color = blue and the band is grey
## the grey part is the confidence interval
## Has an hourglasss like shape
DavisPlot + geom_point() + geom_smooth(method=lm)

#  The default color of the smoothing line is blue and can be changed   #
#  using the colour option.                                             #

## Adding a black linear regression line
DavisPlot + geom_point() + geom_smooth(method=lm, colour="black")

#  The  geom_smooth() function default is to include the confidence     #
#  interval bands in a shaded region around the regression line. These  #
#  shaded bands are gray by default, but can be changed using the fill  #
#  option. 

## Changing color of confidence bands
DavisPlot + geom_point() + geom_smooth(method=lm, fill="blue", colour="red")

#  The confidence bands can be made less prevalent by changing the      #
#  transparency of the shading. A transparency setting of zero is fully #
#  transparent and a transparent setting of one is fully opaque.        #

## Lessening the prevalence of the confidence bands
## The line does not become trasnparent...only the confidence bans. 
DavisPlot + geom_point() + geom_smooth(method=lm)
DavisPlot + geom_point() + geom_smooth(method=lm, alpha=0.2)
DavisPlot + geom_point() + geom_smooth(method=lm, alpha=0)


#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with green points and a green linear regression line and             #
#  corresponding confidence bands lightly shaded green.                 # 



#  The shaded bands can be removed using the standard error option, se. #

## Adding the linear regression line without the confidence bands
## se=F takes out standard error part
DavisPlot + geom_point() + geom_smooth(method=lm, se=F)

#  If the universal settings of a graphic have defined different        #
#  colors for different groups, separate regression lines and           #
#  confidence bands will be added for each group.                       #

## Adding regression lines for groups
ggplot(Davis, aes(x=weight, y=repwt, colour=sex)) + geom_point() +
  geom_smooth(method=lm) 

#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with points and regression lines (without confidence bands) that     #
#  vary by color to represent the five different trees.                 #
Orange$circumference
ggplot(Orange, aes(x=Orange$age, y=Orange$circumference, 
                   color=Orange$Tree)) + geom_point() + geom_smooth(method = lm, se=F)


################
#  Line plots  #
################

#  When data consist of one variable that represent values in a         #
#  specified order, a line plot can be used to show the trend of the    #
#  data. One common example of this type of plot is a time series plot. #

## Look at US population data (in the car package)
USPop[1:5,]

## Create line plot
ggplot(USPop, aes(x=year, y=population)) + geom_line() + geom_point()
ggplot(USPop, aes(x=year, y=population)) + geom_smooth(method=lm, se=F) + geom_point()
ggplot(USPop, aes(x=year, y=population)) + geom_smooth(linetype="dashed")


#  The options within the geom_line() function can be used to change    #
#  the line type, color, and size.                                      #

## Modify aesthetic features of line
ggplot(USPop, aes(x=year, y=population)) + 
  geom_line(linetype="dashed", size=1, colour="blue")
  
#  To also show the points on a line plot, a layer can be added with    #
#  the data points.                                                     #

## Adding data points to line plot
ggplot(USPop, aes(x=year, y=population)) + geom_line() + geom_point()
ggplot(USPop, aes(x=year, y=population)) + geom_smooth() + geom_point()


#  There may be situations when it is useful to plot several line       #
#  plots that distinguish separate groups together. A muliple line      #
#  plot can be created by specifying the grouping variable to vary      #
#  over the line type and/or line color.                                #

## Look at US population data separated by age group (in gcookbook package)
uspopage[1:16,]

## Creating a multiple line plot
ggplot(uspopage, aes(x=Year, y=Thousands, linetype=AgeGroup)) + geom_line()

## These two have same functionality
ggplot(uspopage, aes(x=Year, y=Thousands, colour=AgeGroup)) + geom_line() + geom_point(shape=21, colour="black")
ggplot(uspopage, aes(x=Year, y=Thousands)) + geom_line(aes(colour=AgeGroup)) + geom_point(shape=21, colour="black")


 #  Additional example:                                                  #
#  Create a set of line plots with points, one for each orange tree's   #
#  circumference over its lifetime.                                     #
Orange
ggplot(Orange, aes(x=age, y=circumference)) + geom_line(aes(colour=Tree))

################
#  Bar graphs  #
################

#  When conducting an experiment and measuring a response over various  #
#  treatment groups, bar graphs are a useful way to graphically         #
#  summarize the data.                                                  #
#                                                                       #
#  The geom_bar() function will add a layer of bars to the graphic. An  #
#  input that is required for this function is the stat option. This    #
#  input indicates what statistical transformation to use on the data   #
#  for this layer. By default the geom_bar() function will group and    #
#  count the number of responses or use a variable that has already     #
#  been created in the data set if identity is specified for the stat   #
#  option.                                                              #

## Look at pg_mean data set (in gcookbook package)
pg_mean

## Create bar graph to view the means of the treatment groups
bar1 <- ggplot(pg_mean, aes(x=group, y=weight))
bar1 + geom_bar(stat="identity")

#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the number of       #
#  vehicles manufactured with each type of transmission.                #

mpg
barmpg <- ggplot(mpg, aes(x=trans))
barmpg + geom_bar()
help(geom_bar)


#  To plot a bar graph that represents a statistical measure other      #
#  than the count, the stat_summary() function can be used. This        #
#  function takes at least two inputs - the function to apply to the    #
#  data and the geometric object to create in the layer. The specified  #
#  function can be applied to just the y-variable or to the entire      #
#  data set by using the options fun.y or fun.data.                     #

## Look at the PlantGrowth data set
PlantGrowth[1:5,]

## Create bar graph to view the means of the treatment groups
bar2 <- ggplot(PlantGrowth, aes(x=group, y=weight)) 
bar2 + stat_summary(fun.y=mean, geom="bar")
bar2 + stat_summary(fun.y=median, geom="bar")


#  Regardless of the function used to create the bar layer, aesthetic   #
#  features (color, border, separation, etc.) can be changed within     #
#  the layer function.                                                  #

#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the average         #
#  highway mileage for each type of transmission.                       #

mpg
ggplot(mpg, aes(x=trans, y=hwy)) + stat_summary(fun.y=mean, geom="bar")
## Modifying aesthetics of the bar graph
bar1 + geom_bar(stat="identity", fill="orange", colour="blue")
bar2 + stat_summary(fun.y=mean, geom="bar", fill="orange", colour="blue")

## Modifying the spacing of the bar graph
bar1 + geom_bar(stat="identity")
bar1 + geom_bar(stat="identity", width=0.5)
bar1 + geom_bar(stat="identity", width=1)

#  If the height of the bars represents the means of various groups,    #
#  error bars can be added to the plot to either represent confidence   #
#  limits or a single standard error of the mean. These error bars are  #
#  added as a new layer to the graphic.                                 #

## Adding error bars to the bar graph (CI)
## mean_cl_normal = CI
## Shud i add CI without checking the data. If we dont know pop std then we use t.
## Assumption for t confidence interval is that we have normal data
## we can ignore this if we have alot of data
## however we do not have big data
## adding these ci may not be statistically right. 
bar2 + stat_summary(fun.y=mean, geom="bar", fill="white", colour="black", width=0.5) +
  stat_summary(fun.data=mean_cl_normal, geom="errorbar", width=0.2)

## Adding error bars to the bar graph (one standard error)
bar2 + stat_summary(fun.y=mean, geom="bar", fill="white", colour="black", width=0.5) +
  stat_summary(fun.data=mean_se, geom="errorbar", width=0.5)

#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the average         #
#  highway mileage and its confidence interval for each type of         #
#  transmission.                                                        #
mpg
ggplot(mpg, aes(x=trans, 
                y=hwy)) + stat_summary(fun.y=mean, 
                                       geom="bar", fill="white") + stat_summary(fun.data=mean_cl_normal, 
                                                                                geom="errorbar", width=0.5)
#  In the case of experiments with more than one variable that defines  #
#  each treatment group or in the case where there are more than one    #
#  groups of interest, it is useful to separate the bars of the plot    #
#  to distinguish the groups.                                           #

## Look at cabbages data set (in MASS package)
cabbages[1:5,]

## Create bar graph for average weight, separated by cultivation
bar3 <- ggplot(cabbages, aes(x=Date, y=HeadWt, fill=Cult)) 
bar3 + stat_summary(fun.y=mean, geom="bar")

#  Even if groups are specified by different fill color in the base     #
#  layer, bars will be plotted on top of each other unless the user     #
#  specifies otherwise. The dodge option for the position input         #
#  indicates that bars should not overlap.                              #

## Create bar graph for average weight, separated by cultivation
## Put bars next to each other
## Position = 'dodge'
## without this it hides the data
bar3 + stat_summary(fun.y=mean, geom="bar", position="dodge")

#  By default, bars within groups will never have space between them,   #
#  even if the width is adjusted.                                       #

## Adjusting width
bar3 + stat_summary(fun.y=mean, geom="bar", position="dodge", width=0.5)
bar3 + stat_summary(fun.y=mean, geom="bar", position=position_dodge(0.7), width=0.5)

#  In order to add space between the bars within a group, the position  #
#  needs to be adjusted. When the dodge option is specified, the        #
#  function is using position_dodge(0.5). Changing the value in the     #
#  position_dodge() function will adjust the separation between bars    #
#  within groups.                                                       #

## Adding space between bars within groups
## position = position_dodge(0-1)
bar3 + stat_summary(fun.y=mean, geom="bar", position=position_dodge(1), 
                    width=0.5)

#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the average         #
#  highway mileage and its confidence interval for each type of         #
#  transmission separated by the drive.                                 #
mpg
ggplot(mpg, aes(x=trans, y=hwy, fill=drv)) + stat_summary(fun.y=mean, geom="bar", position=position_dodge(0.7),width=0.5) + stat_summary(fun.data=mean_cl_normal, geom="errorbar", width=0.5)
#  In some plots, it is useful to add the value of the height of each   #
#  bar onto the plot. If these values are part of the initial data set, #
#  a layer is added using the geom_text() function. If these values     #
#  were calculated using the stat_summary() function, a new layer       #
#  using a second stat_summary() function is used.                      #

## Adding bar height values
## ..y.. = what i calculate represent that as my text
## number is in bar due to the vjust parameter
## finding position_dodge is guess and check
bar3 + stat_summary(fun.y=mean, geom="bar", position="dodge") +
  stat_summary(fun.y=mean, geom="text", aes(label=..y..), vjust=1.5, 
               position=position_dodge(0.9), colour="white")
help(aes)
#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the average         #
#  highway mileage and its value for each type of transmission          #
#  separated by the drive.                                              #

ggplot(mpg, aes(x=trans, y=hwy, fill=drv)) + stat_summary(fun.y=mean, position="dodge", geom="bar", width=0.8) + stat_summary(fun.y=mean, geom="text", vjust=0.8, aes(label=..y..),position=position_dodge(0.01))
ggplot(mpg, aes(x=trans, y=hwy)) + stat_summary(fun.y=mean, geom="bar", width=0.5) + stat_summary(fun.y=mean, geom="text", vjust=0.8, aes(label=..y..), width=0.5, position=position_dodge(0.5))

midwest[1:5,]
bar3 <- ggplot(midwest, aes(x=state, fill=as.factor(inmetro))) + geom_bar(position="dodge")
bar3 <- ggplot(midwest, aes(x=state, fill=as.factor(inmetro))) + geom_bar(position="dodge")
bar3
bar3 <- ggplot(midwest, aes(x=state, fill=category)) + geom_bar()
bar3
##############
#  Boxplots  #
##############

#  Boxplots give users the ability to quickly compare population        #
#  distributions using the information contained in the five-number     #
#  summary.                                                             #

## Look at birthwt data (in MASS package)
birthwt[1:5,]

## Label race values in data
bwdata <- birthwt
bwdata
bwdata$race <- factor(bwdata$race, labels=c("white","black","other"))
bwdata[1:4,]
birthwt[1:4,]
## Create boxplots for birth weights separated by mother's race
bxplot <- ggplot(bwdata, aes(x=race, y=bwt)) 
bxplot + geom_boxplot() + geom_point(shape=4, aes(colour=race))
help(aes)
bxplot + geom_boxplot() + geom_jitter(shape=4, aes(colour=race))
## Jitter makes it spread out ( no covering it up )
## they get a random horizatal position
bxplot + geom_boxplot() + geom_dotplot(binaxis = "y", stackdir="center", aes(colour=race, fill=race))
ggplot(bwdata, aes(x=race, y=bwt, color=race, fill=race)) + geom_boxplot() + geom_dotplot(binaxis = "y")
##dotplot ...size of dots get smaller if the diagram gets bigger...


#  Additional example:                                                  #
#  Create boxplots using the mpg data for highway mileage separated by  #
#  the drive.                                                           #

mpg
ggplot(mpg, aes(x=drv, y=hwy)) + geom_boxplot()
ggplot(mpg, aes(x=drv, y=hwy)) + geom_boxplot() + geom_point(shape=22, aes(color=drv))
ggplot(mpg, aes(x=drv, y=hwy)) + geom_boxplot(outlier.shape = 4) + geom_point(shape=21, aes(color=drv, fill=drv))
ggplot(mpg, aes(x=drv, y=hwy)) + geom_boxplot(outlier.shape = 4) + geom_jitter(shape=21, aes(color=drv, fill=drv))
ggplot(mpg, aes(x=drv, y=hwy)) + geom_boxplot(outlier.shape = 4) + geom_dotplot(shape=21, stackdir="center", aes(color=drv, fill=drv), binaxis="y")



#  If one of the population groups is of particular interest, that      #
#  singular boxplot can be subset by specifying its group as x in the   #
#  base layer.                                                          #

## Plot the boxplot for one population
ggplot(bwdata, aes(x="other", y=bwt))  + geom_boxplot()

#  The spaces between multiple boxplots can be modified with the        #
#  width option.                                                        #

## Modify the space between the boxplots
bxplot + geom_boxplot()
bxplot + geom_boxplot(width=0.5)

#  Outliers are marked as points on each boxplot. If there are many     #
#  outliers, the aesthetics of the outliers can be modified to unmask   #
#  any overlapped points.                                               #

## Modifing outlier aesthetics
bxplot + geom_boxplot(outlier.size=5, outlier.shape=21)

#  To emphasize the location of the median of each population, notches  #
#  can be added to the boxplots.                                        #

## Adding notches to boxplots
bxplot + geom_boxplot(notch=TRUE)

#  Markers for the mean of each population can be added to the boxplot  #
#  using the stat_summary() function.                                   #

## Adding markers for the means
bxplot + geom_boxplot() + stat_summary(fun.y="mean", geom="point")
bxplot + geom_boxplot() + 
  stat_summary(fun.y="mean", geom="point", shape=21, size=3)

#  Additional example:                                                  #
#  Create boxplots with markers for the means using the mpg data for    #
#  highway mileage separated by the drive.                              #

ggplot(mpg, aes(x=drv, y=hwy))+ geom_boxplot()+ stat_summary(fun.y=mean, geom="point", size=3, shape=4)

################
#  Histograms  #
################

#  Histograms allow us to see the distribution of a sample in more      #
#  detail by plotting the frequencies over several bins.                #

## Look at the faithful data
faithful[1:5,]

## Create histogram of waiting times
hist1 <- ggplot(faithful, aes(x=waiting))
hist1 + geom_histogram()

#  The width (and number) of bins can be specified with the binwidth    #
#  option. Users can either specify a value or calculate the number of  #
#  bins based on the range of the data. The bar aesthetics can be       #
#  modified using the fill and colour options.                          #

## Change number of bins in a histogram
binsize <- diff(range(faithful$waiting))/8
hist1 + geom_histogram(binwidth=binsize, fill="white", colour="black")
hist1 + geom_histogram(binwidth=5, fill="white", colour="black")

#  Additional example:                                                  #
#  Create a histogram with 4 bins using the mpg data for highway        #
#  mileage.                                                             #
binsize = diff(range(mpg$hwy))/4
ggplot(mpg, aes(x=hwy)) + geom_histogram(binwidth=binsize,fill="white", colour="black")

#  Additional example:                                                  #
#  Create a histogram with bins of width 4 using the mpg data for       #
#  highway mileage.                                                     #

ggplot(mpg, aes(x=hwy)) + geom_histogram(binwidth=4,fill="white", colour="black")


#  For users who would like to compare histograms for multiple groups,  #
#  the function facet_grid() can be used to split the frame and         #
#  display multiple histograms.                                         #

## Look at the birthwt data (in MASS package)
birthwt[1:5,]

## Change labels for smoking and nonsmoking mothers
bwdata <- birthwt
bwdata$smoke <- factor(bwdata$smoke, labels=c("Nonsmoking","Smoking"))

## Create histograms for birth weights separated by mothers' smoking habits
hist2 <- ggplot(bwdata, aes(x=bwt))
hist2 + geom_histogram(binwidth=250, fill="white", colour="black") +
  facet_grid(smoke~.) #smoking on right side
hist2 + geom_histogram(binwidth=250, fill="white", colour="black") +
  facet_grid(.~smoke) #top label is smoking

#  Additional example:                                                  #
#  Create separate histograms each with bins of size 4 using the mpg    #
#  data for highway mileage by drive.                                   #

ggplot(mpg, aes(x=hwy)) + geom_histogram(binwidth = 4, fill="white", color="black") + facet_grid(.~drv) + stat_function(fun=dnorm)
ggplot(mpg, aes(x=hwy)) + geom_histogram(binwidth = 4, fill="white", color="black") + facet_wrap(.~drv, nrow=2)
help("facet_wrap") + stat_function(fun=dnorm)
#  Another option for comparing multiple histograms is to overlay them  #
#  and make them semitransparent.                                       #

## Overlapping histograms
ggplot(bwdata, aes(x=bwt, fill=smoke)) + 
  geom_histogram(binwidth=250, position="identity", alpha=0.4)
## Are sample sizes the same? Who knows?
## Is this normal? We might be able to plot the curve idk lol 

############################
#  Distribution functions  #
############################

#  The defined probability distributions each have four functions in R. #
#  Each distribution has a general function name (ie. norm, binom, t).  #
#  The letter that precedes the distribution name tells R what          #
#  specifically to do with that distribution. The first option,         #
#  denoted by d, gives the value of the probability density function    #
#  at the point specified. The second option, denoted by p, determines  #
#  the cumulative probability of the distribution at the point          #
#  specified. The third option, denoted by q, determines the value      #
#  within the distribution associated with the cumulative probability   #
#  specified. The fourth option, denoted by r, generates random         #
#  numbers from the distribution.                                       #

## Determining the probability density function
dnorm(0)
dbinom(5, size=10, prob=0.3)
dpois(3, lambda=2.5)

## Determining the cumulative probability 
pnorm(1.96)
help(pnorm)
## mean = 0, sd = 1
pnorm(4.5, mean=2, sd=1.6)
pt(2.0, df=6)
punif(0.7)
punif(5, min=3, max=8)
pf(17, df1=3, df2=25)
pchisq(7, df=3)
pbinom(5, size=10, prob=0.3)
ppois(3, lambda=2.5)

## Determining the value corresponding to the cumulative probability
qnorm(0.025)
qnorm(0.7, mean=2, sd=1.6)
qt(0.95, df=12)
qunif(0.35, min=3, max=8)
qf(0.975, df1=3, df2=25)
qchisq(0.99, df=3)
qbinom(0.9, size=10, prob=0.3)
qpois(0.7, lambda=2.5)

## Generating random numbers
rnorm(10)
rnorm(10, mean=2, sd=1.6)
rt(10, df=12)
runif(10)
runif(10, min=3, max=8)
rf(10, df1=3, df2=25)
rchisq(10, df=3)
rbinom(10, size=10, prob=0.3) #pick a value from data since its not a continuous
rpois(10, lambda=2.5) ##pick a value from data since its not a continuous

#  Additional example:                                                  #
#  Determine the probability of drawing a random individual with a      #
#  value of 7.9 or above from a normal distribution with mean 7.3 and   #
#  standard deviation of 0.14.                                          #

#A. dnorm
#B. pnorm(ans)
#C. qnorm 
#D. rnorm


#  Additional example:                                                  #
#  Determine the values from a normal distribution that have 72% of     #
#  all possible values between them.                                    #

#A. dnorm
#B. pnorm
#C. qnorm(ans)
#D. rnorm


#  Additional example:                                                  #
#  Determine the probability that a couple who plan to have four        #
#  children end up having three girls.                                  #

#A. dbinom (ans)
#B. pbinom
#C. qbinom
#D. rbinom

#  Additional example:                                                  #
#  Determine the probability of generating a random number between 2.3  #
#  and 2.9 when the possibilites range from 0 to 5.                     #



#########################
#  Distribution curves  #
#########################

#  There are times when it may be useful to plot the density curve of   #
#  a distribution. These can be created as a layer using the            #
#  stat_function() function and specifying the desired distribution.    #
#  If the distribution function requires additional parameters, they    #
#  are specified in the args option.                                    #

## Plotting a normal distribution curve
Xdata1 <- data.frame(X=c(-4,4))
dist1 <- ggplot(Xdata1, aes(x=X)) 
dist1 + stat_function(fun=dnorm) 

  
## Plotting a normal distribution and t-distribution curve
dist1 + stat_function(fun=dnorm) + 
  stat_function(fun=dt, args=list(df=3), linetype="dashed")

## Plotting a chi-squared curve
Xdata2 <- data.frame(X=c(0,20))
dist2 <- ggplot(Xdata2, aes(x=X))
dist2 + stat_function(fun=dchisq, args=list(df=4))

#  Additional example:                                                  #
#  Create a histogram with bins of width 4 with an overlaid normal      #
#  curve using the mpg data for highway mileage. Use the sample mean    #
#  and standard deviation for the parameters.                           #

ggplot(mpg, aes(x=hwy)) + geom_histogram(binwidth=4, fill="white",color="black") + stat_function(fun=dnorm)


#  Additional example:                                                  #
#  Create a histogram with bins of width 4 with an overlaid             #
#  distribution curve other than normal that might represent the data   #
#  using the mpg data for highway mileage.                              #



#  An area under a curve can be shaded using the geom_area() function.  #
#  Within this function, the density of the distribution must be        #
#  specified along with the x-values to be shaded.                      #

## Shading the area above 1.5 in the normal distribution
dist1  + stat_function(fun=dnorm) + 
  geom_area(stat="function", fun=dnorm, xlim=c(1.5,4))

## Shading the area above and below +/- 1.5 in the normal distribution
dist1  + stat_function(fun=dnorm) + 
  geom_area(stat="function", fun=dnorm, xlim=c(1.5,4)) +
  geom_area(stat="function", fun=dnorm, xlim=c(-4,-1.5))

#  The cumulative probability function of a distribution can be shown   #
#  in a graphic by specifying the distribution function beginning       #
#  with p instead of d.                                                 #

## Plotting the cumulative probability function of the normal distribution
dist1  + stat_function(fun=pnorm)

##############
#  QQ plots  #
##############

#  A common way to verify that data follows a normal distribution is    #
#  by creating a QQ plot or normal probability plot. A QQ plot takes    #
#  the sample data ordered from smallest to largest and compares each   #
#  value with what it would be if the data had been drawn from a        #
#  normal distribution. If the sample data is normally distributed,     #
#  the points will follow the straight reference line in the QQ plot.   #

# QQ = Quantile Quantile. Does data follow normal distribution???       #

## Create a QQ plot for the waiting times
ggplot(faithful, aes(sample = waiting)) + stat_qq()

## Calculate the equation of the reference line
y <- quantile(faithful$waiting, c(0.25, 0.75)) 
x <- qnorm( c(0.25, 0.75))  
slope <- diff(y)/diff(x) 
int <- y[1] - slope*x[1]   

## Add the reference line to the QQ plot
ggplot(faithful, aes(sample = waiting)) + stat_qq() + 
  geom_abline(intercept=int, slope=slope) 

## waitings > 65 are apprx normal ? TRUE##
above <- faithful[which(faithful$waiting > 65),]
y <- quantile(above$waiting, c(0.25, 0.75)) 
x <- qnorm( c(0.25, 0.75))  
slope <- diff(y)/diff(x) 
int <- y[1] - slope*x[1] 

ggplot(above, aes(sample = waiting)) + stat_qq() + 
  geom_abline(intercept=int, slope=slope) 

#  Additional example:                                                  #
#  Create a QQ plot using the mpg data for highway mileage.             #



######################################
#  Modifying the graphic aesthetics  #
######################################

#  The ggplot2 package has two preset themes for its graphics - grey    #
#  and black and white. The grey theme is the default. The theme can    #
#  be changed for specific plots by adding a layer with the theme name. #

## Default grey theme
DavisScatter <- ggplot(Davis, aes(x=weight, y=repwt)) + geom_point()
DavisScatter

## Changing the theme
DavisScatter + theme_bw()

#  If you prefer the black and white theme for all of your graphics,    #
#  you can use the theme_set() function and specify your chosen theme.  #
#  This function will apply only to the current R session and will      #
#  reset every time R is restarted.                                     #

DavisScatter
theme_set(theme_bw()) #Changing default #
DavisScatter
theme_set(theme_grey())
DavisScatter

#  One aesthetic option is to suppress the gridlines. Users can         #
#  suppress either the horizontal lines, vertical lines, or both.       #

DavisScatter + theme(panel.grid.major=element_blank(), 
                     panel.grid.minor=element_blank())
DavisScatter + theme(panel.grid.major.y=element_blank(), 
                     panel.grid.minor.y=element_blank())
DavisScatter + theme(panel.grid.major.x=element_blank(), 
                     panel.grid.minor.x=element_blank())
DavisScatter + theme(panel.grid.major.x=element_line(color="red"), 
                     panel.grid.minor.x=element_line(color="blue"),
                     panel.grid.major.y=element_line(color="green"), 
                     panel.grid.minor.y=element_line(color="orange"))

#Color of these lines can change with panel.grid.minor/major

#  For graphics that will be used in a report or presentation, it is a  #
#  best practice to have a plot title and axis labels that are easily   #
#  understood. The function ggtitle() can be used to add a title to     #
#  the graphic.                                                         #

DavisScatter + ggtitle("Measured and self-reported weights")
DavisScatter + ggtitle("Weights of individuals who regularly exercise")
DavisScatter + ggtitle("Weights of individuals \n who regularly exercise")
DavisScatter + ggtitle("Weights of individuals \nwho regularly exercise")

#  Additionally the function labs() can be used to add a title and/or   #
#  to change the axis labels.                                           #

DavisScatter + labs(title="Weights of individuals who regularly exercise")
DavisScatter + labs(title="Weights of individuals who regularly exercise",
                    x="Measured weight", y="Reported weight")

#  The aesthetics of the graphic labels can be changed using the        #
#  theme() and element_text() functions.                                #

DavisScatter + labs(title="Weights of individuals \nwho regularly exercise",
                    x="Measured weight", y="Reported weight") +
  theme(plot.title=element_text(face="bold", size=20), 
        axis.title.y=element_text(size=14), 
        axis.title.x=element_text(size=14))

#  The axis values themselves can be modified by using axis.text.y=     #
#  and axis.text.x= in the theme() function.                            #
#                                                                       #
#  The range of the axes can be changed using the functions xlim(),     #
#  ylim(), or expand_limits().                                          #

DavisScatter + labs(title="Weights of individuals \nwho regularly exercise",
                    x="Measured weight", y="Reported weight") +
  xlim(0,170) + ylim(0,130)
  
DavisScatter + labs(title="Weights of individuals \nwho regularly exercise",
                    x="Measured weight", y="Reported weight") +
  expand_limits(x=0, y=0)

#  When groups are represented separatedly in a graphic, changes can    #
#  be made to the legend. These changes can be differences in           #
#  aesthetics or a difference in position.                              #

DavisScatter2 <- ggplot(Davis, aes(x=weight, y=repwt, colour=sex)) + 
  geom_point()
DavisScatter2 + labs(title="Weights of individuals who regularly exercise",
                    x="Measured weight", y="Reported weight") +
  theme(legend.position="top")

DavisScatter2 + labs(title="Weights of individuals who regularly exercise",
                     x="Measured weight", y="Reported weight") +
  labs(colour="Gender")

DavisScatter2 + labs(title="Weights of individuals who regularly exercise",
                     x="Measured weight", y="Reported weight") +
  labs(colour="Gender") + 
  scale_colour_discrete(labels=c("Fem123ale","Male"))

DavisScatter2 + labs(title="Weights of individuals who regularly exercise",
                     x="Measured weight", y="Reported weight") +
  labs(colour="Gender") + 
  scale_colour_discrete(limits=c("M","F"), labels=c("F12"="Female","M"="Male")) +
  scale_colour_manual("sex", values=c("M"="blue","F"="orange"))

#  The legend can also be moved inside the plot by using the coordinate #
#  system. The bottom left begins at 0,0 and the top right is 1,1.      #

DavisScatter2 + labs(title="Weights of individuals who regularly exercise",
                     x="Measured weight", y="Reported weight") +
  theme(legend.position=c(1,1), legend.justification=c(1,1))

#  If groups are represented in separate plots, the aesthetics of the   #
#  facet labels can be modified in the theme() function.                #

DavisScatter3 <- ggplot(Davis, aes(x=weight, y=repwt)) + geom_point() +
  facet_grid(.~sex)
DavisScatter3 + theme(strip.background=element_rect(fill="darkgreen"),
                      strip.text.x=element_text(size=14, colour="white"))

#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with green triangle outlines and appropriate titles and labels.      #



#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with triangle outlines that vary by color to represent the five      #
#  different trees and appropriate titles and labels (including the     #
#  legend).                                                             #



#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with varying shapes that represent the five different trees and      #
#  that are all green with appropriate titles and labels (including     #
#  the legend).                                                         # 



#  Additional example:                                                  #
#  Create five separated scatterplots for the orange tree               #
#  circumference vs. tree age with green triangle outlines and          #
#  appropriate titles and labels.                                       #



#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with green points and a green linear regression line and             #
#  corresponding confidence bands lightly shaded green and appropriate  #
#  titles and labels.                                                   # 



#  Additional example:                                                  #
#  Create a scatterplot for the orange tree circumference vs. tree age  #
#  with points and regression lines (without confidence bands) that     #
#  vary by color to represent the five different trees and appropriate  #
#  titles and labels (including the legend).                            #



#  Additional example:                                                  #
#  Create a set of line plots with points, one for each orange tree's   #
#  circumference over its lifetime with appropriate titles and labels.  #



#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the number of       #
#  vehicles manufactured with each type of transmission with            #
#  appropriate titles and labels (including the transmission types).    #



#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the average         #
#  highway mileage and its confidence interval for each type of         #
#  transmission with appropriate titles and labels (including the       #
#  transmission types).                                                 #



#  Additional example:                                                  #
#  Create a bar graph using the mpg data to display the average         #
#  highway mileage and its value for each type of transmission          #
#  separated by the drive with appropriate titles and labels            #
#  (including the transmission types).                                  #



#  Additional example:                                                  #
#  Create boxplots with markers for the means using the mpg data for    #
#  highway mileage separated by the drive with appropriate titles and   #
#  labels (including the drive types).                                  #



#  Additional example:                                                  #
#  Create a histogram with bins of width 4 overlaid with a density      #
#  curve using the mpg data for highway mileage with appropriate        #
#  titles and labels.                                                   #



#  Additional example:                                                  #
#  Create separate histograms each with bins of size 4 using the mpg    #
#  data for highway mileage by drive with appropriate titles and        #
#  labels (including the drive types).                                  #



#  Additional example:                                                  #
#  Create a QQ plot using the mpg data for highway mileage with         #
#  appropriate titles and labels.                                       #



#########################################################################