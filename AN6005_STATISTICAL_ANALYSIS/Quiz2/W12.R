

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





