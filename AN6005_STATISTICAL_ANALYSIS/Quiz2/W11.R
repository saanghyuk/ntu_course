library(moments)
library(wooldridge) 
df = wooldridge::kielmc 
colnames(df) 

# skewed right
skewness(df$price) 

library(wooldridge)
reg1<-lm(log(price)~log(dist),data=kielmc)
summary(reg1)


# Q4
library(wooldridge) 
df = wooldridge::apple 
colnames(df) 
sum(df$ecolbs==0) 
# skewed right
skewness(df$ecolbs) 


reg.results.woold <- lm(ecolbs ~ ecoprc +  regprc,data=df) 
summary(reg.results.woold) 


