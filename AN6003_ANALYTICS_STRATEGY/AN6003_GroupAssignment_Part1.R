library(data.table)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)

# 1.Read and explore data
dt = fread(file.choose(), stringsAsFactors = T, na.strings = c('','NA'))
dim(dt)
colnames(dt)
summary(dt)
glimpse(dt)

# 2.Process data
# (1).Dealing with missing values
sum(is.na(dt))
na_table = apply(dt,2,function(x) sum(is.na(x)))
dt = na.omit(dt)

# (2).Deal with outliers
boxplot(dt$Quantity) # identify the outliers
dt = dt %>% 
  filter(Quantity>0)%>%
  filter(Unit_Price>0)# delete orders whose quantity less than 0

# (3).Adjust columns names and add new columns
colnames(dt)
colnames(dt) = c('Invoice_No','Product_Code','Product_Name','Quantity','Invoice_Date','Unit_Price','Customer_ID','Country')
dt$Invoice_No = as.character(dt$Invoice_No)
dt$Invoice_Date = as_datetime(dt$Invoice_Date) # Change to datetime class
dt = dt%>%
  mutate(Total_price = Unit_Price*Quantity)%>%
  mutate(Time_Interval = ymd('2011-12-11')-as.Date(dt$Invoice_Date))
  # Add Total_price and Time_Interval columns

summary(dt)
glimpse(dt)


# 3.General Visualization

# (1).Which product sale the best?
dt1 = copy(dt)
dt1$Product_Code
dt1$Product_Code = as.character(dt1$Product_Code) # Prepare for the substring function

RemoveLetter = function(x){
  a = substring(x,1,5)
  return(a)
}

dt1$Product_Code = lapply(dt1$Product_Code,RemoveStr) # Combine Products which have different colors
dt1$Product_Code = as.factor(as.character(dt1$Product_Code))
Product_table = dt1[,.( Order_Amount = length(unique(Invoice_No)), Product_Sales = sum(Total_price)), keyby = Product_Name]%>% arrange(desc(Product_Sales))



length(unique(dt1$Product_Name))


Product_10 = Product_table[1:11,][-5,] # Remove manual and postage

# Order By Product Sales
ggplot(data = Product_10, aes(x = reorder(Product_Name, -Product_Sales), y = Product_Sales, fill=Product_Name),options(scipen=200))+
  geom_bar(stat = 'identity')+
  theme(axis.text.x = element_text(angle = 30, hjust = 0.5,vjust = 0.5,color = "black",size=8))+ xlab("Top Products") + ylab("Product Sales") 

# Order By Order Amount
Product_Order_10 = Product_table %>% 
  as.data.frame() %>% 
  arrange(desc(Order_Amount)) %>% 
  top_n(10)


ggplot(data = Product_Order_10, aes(x=reorder(Product_Name, -Order_Amount), y = Order_Amount, fill=Product_Name),options(scipen=200))+
  geom_bar(stat = 'identity')+
  theme(axis.text.x = element_text(angle = 30, hjust = 0.5,vjust = 0.5,color = "black",size=8)) + xlab("Top Products") + ylab("Order Amount")





# (2).Which year/month/time sales the best?
dt2 = copy(dt)

dt2$Year = format(dt$Invoice_Date,'%Y')
dt2$Month_Year = format(dt$Invoice_Date,"%Y-%m")
dt2$Hour = format(dt$Invoice_Date,'%H')

year_table = dt2[,.(Order_Amount = length(unique(Invoice_No)), Sales = sum(Total_price)),keyby = Year ]
month_table = dt2[,.(Order_Amount = length(unique(Invoice_No)), Sales = sum(Total_price)),keyby = Month_Year ]
hour_table = dt2[,.(Order_Amount = length(unique(Invoice_No)), Sales = sum(Total_price)),keyby = Hour ]

dt2

ggplot(data = year_table,aes(x = Year, y = Sales))+
  geom_bar(stat="identity",aes(fill = Order_Amount),width = 0.6)
# not very convincing, since the data ended at 2011-12-09

ggplot(data = month_table,aes(x = Month_Year, y = Sales))+
  geom_bar(stat="identity",aes(fill = Order_Amount))+
  theme(axis.text.x = element_text(angle = 70, hjust = 0.5,vjust = 0.5,color = "black",size=9))
# The plot shows seasonality, retailer sales the most in October

ggplot(data = hour_table,aes(x = Hour, y = Sales))+
  geom_bar(stat="identity",aes(fill = Order_Amount))
# Cunsumers tend to buy things at 12pm
hour_table

colnames(dt2)
dt2 = dt2 %>% filter(Total_price >= 0)
dt2_invoice = dt2 %>% 
  group_by(Invoice_No) %>% 
  summarise(Total_price = sum(Total_price), Year, Month_Year, Hour) %>% 
  filter(! duplicated(Invoice_No))
dt2_invoice
sum(dt2[dt2$Invoice_No  == 489434]$Total_price)

mean_of_year = dt2_invoice %>% 
  group_by(Year) %>% 
  summarise(mean=mean(Total_price))


# Yearly Top100 Order Mean
top_order_yearly = dt2_invoice %>%
  arrange(desc(Total_price)) %>% 
  group_by(Year) %>%
  slice(1:100)

View(top_order_yearly)
yearly_mean_table = top_order_yearly %>% 
  group_by(Year) %>% 
  summarise(mean(Total_price))

yearly_mean_table$yearly_mean = mean_of_year$mean
temp_1 = copy(as.data.frame(yearly_mean_table))
temp_1
temp_2 = temp_1 %>% select(Year, yearly_mean)

