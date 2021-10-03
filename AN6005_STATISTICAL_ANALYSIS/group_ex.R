
library(ggplot2)
library(dplyr)
library(moments)

# 1)
# 1-1 Plot histograms for x and y
X <- data.frame(data = W4_Q1$x)
Y <- data.frame(data = W4_Q1$y)

X$var <- 'x'
Y$var <- 'y'
combined <- rbind(X, Y)
ggplot(combined, aes(data, fill = var)) + 
  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity')

# 1-2 mean, std dev, skwness
mean(W4_Q1$x)
mean(W4_Q1$y)

sd(W4_Q1$x)
sd(W4_Q1$y)

skewness(W4_Q1$x)
skewness(W4_Q1$y)

# 2) Plot the histograms for x and y in W4_Q2. Which distribution do you think looks peakier?
X <- data.frame(data = W4_Q2$x)
Y <- data.frame(data = W4_Q2$y)

X$var <- 'x'
Y$var <- 'y'
combined <- rbind(X, Y)
ggplot(combined, aes(data, fill = var)) + 
  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity')

# 3)
# Y in W4_Q2 has smaller kurtosis, meaning that it is peakier than Y. 
kurtosis(W4_Q2$x)
kurtosis(W4_Q2$y)


# 4) 
# X 
X <- data.frame(data = W4_Q2$x)
a <- X %>% filter(data <= 1 & data >= -1)
b <- X %>% filter(data > 1 | data < -1)

# Kurtosis Of X
kur_X <- kurtosis(X)
# (a) of X
x_kur_a <- kurtosis(a)
# (b) of X
x_kur_b <- kurtosis(b)

# (a) / Kurtosis
x_kur_a / kur_X
# (b) / Kurtosis
x_kur_b / kur_X


# Y
Y <- data.frame(data = W4_Q2$y)
a <- Y %>% filter(data <= 1 & data >= -1)
b <- Y %>% filter(data > 1 | data < -1)


# Kurtosis Of Y
kur_Y <- kurtosis(Y)

# (a) of Y
y_kur_a <- kurtosis(a)
# (b) of Y
y_kur_b <- kurtosis(b)


# (a) / Kurtosis
y_kur_a / kur_Y
# (b) / Kurtosis
y_kur_b / kur_Y
