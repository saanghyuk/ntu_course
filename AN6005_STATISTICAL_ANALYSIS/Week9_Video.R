# Hypothesis Testing
# 1. Setting the Rejection Region under Z. 
# Suppose pop. variance = 1
# We wants to know RR under Z 

# a = 10% case
qnorm(0.95, 0, 1)
qnorm(0.05, 0, 1)

# Load Runners_100_2019.csv(contains 100 randomly selected runners)
# 2. Calculate test statistics. 

runner_19 <- read.csv(file.choose(), header = TRUE)
x_bar100 <- mean(runner_19$hr)
x_bar100
z <- (x_bar100-3.97)/(1/sqrt(100))
z

# conclusion
# -3.657 is in the rejection region, we reject the null hypothesis


# Calculate P-value
2*pnorm(z, 0, 1)
pnorm(z)
z
qnorm(0.0001275922, 0, 1)


(95-100)/(10/4)
2*pnorm(-2)
2/(8.5/6)
1-pnorm(1.411765)



# two samples tests
ChickWeight
day_0_weight <- ChickWeight[ChickWeight$Time==0, ]$weight
day_2_weight <- ChickWeight[ChickWeight$Time==2, ]$weight
t.test(day_0_weight, day_2_weight)

length(day_0_weight)

t.test(day_0_weight)



# Class Exercise Q7 
df_EuStockMarket <- as.data.frame(EuStockMarkets)
dax_30 <- df_EuStockMarket[1:30, "DAX"]
t.test(dax_30, mu = 1620)

dax_1 <- df_EuStockMarket[1:30, "DAX"]
dax_2 <- df_EuStockMarket[31:60, "DAX"]
t.test(dax_1, dax_2)
