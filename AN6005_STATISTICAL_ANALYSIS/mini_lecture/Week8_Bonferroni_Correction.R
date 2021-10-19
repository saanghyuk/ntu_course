library(tidyr)
data_wide=read.csv(file.choose())
View(data_wide)
data_long =  gather(data_wide, product, result, P1:P7,
                    factor_key=TRUE)
data_long

ci=function(s1,s2,a){return(t.test(s1,s2,conf.level = a)$conf.int)}


# Benferroni 
W6 = read.csv(file.choose())
t.test(W6$roa[W6$ind=="finance"],W6$roa[W6$ind=="mfg"],conf.level=(1-.05/3))


# Applying Tuckey's Method
Model=aov(data_long$result~data_long$product)
summary(Model)

# Anova의 결과를 넣는다
TukeyHSD(Model)
T_result=TukeyHSD(Model)
plot(T_result, las=1 , col="red")
