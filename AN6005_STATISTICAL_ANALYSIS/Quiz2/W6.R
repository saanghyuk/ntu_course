
# Generate Samples
# Draw 5 samples from Uniform Distribution
s1 <- runif(5, min=1, max=2)
sum(s1)/length(s1)

# Common Statistic with R
hist(ChickWeight$weight)
mean(ChickWeight$weight)
median(ChickWeight$weight)
var(ChickWeight$weight)
sd(ChickWeight$weight)
range(ChickWeight$weight)

summary(ChickWeight$weight)
quantile(ChickWeight$weight)

# Q1: 25% of the observations are 'less' than X
# Q3 : 75% of the observations are less than X

quantile(ChickWeight$weight, p=0.5) # Q2 = Median


quantile(ChickWeight$weight, p=0.25)
quantile(ChickWeight$weight, p=0.75)
quantile(ChickWeight$weight, p=0.75)  - quantile(ChickWeight$weight, p=0.25)
IQR(ChickWeight$weight)


# Box Plot
library("datasets")
chick <- ChickWeight
boxplot(chick$weight ~ chick$Diet)


length(chick$weight[chick$weight<100])
nrow(chick[chick$weight < 100, ])

median(ChickWeight$weight[ChickWeight$Diet==2])

# Deal with Table Data

# manual
USPersonalExpenditure[, "1950"]

#colMeans
USPersonalExpenditure
nrow(USPersonalExpenditure)
mean(USPersonalExpenditure)
colMeans(USPersonalExpenditure)
# or 
df_us <- as.data.frame(USPersonalExpenditure)
apply(df_us, 2, mean)

# Particular Row
str(USPersonalExpenditure)
mean(USPersonalExpenditure["Medical and Health", ])
apply(df_us, 1, mean)["Medical and Health"]

# sd returns "sample standard deviation"
?sd



