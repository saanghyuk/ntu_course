#
# Q3
length(ChickWeight$weight[ChickWeight$weight < 100])
median(ChickWeight$weight[ChickWeight$Diet == 2])
View(ChickWeight)

# Q4
apply(USPersonalExpenditure, 2, mean)
sum(USPersonalExpenditure)/5
sum(USPersonalExpenditure["Medical and Health", ])/5

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


# https://seankross.com/notes/dpqr/

pnorm(1.5, 1, sqrt(0.25))


# Sampling
# Default : Simple sample space, without replacement 

# generate a vector that has 3 components drawn from the vector c(1, 3, 5, 7, 9) 
sample(c(1, 3, 5, 7, 9), 3) 

# generate a vector that has 10 components drawn from the vector 1:10 
sample(1:10, 10) 

# generate a vector that has 2 components drawn from the string sample 
sample(c("apple", "banana", "coconut", "durian"), 2) 

# With specific probability
sample(c("rain", "no rain"), 7, prob=c(.4, .6), replace = T)


# Populate the sampling distribution
# sample size = 3
x_bar_3 <- rep(0, 1000) 
x_bar_3 
for (idx in 1:1000){ 
  x_bar_3[idx] <- mean(mean(sample(c(10, 30, 100, 150), 3, prob=c(.3, .2, .4, .1), replace=T))) 
} 
hist(x_bar_3) 

# sample size = 10
x_bar_10 <- rep(0, 1000) 
x_bar_10 
for (idx in 1:1000){ 
  x_bar_10[idx] <- mean(mean(sample(c(10, 30, 100, 150), 10, prob=c(.3, .2, .4, .1), replace=T))) 
  
} 
x_bar_10 
hist(x_bar_10) 

# sample size = 100 
x_bar_100 <- rep(0, 1000) 
x_bar_100 
for (idx in 1:1000){ 
  x_bar_100[idx] <- mean(mean(sample(c(10, 30, 100, 150), 100, prob=c(.3, .2, .4, .1), replace=T))) 
} 
x_bar_100 
hist(x_bar_100) 



# 
?pnorm
pnorm(1.5, 1, sqrt(0.25))
(1.5 - 1)/sqrt(0.25)
pnorm(1)

1-pnorm(4.26,4.18,0.84/sqrt(50))


# Approximation 문제, 전형적인 유형
1 - pnorm(16, 18, 7/sqrt(42))
pnorm(16, 17.5, 7/sqrt(90))


# Random Algorithm
set.seed(100)
x =rnorm(5)
x

set.seed(200) 
runif(6) 

set.seed(300) 
runif(3, 10, 20) 

set.seed(300) 
runif(6, 10, 20) 


# 
?rbinom
set.seed(1)
x_bar_3=rep(0,1000)
set.seed(1)
for (idx in 1:1000) {
  x_bar_3 [idx] =mean(rbinom(3,10,0.3))
}
hist(x_bar_3)



x_bar_3=rep(0,1000)
for (idx in 1:1000) {
  set.seed(idx)
  x_bar_3 [idx] =mean(rbinom(3,10,0.3))
}
hist(x_bar_3)


# Confidence Interval
# Sample mean of 50 samples = 5000
# Population Variance : 1000000 

# 90% Confidence Interval
X_50 = 5000
a = qnorm(0.95, 0, 1)*(sqrt(1000000/50))
LL = X_50 - a
UL = X_50 + a
LL
UL

# 95% Confidence Interval
X_50 = 5000
a = qnorm(0.975, 0, 1)*(sqrt(1000000/50))
LL = X_50 - a
UL = X_50 + a
LL
UL

# 99% 
X_50 = 5000
a = qnorm(0.995, 0, 1)*(sqrt(1000000/50))
LL = X_50 - a
UL = X_50 + a
LL
UL


# Unknown Population SD CASE
x <- read.csv(file.choose(), header=T) 
n <- length(x$weight) 
x_bar <- mean(x$weight) 
x_bar
S <- sd(x$weight) 
S 

LL <- x_bar - S/sqrt(n) * qt(.975, n-1) 
UL <- x_bar + S/sqrt(n) * qt(.975, n-1) 
c(LL, UL) 


