
# 1st Example

n <- 30 
set.seed(456)
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


# 2nd Example 

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
LL
UL


# Q1
x=c(3,-1,5,-2,7,-2,-2,5,10)
for (i in x){
  if (i > 0){
    print("the sample mean is positive")
  }}

if (mean(x) > 0){
  print("the sample mean is positive")
}else{
  print("the sample mean is non-positive")
}

unif_sample = function(){
  sample = runif(1, -.1, 1)
  if (sample > 0 ){
    print("x is positive")
  }
}
unif_sample()


x=c(3,-1,5,-2,7,-2,-2,5,10)
if (mean(x) > median(x)){
  Y = 1
}else{
  Y=0
}
Y



# Q2
set.seed(200) 
1000*(1+runif(1, -0.03, 0.07))^5 


set.seed(200)
Total = c()
for(i in 1:100){
  Total[i] = 1000*(1+runif(1, -0.03, 0.07))^5
}
mean(Total)


set.seed(200)
investment = 0
for(i in 1:5){
  investment = investment + 1000  
  investment = investment*(1+runif(1, -0.03, 0.07))
  print(investment)
}
investment


set.seed(200)
investment = 0
for(i in 1:5){
  investment = investment + 1000*i  
  investment = investment*(1+runif(1, -0.03, 0.07))
  print(investment)
}
investment

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
      voucher = voucher+1000*return
    }else{
      investment = investment*(1+return)
    }
  }
  investment_samples[j] = investment
  voucher_samples[j] = voucher
  
}


mean(investment_samples)
avg_voucher = mean(voucher_samples)
n = length(investment_samples)

S = sd(voucher_samples)
LL <-  avg_voucher - S/sqrt(n) * qt(.975, n-1) 
UL <- avg_voucher + S/sqrt(n) * qt(.975, n-1) 

c(LL, UL) 



# Q3
# 총 50리터 준비
# 하루 10시간 영업
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


# Q4 =
