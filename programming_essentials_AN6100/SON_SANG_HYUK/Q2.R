# set to default
RNGkind(sample.kind = "Rejection")

set.seed(6226)
bigSmall <- function(){
  randB <- round(runif(5000, min=20, max=80))
  randB[randB >= 65] <- "BIG" 
  randB[randB < 65] <- "small"
  return(randB) 
}


int_from_uni <- bigSmall()
print()

# Q. How many "BIG" and "small" were generated?
# A. Big : 1332, small : 3668
table(int_from_uni)

# Q. empirically estimate the probability of getting a “small” integer
# A. 73.36% 

print((length(int_from_uni[int_from_uni=="small"])) / length(int_from_uni))

 