# Tutorial Questions

# Q1
X_bar = 106
X_sd = 15
n = 22

LL = X_bar - qnorm(0.95)*(X_sd/sqrt(22))
UL = X_bar + qnorm(0.95)*(X_sd/sqrt(22))
c(LL, UL)

LL = X_bar - qnorm(0.995)*(X_sd/sqrt(22))
UL = X_bar + qnorm(0.995)*(X_sd/sqrt(22))
c(LL, UL)

# Q2
X_bar = 7790
X_sd = 500
n = 100
LL = X_bar - qnorm(0.995)*(X_sd/sqrt(n))
UL = X_bar + qnorm(0.995)*(X_sd/sqrt(n))
c(LL, UL)

# Q3 unknown sigma case
X_bar = 11.5
X_sd = 9.2
n = 18
LL = X_bar - qt(0.975, n-1)*(X_sd/sqrt(n))
UL = X_bar + qt(0.975, n-1)*(X_sd/sqrt(n))
c(LL, UL)


# Q4
weight_10 = ChickWeight$weight[ChickWeight$Time==10]
mean_10 = mean(weight_10)
sd_10 = sd(weight_10)
n = length(weight_10)

LL <- mean_10 - qt(0.95, n-1)*(sd_10/sqrt(n))
UL <- mean_10 + qt(0.95, n-1)*(sd_10/sqrt(n))
c(LL, UL)



weight_0 = ChickWeight$weight[ChickWeight$Time==0]
mean_0 = mean(weight_0)
sd_0 = sd(weight_0)
n = length(weight_0)

LL <- mean_0 - qt(0.95, n-1)*(sd_0/sqrt(n))
UL <- mean_0 + qt(0.95, n-1)*(sd_0/sqrt(n))
c(LL, UL)


# Q5
(2*qnorm(0.975)*100)^2

# Q6
sd_a = 0.206
sd_b = 0.128

(qnorm(0.975)*(0.206/0.04))^2
(qnorm(0.975)*(0.128/0.04))^2


# Q7
x <- read.csv(file.choose())
x
x_mean = mean(x$score)
x_sd = sd(x$score)
n = length(x$score)

LL = x_mean - qt(0.975, n-1)*(x_sd/sqrt(n))
UL= x_mean + qt(0.975, n-1)*(x_sd/sqrt(n))
c(LL, UL)

LL = x_mean - qt(0.995, n-1)*(x_sd/sqrt(n))
UL= x_mean + qt(0.995, n-1)*(x_sd/sqrt(n))
c(LL, UL)

# Type I error: Reject H0 while it is true (false positive). The software does not reduce cost (\mu\geq$100), but the manager concludes it can.   
# Type II error. Do not reject H0 while it is false (false negative). The software does reduce cost (\mu<$100), but the manager concludes it does not cut costs.

# t.test는 명령어로 한번에 가능하다. 
t.test(dax_30, mu = 1620) 


# Hypothesis Testing 
# H0 : mu = 3.97
# H0 : mu != 3.97

# 1. Setting the Rejection Region under Z.  
# Suppose pop. variance = 1 
# We wants to know RR(Rejection Region) under Z  
# a = 10% case 
qnorm(0.95, 0, 1) 
qnorm(0.05, 0, 1) 

# Load Runners_100_2019.csv(contains 100 randomly selected runners) 
# 2. Calculate test statistics.  
# Current H0 : mu = 3.97
runner_19 <- read.csv(file.choose(), header = TRUE) 
x_bar100 <- mean(runner_19$hr) 
x_bar100 
z <- (x_bar100-3.97)/(1/sqrt(100)) 
z 

# two-sided test에서는 p-value 구할때 2*p_value
pnorm(z)
p_value = 2*(pnorm(z))
p_value
# conclusion 
# -3.657 is in the rejection region, we reject the null hypothesis 



# Two sided testing
# Assume that we know the population sigma 
# H0 : mu = 115
# H1 : mu != 115
# a = 5%

