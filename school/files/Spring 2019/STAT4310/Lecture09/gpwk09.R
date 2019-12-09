library(tidyverse)

sewing <- read_csv('Allstits.txt')

#Plot the density of "Stitch Multiple" using geom_density.
#Recall that histograms count how many datapoints are in each
#bin, and so the shape is sensitive to the size of the bins.
#similarly, a geom_density uses a parameter called bandwidth
#to smooth out the density estimate (otherwise the density estimate)
#will only be nonzero wherever there is a datapoint).  Narrow
#bandwidths make for a wiggly density, and wide bandwidths make for
#a more uniform density (with a really wide bandwidth simply returning
#a uniform distribution).  
#What parameter in geom_density controls bandwidth?
#What two ways can you specify bandwidth?

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot() + geom_density(aes(x=`Stitch Multiple`), bw = 3, adjust=1/2)


#As with barplots and histograms, it is easy to visualize conditional densities.
#Visualize the conditional densities using the three different position methods:
#stack, fill, and dodge.  You will want to adjust the transparency of the densities.
#What is the default method for densities?  Is this the same as the default for histograms?
#What are the strength and weaknesses of each position type?

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + geom_density(aes(fill=Book), position="stack", alpha=0.2)

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + geom_density(aes(fill=Book), position="dodge", alpha=0.2)

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + geom_density(aes(fill=Book), position="fill", alpha=0.2)


sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + geom_density(aes(fill=Book) , alpha=0.2)
## Default is dodge


#Finally, add a "rug" to your plot (this is a tick mark along the x-axis placed wherever there is a data point)
#use the function geom_rug().
#What is the issue with using a rug with this data?  Color the rug points according to the book they came from.
#The issue with rug plots and this data should be even more evident.

sewing %>% 
  mutate(`Stitch Multiple`=as.double(`Stitch Multiple`)) %>%
  ggplot(aes(x=`Stitch Multiple`)) + 
  geom_density(aes(color=Book,fill=Book) , alpha=0.2, bw = 3, adjust=1/3) +
  geom_jitter(position="jitter") + 
  geom_rug(position = "jitter")

#Viz Challenge: Replicate the plot found in challenge09.png


