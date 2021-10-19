# Week 6: bootstrap method

# Example 1: birth weight

W6=read.delim("clipboard")

W6 <- read.csv(file.choose())

B=10000 # We draw 10k samples from the bootstrap population
x_bar=numeric(B) 
length(x_bar)



for(i in 1:B) {
  #calculate the sample mean and store the result in x_bar
  x_bar[i]=mean(sample(W6$Weight,1009,replace=TRUE)) 
}
x_bar

# bootstrap percentile interval and other statistics
hist(x_bar)
sd(x_bar)
moments::skewness(x_bar)
quantile(x_bar, c(0.025, 0.975))  


##################################
# Example 2: skateboarding
#W6.Skate=read.csv(file.choose())
W6.Skate <- read.csv(file.choose())

male_n=length(W6.Skate$Testosterone[W6.Skate$Experimenter=="Male"])
female_n=length(W6.Skate$Testosterone[W6.Skate$Experimenter=="Female"])

male_n
female_n

# Extract male - female data
male_data=subset(W6.Skate, select=Testosterone,subset=Experimenter=="Male",drop=TRUE)
female_data=subset(W6.Skate, select=Testosterone,subset=Experimenter=="Female",drop=TRUE)


# the difference of sample means
mean(male_data)-mean(female_data)

male_n=length(male_data)
female_n=length(female_data)


B=10000 # We draw 10k samples from the bootstrap population
x_bar_d=numeric(B) 

# 남자 중에서 뽑고, 여자 중에서 뽑고 평균을 뺀다. 
for(i in 1:B) {
  #calculate the sample mean and store the result in x_bar
  male=mean(sample(male_data,male_n,replace=TRUE))
  female=mean(sample(female_data,female_n,replace=TRUE)) 
  x_bar_d[i]=male-female
}

hist(x_bar_d)
sd(x_bar_d)
moments::skewness(x_bar_d)
mean(x_bar_d)-(mean(male_data)-mean(female_data))
quantile(x_bar_d, c(0.025, 0.975))


# Evaluate bias of the sample median  
# 남녀 데이터 싹다 한줄로
all_data=c(male_data,female_data)
all_data
all_length=length(all_data)
all_length
B=10000
x_median=numeric(B) 
for(i in 1:B) {
  x_median[i]=median(sample(all_data,all_length,replace=TRUE))
}
# median 10000개 뽑아서 평균 - 진짜 median
bias=mean(x_median)-median(all_data)
bias
hist(x_median)
abline(v=median(all_data), col = "red", lty = 2)
abline(v=mean(x_median), col = "blue", lty = 3)
text(x=12, y=3000, labels="avg. boostrap median",col = "blue")
text(x=5, y=2500, labels="sample median",col = "red")







#Q1
W6.stock=read.delim("clipboard")
W6.stock=read.csv(file.choose())

B=10000
n=nrow(W6.stock)
corr=numeric(B) 

View(W6.stock)

S=W6.stock[sample(1:n,n,replace=TRUE),]
cor(S)[2, 1]

for(i in 1:B) {
  #calculate the sample mean and store the result in x_bar
  S=W6.stock
  S=W6.stock[sample(1:n,n,replace=TRUE),]
  #for(j in 1:259) {
  # S[j,]=W6.stock[sample(1:n,1),]
  #}
  # Correlation of Walmart & Apple
  corr[i]=cor(S)[2,1]
}

quantile(corr, c(0.025, 0.975))  
bias= mean(corr)-cor(W6.stock)[2,1]


#Q2
#trimmed means

#W6=read.delim("clipboard")
W6 = read.csv(file.choose())

B=10000 # We draw 10k samples from the bootstrap population
x_bar_trim=numeric(B) 
x_bar_trim0=numeric(B) 

for(i in 1:B) {
  #calculate the sample mean and store the result in x_bar
  S=sample(W6$Weight,1009,replace=TRUE) 
  # 5% ~ 95%사이만 골라낸다. 
  x_bar_trim[i]=mean(S[S>quantile(S,0.05) & S<quantile(S,0.95)])
  #alternative
  # 양쪽 꼬리의 5%씩 짤라낸다
  x_bar_trim0[i]=mean(sample(W6$Weight,1009,replace=TRUE),.05) 
}
?mean

# bootstrap percentile interval
quantile(x_bar_trim0, c(0.025, 0.975))  
x_bar_trim_q=quantile(x_bar_trim, c(0.025, 0.975))  
x_bar_trim_q



#winsorized means

x_bar_win=numeric(B) 
for(i in 1:B) {
  S=sample(W6$Weight,1009,replace=TRUE) 
  # 5%보다 작은 애들은 싹다 0.05의 값로
  S[S<quantile(S,0.05) ]=quantile(S,0.05)
  # 95%보다 큰 애들은 싹다 0.95의 값으로
  S[S>quantile(S,0.95) ]=quantile(S,0.95)
  x_bar_win[i]=mean(S)
}

# bootstrap percentile interval
x_bar_win_q=quantile(x_bar_win, c(0.025, 0.975))  


#sample mean

x_bar =numeric(B) 
for(i in 1:B) {
  S=sample(W6$Weight,1009,replace=TRUE) 
  x_bar[i]=mean(S)
}

# bootstrap percentile interval
x_bar_q=quantile(x_bar, c(0.025, 0.975))  


x_bar_win_q
x_bar_trim_q
x_bar_q




