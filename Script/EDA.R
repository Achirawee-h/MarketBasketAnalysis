library(tidyverse)
library(ggplot2)
library(readxl)
library(writexl)

df <- read_excel("Output/Data/Cleaned Online Retail.xlsx")

head(df)
summary(df)

n_distinct(df$Country) #There are 37 different countries
n_distinct(df$CustomerID) #There are 4337 customers among 37 different countries

# Plot between Quantity and UnitPrice
ggplot(df, aes(x=Quantity, y=UnitPrice)) + geom_point() + scale_x_log10() + scale_y_log10()

# Top 10 Sales by Country
df <- df %>% mutate(Total = Quantity*UnitPrice)
df_country <- df %>% group_by(Country) %>% summarize(Revenue = sum(Total)) %>% arrange(desc(Revenue)) %>% slice(1:10)

# Revenue by Month
df_rev <- df %>% group_by(Month = month(InvoiceDate), Country) %>% summarize(Revenue = sum(Total))
ggplot(df_rev, aes(x=Month, y=Revenue, colour = Country)) + geom_line() + scale_x_continuous(breaks = seq(1, 12, 1)) + geom_point()

# Revenue by Country
df_share <- df %>% group_by(Country) %>% summarize(Revenue = sum(Total)) %>% arrange(desc(Revenue))
total_rev <- sum(df_share$Revenue)
df_share <- df_share %>% mutate(Percent = (Revenue/total_rev)*100) %>% slice(1:5)