temp_3 = data.frame(c(temp_1$Year , temp_2$Year), c(temp_1$`mean(Total_price)`, temp_2$yearly_mean))
colnames(temp_3) = colnames(yearly_mean_table)[0: 2]
yearly_mean_table = cbind(temp_3, type=c("top100", "top100", "top100", "Total", "Total", "Total"))
yearly_mean_table$`mean(Total_price)` = round(yearly_mean_table$`mean(Total_price)`)

ggplot(yearly_mean_table,
       aes(x = Year,
           y = `mean(Total_price)`, fill=type)) +
  geom_bar(stat = "identity",
           position = "dodge")+
  ylab("Mean of Top 100 Orders by Year")+
  geom_text(aes(Year, `mean(Total_price)`, label = sprintf("%2.1f", `mean(Total_price)`)), position = position_dodge(width = 1)) 





# Montly Top100 Order Mean
top_order_montly = dt2_invoice %>%
  arrange(desc(Total_price)) %>% 
  group_by(Month_Year) %>%
  slice(1:100)

monthly_total_mean_table = dt2_invoice %>% 
  group_by(Month_Year) %>% 
  summarise(mean = mean(Total_price))

View(top_order_montly)

monthly_mean_table = top_order_montly %>% 
  group_by(Month_Year) %>% 
  summarise(mean(Total_price))


ggplot(monthly_mean_table,
       aes(x = Month_Year,
           y = `mean(Total_price)`, fill=`mean(Total_price)`)) +
  geom_bar(stat = "identity",
           position = "dodge") + 
  theme(axis.text.x=element_text(angle=45, hjust=1)) + 
  ylab("Mean of Top 10 Orders by Year and Month")+
  ylim(0, 4000)

ggplot(monthly_total_mean_table,
       aes(x = Month_Year,
           y = mean, fill=mean)) +
  geom_bar(stat = "identity",
           position = "dodge") + 
  theme(axis.text.x=element_text(angle=45, hjust=1)) + 
  ylab("Mean Orders by Year and Month") + 
  ylim(0, 4000)






# Hourly Top100 Order Mean
top_order_hourly = dt2_invoice %>%
  arrange(desc(Total_price)) %>% 
  group_by(Year, Hour) %>%
  slice(1:100)

mean_order_hourly = dt2_invoice %>%
  group_by(Year, Hour) %>%
  summarise(mean=mean(Total_price))

dt2_invoice


colnames(top_order_hourly)
View(top_order_hourly)

hourly_mean_table = top_order_hourly %>% 
  group_by(Year, Hour) %>% 
  summarise(mean(Total_price))

View(hourly_mean_table)

ggplot(hourly_mean_table,
       aes(x = Hour,
           y = `mean(Total_price)`, fill=Year)) +
  geom_bar(stat = "identity",
           position = "dodge") + ylab("Mean of Top 100 Orders by Year and Hour")

ggplot(mean_order_hourly,
       aes(x = Hour,
           y = mean, fill=Year)) +
  geom_bar(stat = "identity",
           position = "dodge") + ylab("Mean of Total Orders by Year and Hour")




# (3).Which country sales the best?
dt3 = copy(dt)
country_table = dt3[,.(Order_Amount = length(unique(Invoice_No)),
                       Sales = sum(Total_price), 
                       Cunsumer_No = length(unique(Customer_ID)),
                       Consumption_per_person = sum(Total_price)/length(unique(Customer_ID)),
                       Order_per_person = length(unique(Invoice_No))/length(unique(Customer_ID))), 
                    keyby = Country]%>% arrange(desc(Sales))

country_sale_table = country_table[1:10,]
country_sale_table

ggplot(data = country_sale_table,aes(x = Country, y = Sales))+
  geom_bar(stat="identity",aes(fill = Order_Amount))+
  theme(axis.text.x = element_text(angle = 70, hjust = 0.5,vjust = 0.5,color = "black",size=9))
# The UK has much bigger transaction volumns than any other countries

country_cpp_table = country_table %>%arrange(desc(Consumption_per_person))
country_cpp_table = country_cpp_table[1:10,]
ggplot(data = country_cpp_table,aes(x = Consumption_per_person, y = reorder(Country,-Consumption_per_person)))+
  geom_bar(stat="identity",fill = 'blue4')+
  xlab('Sales per Person')+
  ylab('Country')

ggplot(data = country_sale_table,aes(x = Order_per_person, y = reorder(Country,-Order_per_person)))+
  geom_bar(stat="identity",fill = 'blue4')+
  xlab('Orders per Person')+
  ylab('Country')
# The EIRE has the biggest comsumption volumns per person

# 4. Create and explore RFM_table
RFM_table = dt[,.(Frequency = length(unique(Invoice_No)),Monetary = sum(Total_price),Recency = min(Time_Interval)),keyby = Customer_ID]
RFM_table$Recency = as.numeric(as.character(RFM_table$Recency))
summary(RFM_table)

ggplot(data = RFM_table, aes(x = Recency, y = Frequency, color = Monetary))+
  geom_point(stat = 'identity')+
  labs(title = 'Scatter point for Recency and Frequecy')+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_gradient(low = "green", high = "red")

ggplot(data = RFM_table, aes(x = Frequency, y = Monetary))+
  geom_point(stat = 'identity')+
  labs(title = 'Scatter point for Frequecy and Monetory')+
  theme(plot.title = element_text(hjust = 0.5))+
  geom_smooth(method='lm',se=FALSE,show.legend=TRUE,
              linetype=1,color='brown',size = 1)

cor(RFM_table[,-'Customer_ID'])
RFM_table

# 5. Model suggestions
# (1).Clustering model based on RFM_table (such as hierarchical clustering and K-means clustering, new business for EIU)
# (2).Time series model (Comparing with EIU's old linear model)

                         