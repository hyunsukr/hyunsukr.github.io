#####
# Data Description/viz

# Packages
# install.packages("plotly")

# libraries
library(plotly)

# Doctors by state
states = unique(info.all$State)
doc.states = data.frame(states=matrix(0,ncol=1,nrow=length(states)))
rownames(doc.states) = states
for (i in 1:length(states)) {
  doc.states[i,1]=nrow(info.all[info.all$State==states[i],])
}

plot_ly(x=rownames(doc.states),
        y=doc.states$states, type = 'bar') %>%
  layout(title = 'Number of Doctors by State',
         yaxis = list(title="Number of Doctors"),xaxis = list(title="State"))

# Types of clinicians

clin_tot <- data.frame(observation= colnames(credmat),
                       value = c(colSums(credmat)))
plot_ly(data=clin_tot, labels = ~observation, values = ~value, type = 'pie',
        textfont = list(size = 20)) %>%
  layout(title = 'Types of Clinicians',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         legend = list(font = list(size=22)))

# Clinicians that give at least 10 prescriptions of opiates
clin_opiate = cbind(info.all[,5:9],info.all$Opioid.Prescriber,info.all$opiate)
colnames(clin_opiate) = c("doctor","nurse","other","PA","pharm","Opioid.Prescriber","opiate")
clin_opiate=clin_opiate[clin_opiate$Opioid.Prescriber==1,]

clin_tot_opiate <- data.frame(observation= colnames(credmat), value = c(colSums(clin_opiate[,1:5])))
plot_ly(data=y.test.count, labels = ~observation, values = ~value, type = 'pie',
        textfont = list(size = 20)) %>%
  layout(title = 'Types of Clinicians With > 10 Opioid Prescriptions',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         legend = list(font = list(size=22)))

# Average Prescriptions Given out by each type of Clinician
clin_opiate2 = cbind(info.all[,5:9],info.all$opiate)
colnames(clin_opiate2) = c("doctor","nurse","other","PA","pharm","opiate")
clin_opiate_morethan10 = clin_opiate2[clin_opiate2$opiate>10,]

clin_tot_opiate_mean=c(mean(clin_opiate2$opiate[clin_opiate2[1]==1]),
                       mean(clin_opiate2$opiate[clin_opiate2[2]==1]),
                       mean(clin_opiate2$opiate[clin_opiate2[3]==1]),
                       mean(clin_opiate2$opiate[clin_opiate2[4]==1]),
                       mean(clin_opiate2$opiate[clin_opiate2[5]==1]))

clin_tot_opiate_mean_morethan10=c(mean(clin_opiate_morethan10$opiate[clin_opiate_morethan10[1]==1]),
                                  mean(clin_opiate_morethan10$opiate[clin_opiate_morethan10[2]==1]),
                                  mean(clin_opiate_morethan10$opiate[clin_opiate_morethan10[3]==1]),
                                  mean(clin_opiate_morethan10$opiate[clin_opiate_morethan10[4]==1]),
                                  mean(clin_opiate_morethan10$opiate[clin_opiate_morethan10[5]==1]))

clin_tot_opiate_median=c(median(clin_opiate2$opiate[clin_opiate2[1]==1]),
                         median(clin_opiate2$opiate[clin_opiate2[2]==1]),
                         median(clin_opiate2$opiate[clin_opiate2[3]==1]),
                         median(clin_opiate2$opiate[clin_opiate2[4]==1]),
                         median(clin_opiate2$opiate[clin_opiate2[5]==1]))

clin_tot_opiate_median_morethan10=c(median(clin_opiate_morethan10$opiate[clin_opiate_morethan10[1]==1]),
                                    median(clin_opiate_morethan10$opiate[clin_opiate_morethan10[2]==1]),
                                    median(clin_opiate_morethan10$opiate[clin_opiate_morethan10[3]==1]),
                                    median(clin_opiate_morethan10$opiate[clin_opiate_morethan10[4]==1]),
                                    median(clin_opiate_morethan10$opiate[clin_opiate_morethan10[5]==1]))


plot_ly(x=c("doctor","nurse","other","PA","pharm"),
             y=clin_tot_opiate_mean, type = 'bar') %>%
  layout(title = 'Mean Opiate Prescriptions',
         yaxis = list(title="Mean"))

plot_ly(x=c("doctor","nurse","other","PA","pharm"),
             y=clin_tot_opiate_mean_morethan10, type = 'bar') %>%
  layout(title = 'Mean Opiate Prescriptions Where Opiate RX>10',
         yaxis = list(title="Mean"))

plot_ly(x=c("doctor","nurse","other","PA","pharm"),
             y=clin_tot_opiate_median, type = 'bar') %>%
  layout(title = 'Median Opiate Prescriptions',
         yaxis = list(title="Median"))

plot_ly(x=c("doctor","nurse","other","PA","pharm"),
             y=clin_tot_opiate_median_morethan10, type = 'bar') %>%
  layout(title = 'Median Opiate Prescriptions Where Opiate RX>10',
         yaxis = list(title="Median"))

# p <- subplot(p1, p2, p3, p4,nrows = 2, ncols=2)
# p

# Histogram

plot_ly(x=clin_opiate$opiate[clin_opiate$opiate>10 & clin_opiate$opiate<500], 
        type = 'histogram',nbinsx=20) %>%
  layout(title = 'Number of Opiate Prescriptions Where Opiate RX>10',
         yaxis = list(type='log',title="Number of Prescriptions (log)"), 
         xaxis = list(title="Doctors (binned)"))

# Other Statistics
colMax <- function(data) sapply(data,max,na.rm = TRUE)