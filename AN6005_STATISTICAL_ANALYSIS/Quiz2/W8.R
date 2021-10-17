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

