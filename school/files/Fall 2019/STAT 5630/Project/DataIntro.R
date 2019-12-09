#####
# Final Project
#

# import data from file
setwd("/Users/maxryoo/Documents/Fall 2019/STAT 5630/Project")
opioids = read.csv("data/opioids.csv")
info = read.csv("data/prescriber-info.csv")
class = read.csv("data/drugclass.csv")
overdose = read.csv("data/overdoses.csv")
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
info.class = cbind(info.all[,1:5], info.all[,256:318])

head(info.all)
nofull = overdose[,2:4]
colnames(nofull) <- c("Population", "Deaths", "State")
info.full <- merge(info.class, nofull)
info.full$deathrate <- as.integer(info.full$Deaths) / as.integer(info.full$Population)
head(info.full)
tail(unique(info.full$Specialty))
#Practice/Practitioner
#length of 1 word == study
#Surgery
#Oncology
#Medicine
#Provider
#Technician


#### DR
### PCA


# docop=info[info$Opioid.Prescriber==1,]