library(datasets)
n = length(ChickWeight$weight)
z = ((mean(ChickWeight$weight) - 115) / (70/sqrt(n)))
p_value = 2*(1-pnorm(z))
p_value


# Two sided testing
# Assume that we don't know the population sigma 
# H0 : mu = 125
# H1 : mu != 125
# a = 5%

library(datasets)
n = length(ChickWeight$weight)
sample_sd = sd(ChickWeight$weight)
t = ((mean(ChickWeight$weight) - 125) / (sample_sd/sqrt(n)))
p_value = 2*(pt(t, n-1))
p_value



# One-sided Testing
# sigma known case
# population sigma  = 70
# H0 : mu >= 125
# H1 : mu < 125
# H1이 위처럼 mu가 특정 숫자보다 작다이면, 
# P-value구할때는 해당 t or z statistic보다 아래 있는 면적을 재야지. 
# 당연하다. 
library(datasets)
n = length(ChickWeight$weight)
z = ((mean(ChickWeight$weight) - 125) / (70/sqrt(n)))
z
pnorm(z)
p_value = pnorm(z)



# Tutorial Questions
# Q6

# 두 샘플의 population mean 차이 = 0  에 대한 검정
day_0_weight <- ChickWeight[ChickWeight$Time==0, ]$weight 
day_2_weight <- ChickWeight[ChickWeight$Time==2, ]$weight 

t.test(day_0_weight, day_2_weight) 

# 한 샘플의 population = 0 에 대한 검정
t.test(day_0_weight) 
#Conclusion : true mean is not equal to 0 


# 
df_EuStockMarket <- as.data.frame(EuStockMarkets) 
df_EuStockMarket
dax_30 <- df_EuStockMarket[1:30, "DAX"] 
t.test(dax_30, mu = 1620) 

# manually
length(EuStockMarkets[1:30,"DAX"])
t_29=(mean(EuStockMarkets[1:30,"DAX"])-1620)/(sd(EuStockMarkets[1:30,"DAX"])/sqrt(30))
2*(1-pt(t_29, 29))

#Thus, the p-value is 2*(1-pt(t_29,29))= 0.04853575





dax_1 <- df_EuStockMarket[1:30, "DAX"] 
dax_2 <- df_EuStockMarket[31:60, "DAX"] 
t.test(dax_1, dax_2) 



# Linear Regression
install.packages("wooldridge") 
library(wooldridge) 
View(wage2) 
reg.results <- lm(wage ~ educ + exper + tenure, data = wage2) 
summary(reg.results) 



# Categorical  

library(wooldridge)
View(wage1)
View(wage1$female) 
reg.results.wage1 <- lm(wage ~ educ + exper + tenure + female, data = wage1) 
summary(reg.results.wage1) 


# Categorical 2
fake_data = read.csv(file.choose(), header=T) 
fake_data$year.factor = factor(fake_data$year) 
fake_data$year.factor 

reg_cat = lm(spending ~ female + year.factor, data=fake_data) 
summary(reg_cat) 



# Regression Example
library(wooldridge) 
ceosal1
colnames(ceosal1) 
df1 = data.frame(ceosal1) 
df1$indus = as.factor(df1$indus) 
ceosal1$indus
df1$indus
salary_reg = lm(salary ~ ., data=df1) 

summary(salary_reg) 



# Q3
scores = read.csv(file.choose(), header=T) 
scores 
score_reg = lm(score ~ female, data=scores) 
summary(score_reg) 


# Q4
library(wooldridge) 
ceosal1 
colnames(ceosal1) 
df1 = data.frame(ceosal1) 
df1$indus = as.factor(df1$indus) 
salary_reg = lm(salary ~ ., data=df1) 
summary(salary_reg) 

df2 = data.frame(ceosal1) 
df2$finance = as.factor(df2$finance) 
salary_reg = lm(salary ~ ., data=df2) 
summary(salary_reg) 


library(moments)
library(wooldridge) 
df = wooldridge::kielmc 
colnames(df) 

# skewed right
skewness(df$price) 

library(wooldridge)
reg1<-lm(log(price)~log(dist),data=kielmc)
summary(reg1)


