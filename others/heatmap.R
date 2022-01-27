install.packages("flextable")
install.packages("systemfonts")
install.packages("magrittr")
install.packages("scales")
install.packages("rpivotTable")

library(systemfonts)
library(flextable)
library(magrittr)
library(data.table)
library(scales)

revenue_data <- fread(file.choose())
View(revenue_data)
revenue_cols <- colnames(revenue_data)[3:11]
revenue_melt <- melt(revenue_data, id.vars = c("vertical", "program"), measure.vars = revenue_cols)
revenue_melt[, 4] <- as.numeric(unlist(revenue_melt[, 4]))


revenue_dcast <- dcast(revenue_melt, vertical~program+variable, value.var="value", fun.aggregate = sum)
revenue_dcast
revenue_dcast[is.na(revenue_dcast)] = 0

View(revenue_data)
colnames(revenue_dcast)
typeof(revenue_dcast[14, 29])
length(colnames(revenue_dcast))

revenue_header <- data.frame(
  col_keys = colnames(revenue_dcast),
  line2 = c("Follow-up", rep("GBG In-Market", 9), rep("GBG Scaled Direct", 9), rep("SBG", 9), rep("GBG Unmanaged", 9)),
  line3 = c("Follow-up", rep(revenue_cols, 4))
)


ft <- flextable( revenue_dcast, col_keys = revenue_header$col_keys) %>%
  colformat_num(
    big.mark = ",", decimal.mark= ".",
    na_str="na") 
ft




colourer <- col_numeric(
  palette = c("wheat", "red"),
  domain = c(0, 50))


ft <- set_header_df(ft, mapping = revenue_header, key = "col_keys" ) %>% 
  merge_v(part = "header", j=1) %>% 
  merge_h(part = "header", i=1) %>% 
  theme_booktabs(bold_header = TRUE) %>% 
  align(align = "center", part = "all") %>%
  hline() %>%
  colformat_num(
    big.mark = "", decimal.mark= ".",
    na_str="na") %>%
  bg(
    bg = colourer,
    j = ~ . -vertical,
    part = "body") %>%
  vline() 

ft


