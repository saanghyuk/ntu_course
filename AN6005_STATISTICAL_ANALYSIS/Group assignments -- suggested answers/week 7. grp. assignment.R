

# sample mean convert in p to mean
e=0.1
n=1500
points=100
sample=matrix(0, ncol = n, nrow = 100)
for(i in 1:n){
  SM=numeric(points)
  for(j in 1:points){
    SM[j]=mean(rnorm(i))
  }
  sample[,i]=SM
}


plot(rep(1,length(sample[,1][abs(sample[,1])<e])),  sample[,1][abs(sample[,1])<e] ,xlim=c(0,n),
     ylim=c(min(sample),max(sample)),pch=19, ylab="Sample means",xlab="Sample size (n)")

points(rep(1,length(sample[,1][abs(sample[,1])>=e])), sample[,1][abs(sample[,1])>=e] ,col="red")

for(i in 2:n){
  points(rep(i,length(sample[,i][abs(sample[,i])<e])),sample[,i][abs(sample[,i])<e],pch=19)
  points(rep(i,length(sample[,i][abs(sample[,i])>=e])), sample[,i][abs(sample[,i])>=e] ,col="red")
}

