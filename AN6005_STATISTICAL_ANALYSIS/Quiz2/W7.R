
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
