# set to default
RNGkind(sample.kind = "Rejection")

set.seed(3993)
randValues <- round(rnorm(1000, mean = 500, sd = 75))

# SAMPLE A
sampleA = sample(randValues, 15, replace=TRUE)
print("Mean of sampleA")
print(mean(sampleA)) # 530.2
print("Standard Deviation  of sampleA")
print(sd(sampleA)) # 66.07053

# SAMPLE B
sampleB = sample(randValues, 30, replace=TRUE)
print("Mean of sampleB")
print(mean(sampleB)) # 504.7333
print("Standard Deviation  of sampleB")
print(sd(sampleB)) # 65.76758

# SAMPLE C
sampleC = sample(randValues, 60, replace=TRUE)
print("Mean of sampleC")
print(mean(sampleC)) # 508.3
print("Standard Deviation  of sampleC")
print(sd(sampleC)) # 72.4745


# Q. Which sample gives the smallest sampled standard deviation?
# A. We can know that B samples gives the smallest standard deviation. 
std = c(sd(sampleA), sd(sampleB), sd(sampleC))
print(min(std))


