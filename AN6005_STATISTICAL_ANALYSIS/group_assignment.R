

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

