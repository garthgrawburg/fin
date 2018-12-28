suppressMessages(library(tidyverse))
library(janitor)
library(here)

options(stringsAsFactors = F)
options(scipen = 99)


imprt <- read_csv(file = "2018_mint_transactions.csv",                          
         col_types = cols(
                            Date = col_character(),
                            Description = col_character(),
                            `Original Description` = col_character(),
                            Amount = col_double(),
                            `Transaction Type` = col_character(),
                            Category = col_character(),
                            `Account Name` = col_character())
         ) %>% 
  clean_names() %>% 
  mutate(date = as.POSIXct(if_else(substr(date,2,2) == "/", str_c("0", date), date), format = "%m/%d/%Y"),
         amount = if_else(transaction_type == "debit", amount * -1, amount)) %>% 
  filter(!(category %in% c('Transfer','Hide from Budgets & Trends')))
