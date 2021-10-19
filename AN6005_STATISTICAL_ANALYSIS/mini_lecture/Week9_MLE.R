install.packages("DEoptim")
library(DEoptim)
# chooose n
choose()
?rbinom()


# define the likelihood function
L=function(p){-p^8*(1-p)^2}
# or, equivalently, 
L=function(p){-dbinom(8,10,p)}
# find the MLE using the Deoptim solver
DEoptim::DEoptim(L, lower = 0,upper = 1,control = DEoptim.control(trace = FALSE))$optim




set.seed(520)
x=rbinom(3,10,0.8)
L=function(p){-dbinom(9, 10, p)*dbinom(8, 10,  p)*dbinom(10, 10, p)}
DEoptim::DEoptim(L, lower = 0,upper = 1,control = DEoptim.control(trace = FALSE))$optim



x = read.delim("clipboard")
x=read.csv(file.choose())
LL = function(lambda){ -sum(log(dpois(x$vehicles, lambda)))}
DEoptim::DEoptim(LL, lower = 0,upper = 1,control = DEoptim.control(trace = FALSE))$optim



Y <- ChickWeight$weight
X <- ChickWeight$Time
?dnorm

LL= function(parameters){
  -sum(log(dnorm(Y, parameters[1]+parameters[2]*X, parameters[3])))
}
DEoptim::DEoptim(LL, lower = c(-10^5, -10^5,0), upper=c(10^5, 10^5,  10^5),control = DEoptim.control(trace = FALSE))$optim



library(DEoptim)
df <- read.csv(file.choose())
df


# Group Assignment
df <- read.csv(file.choose())
X = as.numeric(unlist(df["Age"]))
Y = as.numeric(unlist(df["ICU"]))

LL= function(parameters){
  -sum(log(pnorm(parameters[1]+parameters[2]*X)^Y*(1-pnorm(parameters[1]+parameters[2]*X))^(1-Y)))
}

DEoptim::DEoptim(LL, lower = c(-200, -200), upper=c(200, 200),control = DEoptim.control(trace = FALSE, itermax=5000))$optim









