library(DEoptim)
df <- read.csv(file.choose())
df



df <- read.csv(file.choose())
X = as.numeric(unlist(df["Age"]))
Y = as.numeric(unlist(df["ICU"]))

LL= function(parameters){
  -sum(log(pnorm(parameters[1]+parameters[2]*X)^Y*(1-pnorm(parameters[1]+parameters[2]*X))^(1-Y)))
}

DEoptim::DEoptim(LL, lower = c(-200, -200), upper=c(200, 200),control = DEoptim.control(trace = FALSE, itermax=5000))$optim

?pnorm







