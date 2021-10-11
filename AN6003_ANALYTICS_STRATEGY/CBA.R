
df = read.csv(file.choose())


nrow(df)

# Q1
df$BMI = df$Weight/((df$Height)/100)^2
str(df)
head(df)
plot(df$BMI ~ df$Age)
cov(df)
plot(df)

library(ggplot2)
library(dplyr)


cor(df, method="pearson")
install.packages("corrgram")
library(corrgram)
corrgram(df, upper.panel = panel.conf)

cor(df, method="spearman")
corrgram(df, cor.method = "spearman")

ggplot(data=df, aes(x=Allergy, y=BMI, group=Allergy)) + geom_boxplot()
df_allergy <- df %>%
  group_by(Allergy) %>% 
  summarise(mean_bmi = mean(BMI))
df_allergy
ggplot(data=df_allergy, aes(x=reorder(Allergy, -mean_bmi), y=mean_bmi)) + 
  geom_col() 

ggplot(data=df, aes(x=Diabetes, y=BMI, group=Diabetes)) + geom_boxplot()
ggplot(data=df, aes(x=HighBloodPressure, y=BMI, group=HighBloodPressure)) + geom_boxplot()
ggplot(data=df, aes(x=Transplant, y=BMI, group=Transplant)) + geom_boxplot()
ggplot(data=df, aes(x=ChronicDisease, y=BMI, group=ChronicDisease)) + geom_boxplot()
ggplot(data=df, aes(x=CancerInFamily, y=BMI, group=CancerInFamily)) + geom_boxplot()
ggplot(data=df, aes(x=NumMajorSurgeries, y=BMI, group=NumMajorSurgeries)) + geom_boxplot()
ggplot(data=df, aes(x=Smoker, y=BMI, group=Smoker)) + geom_boxplot()

ggplot(data=df, aes(x=BMI, y=Age)) + 
  geom_point() 
ggplot(data=df, aes(x=BMI, y=Premium)) + 
  geom_point() 
cor(df$BMI, df$Premium)


# BMI변수의 히스토그램 & Kernel Density 
hist(df$BMI)
BMI_density <-  density(df$BMI)
plot(BMI_density)


library(moments)
skewness(df$BMI)



# But, BMI를 통해 키나 몸무게의 feature를 줄이는 것을 고려해 볼 수 있다. 
df_BWH = df %>% select(BMI, Weight, Height)
cor(df_BWH)


# Q2
# Random Forest
library(randomForest)

str(df)

RF <- randomForest(Premium ~ . , data = df, 
                        mtry=4,
                       na.action = na.omit, 
                       importance = T)
RF
var.impt <- importance(RF)
varImpPlot(RF, type = 1)
mean((df$Premium - predict(RF, df))^2)
mean((df$Premium - predict(RF, df))^2)
residuals_rf = df$Premium - predict(RF, df)
plot(residuals_rf)








# Linear Regression
library(caret)
library(fastDummies)
str(df)
Y = df %>% select(Premium)
X_continuous = df %>% select(Age, Height, Weight, BMI)
colnames(df)
X_cat  = df %>% select(-Premium, -Age, -Height, -Weight, -Premium, -BMI)

str(X_cat)
dummy = dummy_cols(X_cat, select_columns = c('Diabetes', 'HighBloodPressure', 'Transplant', 'ChronicDisease', 'Allergy', 'CancerInFamily', 'NumMajorSurgeries', 'Smoker'))
X_cat = dummy[, -c(1, 2, 3, 4, 5, 6, 7, 8)]

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
str(X_continuous)
X_continuous$Age = normalize(X_continuous$Age)
X_continuous$Height = normalize(X_continuous$Height)
X_continuous$Weight = normalize(X_continuous$Weight)
X_continuous$BMI = normalize(X_continuous$BMI)


df_processed = cbind(X_continuous, X_cat, Y)

install.packages("car")
library(car)
model = lm(Premium ~ ., data = df)
summary(model)
vif(model)
plot(model, 1)
# MSE
mean((df$Premium - predict(model, df))^2)
residuals_lm = df$Premium - predict(model, df)
plot(residuals_lm)






# vif 10이 넘는 Weight, Height, BMI 삭제
df_2 = df_processed %>% select(-BMI, -Height, -Weight)
str(df_2)
model = lm(Premium ~ ., data = df_2)
summary(model)

# 유의한것만 남기기
str(df_2)
df_3 = df_2 %>% select(Age, Transplant, ChronicDisease, CancerInFamily, NumMajorSurgeries, Premium)

model = lm(Premium ~ Age + Transplant_0 + Transplant_1 + ChronicDisease_0 + ChronicDisease_1 + CancerInFamily_0 + CancerInFamily_1 + NumMajorSurgeries_0 + NumMajorSurgeries_1 + NumMajorSurgeries_2 + NumMajorSurgeries_3, data = df_processed)
summary(model)



# Age$Transplant만 써보기
model = lm(Premium ~ Age + Transplant, data = df_3)
summary(model)





pred <- predict(RF, df)
df_1 = data.frame(value = df$Premium, type = "Label")
df_2 = data.frame(value = predict(RF, df), type = "Prediction")

df_c = rbind(df_1, df_2)
head(df_c)
difference = df_c$value[df_c$type =="Label"]  - df_c$value[df_c$type=="Prediction"]
difference_square = difference^2



df_c[value, df_c$type=="Prediction"]
DataA$Difference_square <- (DataA$x- DataA$y)^2
DataA

hist(df$Premium)
premium_density <-  density(df$Premium)
plot(premium_density)
