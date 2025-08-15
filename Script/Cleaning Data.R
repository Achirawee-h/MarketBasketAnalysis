install.packages("tidyverse")
library(tidyverse)

install.packages("ggplot2")
library(ggplot2)

install.packages("readxl")
library(readxl)

install.packages("writexl")
library(writexl)

dir.create("Data")
dir.create("Script")
dir.create("Output")

df <- read_excel("Data/Online Retail.xlsx")

head(df)

class(df)

summary(df)

df <- df %>% drop_na() %>% distinct() %>% mutate(Description = as.factor(Description), Country = as.factor(Country)) %>% mutate(Description = str_to_title(Description)) %>% mutate(InvoiceTime = format(InvoiceDate, "%H:%M:%S"), InvoiceDate = format(InvoiceDate, "%d-%m-%Y"))

df

write_xlsx(df,"Output/Data/Cleaned Online Retail.xlsx")


