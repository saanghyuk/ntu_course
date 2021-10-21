sample1=read.csv(file.choose()) 
reg_age=lm(OfficialTime_min~AgeOnRaceDay,data=sample1)
plot(sample1$AgeOnRaceDay,sample1$OfficialTime_min,main="Age and finish time of 100 runners")
abline(reg_age)

MSE=mean(reg_age$residuals^2)
MSE


for(j in 1:1000){
  x=runif(50,-6,6)
  y=(x+3)*(x-2)^2*(x-5)/30 + rnorm(50,0,20)
  reg=lm(y~poly(x,degree=1,raw=T))
  
  pred = predict(reg)
  ix = sort(x, index.return=T)$ix
  
  plot(x,y,ylim=c(-30,30),xlim=c(-10,10),col="red" )
  lines(x[ix], pred[ix], lwd=2)
  
  title(main="Linear")  
  Sys.sleep(0.3)
}
for(j in 1:1000){
  x=runif(50,-6,6)
  y=(x+3)*(x-2)^2*(x-5)/30 + rnorm(50,0,20)
  reg=lm(y~poly(x,degree=6,raw=T))
  
  pred = predict(reg)
  ix = sort(x, index.return=T)$ix
  
  plot(x,y,ylim=c(-30,30),xlim=c(-10,10),col="red" )
  lines(x[ix], pred[ix], lwd=2)
  
  title(main="6-th degree polynominal")
  
  Sys.sleep(.5)
}


# Regularization
# load data: 
install.packages("glmnet")
library(glmnet)
#"d:/week10.Runners100.csv"
sample1=read.csv(file.choose())
y=sample1[,"OfficialTime_min"  ]
x=sample1[,c("AgeOnRaceDay","Gender","Age2","Age3")]
# cv.glmnet can fit ridge and LASSO rsegression, by selection the “alpha” value
lasso=cv.glmnet(as.matrix(x),y,alpha=1)
ridge=cv.glmnet(as.matrix(x),y,alpha=0)
# Extract the coefficients from lasso$glmnet.fit$beta, based on the lambda value that gives the lowest MSE in the cv test (==lasso$lambda.min)
lasso$glmnet.fit$beta[,lasso$glmnet.fit$lambda==lasso$lambda.min]
ridge$glmnet.fit$beta[,ridge$glmnet.fit$lambda==ridge$lambda.min] 


# Dummies
install.packages("fastDummies")
library(fastDummies)

crime <- data.frame(city = c("SF", "SF", "NYC","LA"),
                    big=c("B","B","S","B"),
                    year = c(1990, 2000, 1990,100),
                    crime = 1:4)
crime
# Create dummy variables based on “crime”
dummy_cols(crime)
# Remove the first dummy variable  
dummy_cols(crime, remove_first_dummy = TRUE)
library(fastDummies)
x=dummy_cols(sample1[,c("AgeOnRaceDay","Gender","Age2",
                        "Age3","CountryOfCtzAbbrev")],remove_first_dummy = TRUE)
x=subset(x,select = -c(CountryOfCtzAbbrev))
x
lasso=cv.glmnet(as.matrix(x),y,alpha=1)
lasso$glmnet.fit$beta[,lasso$glmnet.fit$lambda==lasso$lambda.min]




