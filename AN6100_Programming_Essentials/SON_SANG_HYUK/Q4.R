library(cluster)

#setwd("/Users/sanghyuk/Desktop/NTU_course/Pre_master/programming_essentials_ 610002/assignment/R_assignment")

data_3b <- read.csv('AN6100-Data-3B.csv')


clusDn = diana(data_3b, metric="euclidean")
#plot(clusDn)
clusDn3 = cutree(clusDn, k=3)


# Q. Which cluster number is the smallest?
# A. Cluster 3
print(table(clusDn3))

# Q. How many people are in the largest cluster? How many in the smallest cluster?
# A. 766, Cluster 1
print(table(clusDn3))

# Q. Calculate the Body-Mass-Index of each person and save BMI in the data frame. What is the mean BMI of all?
# A. 18.89139
data_3b$BMI <- data_3b$Weight / (data_3b$Height)^2

# Q. By plotting Income vs BMI and using clustering results and considering that BMI < 18.5 is unhealthy, write ONE LINE that best describes this smallest cluster.
# A. It seems that "the more income, more heavy". However the correlation between these two factors seems not strong.   

# Black : Cluster 1, Red: Cluster 2, Green : Cluster 3
plot(data_3b$Income.Annual, data_3b$BMI,
     col=clusDn3 , xlab = "Income", ylab="BMI")
# add the line on the BMI 18.5
abline(h=18.5)

library(dplyr)
data_3b$Cluster = as.numeric(clusDn3)
cluster_3 <- data_3b %>% filter(Cluster == 3)
model <- lm(cluster_3$BMI ~ cluster_3$Income.Annual)
summary(model)
