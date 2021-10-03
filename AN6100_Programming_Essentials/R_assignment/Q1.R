# set to default
RNGkind(sample.kind = "Rejection")

set.seed(3993)
randValues <- round(rnorm(1000, mean = 500, sd = 75))

# SAMPLE A
sampleA = sample(randValues, 15, replace=TRUE)
print(sampleA)
print("Mean of sampleA")
print(mean(sampleA))
print("Standard Deviation  of sampleA")
print(sd(sampleA))

# SAMPLE B
sampleB = sample(randValues, 30, replace=TRUE)
print("Mean of sampleB")
print(mean(sampleB))
print("Standard Deviation  of sampleB")
print(sd(sampleB))

# SAMPLE C
sampleC = sample(randValues, 60, replace=TRUE)
print("Mean of sampleC")
print(mean(sampleC))
print("Standard Deviation  of sampleC")
print(sd(sampleC))


# Q. Which sample gives the smallest sampled standard deviation?
# A. We can know that B samples gives the smallest standard deviation. 
std = c(sd(sampleA), sd(sampleB), sd(sampleC))
print(min(std))


