# Linear Regression
install.packages("wooldridge") 
library(wooldridge) 
View(wage2) 
reg.results <- lm(wage ~ educ + exper + tenure, data = wage2) 
summary(reg.results) 



# Categorical  

library(wooldridge)
View(wage1)
View(wage1$female) 
reg.results.wage1 <- lm(wage ~ educ + exper + tenure + female, data = wage1) 
summary(reg.results.wage1) 


# Categorical 2
fake_data = read.csv(file.choose(), header=T) 
fake_data$year.factor = factor(fake_data$year) 
fake_data$year.factor 

reg_cat = lm(spending ~ female + year.factor, data=fake_data) 
summary(reg_cat) 



# Regression Example
library(wooldridge) 
ceosal1
colnames(ceosal1) 
df1 = data.frame(ceosal1) 
df1$indus = as.factor(df1$indus) 
ceosal1$indus
df1$indus
salary_reg = lm(salary ~ ., data=df1) 

summary(salary_reg) 