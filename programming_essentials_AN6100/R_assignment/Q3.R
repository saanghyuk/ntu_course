library(dplyr)

setwd("/Users/sanghyuk/Desktop/NTU_course/Pre_master/programming_essentials_ 610002/assignment/R_assignment")
data_3b <- read.csv('AN6100-Data-3B.csv')
highincome_group <- data_3b %>% filter(Income.Annual >= 80000, Weight >= 80)
highincome_group$MrMs <- ifelse(
    highincome_group$Gender == "M"
  ,
  "Mr",  # if condition is met, Male
  "Ms"   # else Female
)


highincome_group$Hello <- paste(highincome_group$MrMs, highincome_group$Lastname)
head(highincome_group)

highincome_csv <- highincome_group[, c('Hello', 'Income.Annual', 'Job.Title', 'Country')]
highincome_csv

# Export CSV as highincome.csv
write.csv(highincome_csv,"./highincome.csv", row.names = FALSE)


# Q How many different countries are found? 
# A There are five unique countries in this group. 
print(length(unique(highincome_csv$Country)))


# Q How many male and female are in “highincome.csv”?
# A Male: 5, Female 0 
head(highincome_csv)
num_of_male <- sum(str_count(highincome_csv$Hello, pattern = "Mr.*"))
num_of_female <- length(highincome_csv$Hello)  - num_of_male
print(num_of_male)
print(num_of_female)

