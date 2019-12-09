#just need info.all
final_index <- length(info.all)-3
info.clustering <- info.all[,c(2:final_index)]
for (i in c(1:(final_index - 1))) {
  print(i)
  if (typeof(info.clustering[,i][2]) != "double") {
    info.clustering[,i] = as.numeric(info.clustering[,i])
    info.clustering[,i] <- sapply(info.clustering[, i], as.numeric)
    print("Done")
  }
}


info.clustering
spam.kmeans <- kmeans(info.clustering, centers = 5, nstart = 20, trace = TRUE)
spam.kmeans$centers
ggplot(info.clustering, aes(Population, deathrate)) +
  geom_point(col = c("blue", "red", "green", "orange", "purple")[spam.kmeans$cluster])

spam.kmeans$cluster
spam.kmeans$totss
sum(spam.kmeans$withinss)
vector <- rep(NA, 20)
for (i in c(1:20)) {
  spam.kmeans_sim <- kmeans(info.clustering, centers = i, nstart = 20, trace = TRUE)
  vector[i] = sum(spam.kmeans_sim$withinss)
}
scale(vector)
mse_kmeans = as.data.frame(cbind(as.numeric(c(1:20)), as.numeric(scale(vector))))
colnames(mse_kmeans) <- c("x", "y")
ggplot((mse_kmeans), aes_string("x", "y")) + 
  geom_point() +
  scale_x_continuous(name="Number of clusters", limits=c(1, 20)) +
  ylab("MSE") +
  ggtitle("MSE vs Number of Clusters") +
  theme_bw()


final_index_clustring <- length(info.class)-3

info.clustering.class <- info.class
info.clustering.class$Population <- NULL
info.clustering.class$State <- NULL
info.clustering.class$Deaths <- NULL

for (i in c(1:length(colnames(info.clustering.class)))) {
  print(i)
  if (typeof(info.clustering.class[,i][2]) != "double") {
    info.clustering.class[,i] = as.numeric(info.clustering.class[,i])
    info.clustering.class[,i] <- sapply(info.clustering.class[, i], as.numeric)
    print("Done")
  }
}


vector.class <- rep(NA, 20)
for (i in c(1:20)) {
  spam.kmeans_sim <- kmeans(info.clustering.class, centers = i, nstart = 200, trace = TRUE)
  vector.class[i] = sum(spam.kmeans_sim$withinss)
}
mse_kmeans_class = as.data.frame(cbind(as.numeric(c(1:20)), as.numeric(scale(vector.class))))
colnames(mse_kmeans_class) <- c("x", "y")
ggplot((mse_kmeans_class), aes_string("x", "y")) + 
  geom_point() +
  scale_x_continuous(name="Number of clusters", limits=c(1, 20)) +
  ylab("WSS") +
  ggtitle("WSS vs Number of Clusters") +
  theme_bw()

#pkgs <- c("factoextra",  "NbClust")
#install.packages(pkgs)
library(factoextra)
library(NbClust)
set.seed(101) # reproducible dataset

# Separate 80%/20% of data as training/testing
sample <- sample.int(n = nrow(info.clustering.class), size = floor(.50*nrow(info.clustering.class)), replace = F)
subset.info.clustering <- info.clustering.class[sample, ]
nrow(subset.info.clustering)
plot_table<- as.data.frame(subset.info.clustering)
for (i in c(1:length(colnames(plot_table)))) {
  print(i)
  if (typeof(plot_table[,i][2]) != "double") {
    plot_table[,i] = as.numeric(plot_table[,i])
    plot_table[,i] <- sapply(plot_table[, i], as.numeric)
    print("Done")
  }
}
method <- fviz_nbclust(plot_table, kmeans, method = "wss",k.max = 20)
method_silhouette <- fviz_nbclust(plot_table, kmeans, method = "silhouette",k.max = 20)
fviz_cluster(kmeans(info.clustering.class, centers = 4, nstart = 25), data = info.clustering.class)

n_clust_silhouette <-method_silhouette$data
max_cluster_silhouette<- as.numeric(n_clust_silhouette$clusters[which.max(n_clust_silhouette$y)])

n_clust_wss <-method$data
max_cluster_wss<- as.numeric(n_clust_wss$clusters[which.max(n_clust_wss$y)])

method + geom_vline(xintercept = 3, linetype = 2) +labs(subtitle = "Elbow method")
method_silhouette + geom_vline(xintercept = 2, linetype = 2) +labs(subtitle = "Silhouette")

print(max_cluster_silhouette)
print(max_cluster_wss)

library(cluster)
gap_stat <- clusGap(plot_table, FUN = kmeans, nstart = 25, K.max=20, B=20)
print(gap_stat, method="firstmax")
fviz_gap_stat(gap_stat)


