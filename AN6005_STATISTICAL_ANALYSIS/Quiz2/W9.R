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



