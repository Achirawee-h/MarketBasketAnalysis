# Cohort Analysis
# Reference https://towardsdatascience.com/cohort-analysis-in-r-the-easy-way-424f19a37d18/

install.packages("cohorts")
library(cohorts)

# Numeric
df_cohort <- df[,c("CustomerID", "InvoiceDate")] %>% cohort_table_month(id_var= CustomerID, date=InvoiceDate) %>% shift_left() 

# Percentage
df_cohort <- df[,c("CustomerID", "InvoiceDate")] %>% cohort_table_month(id_var= CustomerID, date=InvoiceDate) %>% shift_left_pct()

# Final Table
df_cohort_plot <- df_cohort %>% pivot_longer(-cohort) %>% mutate(time = as.numeric(str_remove(name,"t")))

# Plot Cohort
df_cohort_plot %>% filter(cohort <= 7, time == 0, value > 0) %>% ggplot(aes(time, value, colour = factor(cohort), group = cohort)) + geom_line(size= 1) + geom_point(size = 1) + theme_minimal()

# Plot New customer by Month
df_cohort_plot %>% filter(time == 0) %>% ggplot(aes(x=cohort, y=value)) + geom_line(size= 1) + geom_point(size = 1) + theme_minimal()