# Q4
library(wooldridge) 
df = wooldridge::apple 
colnames(df) 
sum(df$ecolbs==0) 
# skewed right
skewness(df$ecolbs) 


reg.results.woold <- lm(ecolbs ~ ecoprc +  regprc,data=df) 
summary(reg.results.woold) 




n <- 30  
set.seed(456) 
# Assume
kelly <- rexp(n, 10) 
dan <- rgamma(n, 0.3, 10) 
wait_time <- abs(kelly-dan) 

# sample mean 
X_barw <- mean(wait_time) 

# sample sd 
Sw <- sd(wait_time) 

# lower and upper limits of CI 
LLw <- X_barw - Sw/sqrt(n)*qt(0.975, n-1) 
ULw <- X_barw + Sw/sqrt(n)*qt(0.975, n-1) 
LLw 
ULw 






total_value <- 0 
for (sample_size in 1:10){
  contribution <- 5000 
  value_by_year <- 0 
  
  for (year in 1:10){ 
    return <- runif(1, min=-.03, max=.10) 
    value_by_year[year+1] <- (value_by_year[year]+contribution)*(1+return) 
  } 
  total_value[sample_size] = value_by_year[11] 
} 

mean_total <- mean(total_value) 
sd_total <- sd(total_value) 

LL <- mean_total - sd_total/sqrt(1000)*qt(.975, 999) 
UL <- mean_total + sd_total/sqrt(1000)*qt(.975, 999) 
c(LL, UL) 



# Q2
# 2-1
set.seed(200)
value = 0
contribution = c(1000, 0, 0, 0, 0)
for(i in 1:5){
  value[i+1] = (value[i] + contribution[i])*(1+runif(1, -0.03, 0.07))
}
value[6]



# 2-2
set.seed(200)
return_samples = c()
for (j in 1:100){
  value = 0
  contribution = c(1000, 0, 0, 0, 0)
  for(i in 1:5){
    value[i+1] = (value[i] + contribution[i])*(1+runif(1, -0.03, 0.07))
  }
  return_samples[j] = value[6]
}
mean(return_samples)

# 2-3
set.seed(200)
value = 0
contribution = rep(1000, 5)
for(i in 1:5){
  value[i+1] = (value[i] + contribution[i])*(1+runif(1, -0.03, 0.07))
}
value[6]

# 2-4

set.seed(200)
value = 0
contribution = 1000
for(i in 1:5){
  value[i+1] = (value[i] + contribution*i)*(1+runif(1, -0.03, 0.07))
}
value[6]


# 2-5


set.seed(200) 
investment_samples = c() 
voucher_samples = c() 
for(j in 1:100){ 
  investment = 0 
  voucher = 0 
  for(i in 1:5){ 
    investment = investment + 1000 
    return = runif(1, -0.03, 0.07) 
    if (return > 0 ){ 
      voucher = voucher+investment*return 
    }else{ 
      investment = investment*(1+return) 
    } 
  } 
  investment_samples[j] = investment 
  voucher_samples[j] = voucher 
} 

mean(investment_samples) 
mean(voucher_samples) 

mean_voucher = mean(voucher_samples) 
sd_voucher = sd(voucher_samples)
n <- length(voucher_samples)
UL <- mean_voucher + qt(0.975, n-1)*(sd_voucher/sqrt(n))
LL <- mean_voucher - qt(0.975, n-1)*(sd_voucher/sqrt(n))
c(LL, UL)


# Juice Stall Case
X = runif(1, 3, 5) 
today_samples = c() 
set.seed(200) 
for(j in 1:1000){ 
  today = 0 
  unsold = 0 
  for(i in 1:10){ 
    today = today+  runif(1, 3, 5) 
  } 
  unsold = 50 - today 
  today_samples[j]=unsold 
} 

today_samples 
mean(today_samples) 




rnorm(1, 4.5, 1.5) 
today_soldout = 0 
set.seed(200) 
for(j in 1:100){ 
  today = 0 
  for(i in 1:10){ 
    today = today +  rnorm(1, 4.5, 1.5) 
  } 
  if(today > 50){ 
    today_soldout = today_soldout+1   
  } 
} 
today_soldout 






