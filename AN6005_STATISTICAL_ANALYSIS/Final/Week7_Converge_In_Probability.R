
# n을 1부터 200까지 순회하면서, 
# 각 샘플별로 표준정규분포에서 10000번식 n개를 추출. 
# 그리고, 그 n이 1부터 200까지 돌면서, 한번씩 그 10000개의 분포를 그리면서 넘어간다. 
for(n in 1:200){
  x_bar=numeric(10000)
  for(i in 1:10000){
    x_bar[i]=mean(rnorm(n))
  }
  hist(x_bar,xlim=c(-3,3),ylim=c(0,5),main=paste("n=",n),freq=FALSE)
  title(main="")
  Sys.sleep(0.05)  
}



e=0.01
n=500
prob=numeric(n) 
set.seed(123)

# 1부터 500까지 n을 loop돌린다. 
# 그 각각의 n에서 10000번을 루프 돌면서 n개를 추출한다. 
# 그리고, 그 그때 0.1로 설정된 epsilon보다 컸다면 error count에 +1 

# 지금 max라는 통계량이 1로 converge in probaility하는 과정
runif(1)
for(i in 1:n){
  err_count=0
  
  #  count the probability
  for(j in 1:10000){
    if(abs(max(runif(i))-1)>e){
      err_count=err_count+1
    }
  }
  prob[i]=err_count/10000
}
plot(prob,ylab="Pr(|Yn-1|>0.01)",xlab="n")

abs(max(runif(50)) - 1)


# 지금 max라는 통계량이 converge in probaility하는 과정
e=0.01
n=1000

prob=numeric(n) 
set.seed(111)

for(i in 1:n){
  err_count=0
  
  for(j in 1:10000){
    if(abs(rnorm(1))>e){
      err_count=err_count+1
    }    
  }
  prob[i]=err_count/10000
}
plot(prob,ylab="Pr(|X_1|>0.01)",xlab="n")


#
e=0.01
n=1000
prob=numeric(n) 
set.seed(111)

for(i in 1:n){
  err_count=0
  for(j in 1:10000){
    if(abs(rnorm(1))>e){
      err_count=err_count+1
    }    
  }
  prob[i]=err_count/10000
}
plot(prob,ylab="Pr(|X_1|>0.01)",xlab="n")



seq(2,40,2)
?rlnorm
# Generating sampling distribution of sample mean (100k obs per sample size)
for(sample.size in seq(2,40,2)){
  z=numeric(10000)
  for(i in 1:10000){
    x=rlnorm(sample.size) 
    z[i]=(mean(x)-exp(0.5))/sqrt((exp(1)-1)*exp(1))*sqrt(sample.size)    
  }
  # Plotting the empirical CDF and the normal CDF
  lnorm_cdf=ecdf(z)
  plot(lnorm_cdf, z,xlim=c(-5,5),ylim=c(0,1 ),xlab="Standarized sample means"
       ,main=paste("sample size=",sample.size),sub="CDF of the sample means")
  par(new=TRUE)
  title(main="")
  curve(pnorm(x), col="red",  from=-5, to=5,xlim=c(-5,5),ylim=c(0,1 ),
        ylab="cumulative probability",lwd = 2 ,add = TRUE)
  Sys.sleep(2)
}




# Group Assignment
# My Version
e=0.1
n=1500

sample_size=c()
sample_means=c()
out <- c()
set.seed(1)

for(i in 1:n){
  print(i)
  for(j in 1:100){
    sample_mean <- mean(rnorm(i))
    sample_means <- c(sample_means, sample_mean)
    sample_size <- c(sample_size, i)
    
    if(abs(sample_mean-0)>e){
      out <- c(out, 1)
    }else{
      out <- c(out, 0)
    }    
  }
}


library(ggplot2)
library(dplyr)

plot_df <- data.frame(sample_size, sample_means, out)
plot_df2 <-  plot_df %>% mutate(out = factor(ifelse(out == 1, "Out", "Not Out")))


colorPalette <- c("ff0000", "#000000")
plot_df2 %>%
  ggplot(aes(sample_size,sample_means, color=out)) +
  geom_point(alpha=0.5, size=2) +
  labs(y="Sample Means", x="Sample Size")+
  xlim(-1, 1500)+
  ylim(-3.5, 3.5)




# Prof Version
# sample mean convert in p to mean
e=0.1
n=1500
points=100
sample=matrix(0, ncol = n, nrow = 100)
sample
for(i in 1:n){
  SM=numeric(points)
  for(j in 1:points){
    SM[j]=mean(rnorm(i))
  }
  sample[,i]=SM
}

sample

plot(rep(1,length(sample[,1][abs(sample[,1])<e])),  sample[,1][abs(sample[,1])<e] ,xlim=c(0,n),
     ylim=c(min(sample),max(sample)),pch=19, ylab="Sample means",xlab="Sample size (n)")

points(rep(1,length(sample[,1][abs(sample[,1])>=e])), sample[,1][abs(sample[,1])>=e] ,col="red")

for(i in 2:n){
  points(rep(i,length(sample[,i][abs(sample[,i])<e])),sample[,i][abs(sample[,i])<e],pch=19)
  points(rep(i,length(sample[,i][abs(sample[,i])>=e])), sample[,i][abs(sample[,i])>=e] ,col="red")
}




