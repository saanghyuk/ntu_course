set.seed(123)

# Q1-Q3
# noise terms
e1=rnorm(500)
e2=rnorm(1000)
 
# Treatment effects
d1=rnorm(500,3,1)
d2=rnorm(1000,5,1)

# control
y0_c= 10 + e1
y1_c= 10+d1 + e1
delta_c=mean(y1_c-y0_c)

# treatment 
y0_d= 12 + e2
y1_d= 12+d2 + e2
delta_d=mean(y1_d-y0_d)

naive=  mean(y1_d)-mean(y0_c)

ATT = mean(y1_d - y0_d) 
ATC = mean(y1_c - y0_c)

ATE = 1000/(1000 + 500) * ATT+ 500/(1000 + 500) *ATC
# or equivalently
mean(c(y1_d-y0_d, y1_c - y0_c))

### Q4 ###
random_sample=sample(1:1500,500)
 
y0=c(y0_d, y0_c)
y1=c(y1_d,y1_c)

ATE_randomize=mean(y1[random_sample[1:250]]) - mean(y0[random_sample[251:500]])
ATE_randomize

# notice that ATE_randomize is a statistics: thus the function below is also random
# if enough samples are taken, the average of the bias will tend toward zero.
ATE_randomize-ATE


####Optional stuff####
data=data.frame(Y0=y0[random_sample[251:500]],Y1=y1[random_sample[1:250]])                               
t.test(data$Y0,data$Y1)
t.test(data$Y0,data$Y1)$stderr
t.test(data$Y0,data$Y1)$estimate

curve(dnorm(x,mean=t.test(data$Y0,data$Y1)$estimate[2]-t.test(data$Y0,data$Y1)$estimate[1],
            sd=t.test(data$Y0,data$Y1)$stderr)
      , col="red",  from=0, to=5,xlim=c(3,5),ylim=c(0,3 )
      ,xlab = "Mean difference (treatment - control)"
      ,ylab="")
#########
 
