#####
# Final Project
# Data Setup

# Packages
# install.packages("hashmap")
# install.packages("plotly")
# install.packages("plyr")
# install.packages("mltools")

# Libraries
library(hashmap)
library(plyr)
library(data.table)
library(mltools)

# import data from file
setwd("/Users/maxryoo/Documents/Fall 2019/STAT 5630/Project")
opioids = read.csv("data/opioids.csv")
info = read.csv("data/prescriber-info.csv")
overdose = read.csv("data/overdoses.csv")
class = read.csv("data/drugclass.csv")
cred = read.csv("data/credentials.csv")
spec = read.csv("data/specialty.csv")
colnames(class)[1] = "Drug.Name"

# add drug class to the info matrix
classunique=unique(class$Drug.Class)
info.drug = colnames(info[,6:255])
classmask = data.frame(row.names=classunique)

for (c in 1 : length(classunique)) {
  r = info[1,6:255]
  rownames(r) = classunique[c]
  for (k in 1:length(info.drug)) {
    if (info.drug[k] == class$Drug.Name[k] && class$Drug.Class[k] == classunique[c]){
      r[k] = 1
    } else {
      r[k] = 0
    }
  }
  classmask = rbind(classmask,r)
}

# Apply mask 
info.all = cbind(info,data.frame(t(as.matrix(classmask) %*% as.matrix(t(info[,6:255])))))

# Clean up credentials - add in rows 
credunique=unique(cred$type)
credh = hashmap(cred$credential,cred$type)
credmat = as.data.frame(matrix(0,ncol=length(levels(credunique)),nrow=nrow(info.all)))
colnames(credmat) = levels(credunique)
for (k in 1:nrow(info.all)) {
  credmat[k,credh[[info.all$Credentials[k]]]]=1
}

info.all = cbind(info.all[,1:4],credmat,info.all[,5:length(info.all)])

# Clean up Specialty
specmat = as.data.frame(matrix(0,ncol=ncol(spec)-1,nrow=nrow(info.all)))
colnames(specmat) = colnames(spec)[2:ncol(spec)]

for (i in 1:(ncol(spec)-1)) {
  spech = hashmap(spec$Specialty,spec[,i+1])
  for (k in 1:nrow(info.all)) {
    specmat[k,i]=spech[[info.all$Specialty[k]]]
  }
}

info.all = cbind(info.all[,1:10],specmat,info.all[,11:length(info.all)])

# Add in death rates
OD.state = overdose[,2:4]
colnames(OD.state) <- c("Population", "Deaths", "State")

info.all <- merge(info.all, OD.state)
info.all$deathrate <- as.numeric(gsub(",","",info.all$Deaths,fixed=TRUE)) / as.numeric(gsub(",","",info.all$Population,fixed=TRUE))

# Convert M to 1 and F to 2
gender = one_hot(as.data.table(info.all$Gender))
colnames(gender)=c("Gender.F","Gender.M")
info.all = cbind(info.all[,1:2],gender,info.all[,4:length(info.all)])

info.all.back = info.all

# If you want to work with JUST numbers, use these dataframes
# info.all has ALL drug data and drug classification data
# info.class has just drug classification data

info.all$Specialty = NULL
info.all$Credentials = NULL
info.class = cbind(info.all[,1:10],info.all[,262:length(info.all)])


# Remember that we still need to separate into testing and training data
# For our response, we should use either the number of deaths or the deathrate per state
# Please note that our data is still not totally clean -- there are some nonsense states
#   Look at the Dataviz script for more info