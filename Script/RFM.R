library(tidyverse)
library(ggplot2)
library(readxl)
library(writexl)

df <- read_excel("Output/Data/Cleaned Online Retail.xlsx")
df <- df %>% mutate(Revenue = Quantity*UnitPrice) %>% drop_na(CustomerID) %>% rename(customer_id = CustomerID)

head(df)
summary(df)

class(max(df$InvoiceDate))

# Created RFM Table
# Reference https://rpubs.com/Eddie_Zaldivar/705462

install.packages("rfm")
library(rfm)

df$InvoiceDate <- as.Date(df$InvoiceDate)
analysis_date <- max(df$InvoiceDate) + 1

rfm_result <- rfm_table_order(
  data = df,
  customer_id = customer_id,
  revenue = Revenue,
  order_date = InvoiceDate, 
  analysis_date = analysis_date
)

# Heat map
rfm_plot_heatmap(rfm_result)

# Bar Chart
rfm_plot_bar_chart(rfm_result)

ggplot(rfm_result, aes(x = Frequency, y = Monetary)) +
  geom_point() +
  scale_color_gradient(low = "lightblue", high = "darkblue") +
  theme_minimal() +
  labs(title = "RFM Segmentation",
       x = "Frequency",
       y = "Monetary")
