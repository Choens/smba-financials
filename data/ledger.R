## #############################################################################
## LEDGER
##
## Imports SMBA checking account data and creates a table 'ledger'.
## This table is in 'data/ledger.rda'.
##
## #############################################################################


## INIT ------------------------------------------------------------------------
message(' ')
message('Ledger ', rep('=', 40))
library(dplyr)
library(lubridate)
library(readr)


## VARS ------------------------------------------------------------------------

## Controls all references to the export file name.
file_name <- "data/ledger.RData"
if (file.exists(file_name)) unlink(file_name)

## List of source files used to create ledger.
name <- dir('data', pattern = '.csv', full.name = TRUE)
cal_year <- as.numeric(substr(x = name, 11, 14))
files <- tibble(name, cal_year)
rm(list = c('name', 'cal_year'))


## DATA ------------------------------------------------------------------------
message('Importing SMBA Ledger Files: ')
ledger <- tibble(NA)
for (i in seq_along(files$name)) {
    message('Import: ', files$name[i])
    ledger <- bind_rows(ledger, read_csv(file = files$name[i]))
}


## EDIT ------------------------------------------------------------------------
names(ledger) <- gsub( " ", "_", tolower(names(ledger)) )
ledger$transaction_date <- as.Date(ledger$transaction_date,
                                     format = "%m/%d/%Y")
ledger <- bind_cols(row_num = 1:nrow(ledger), ledger)
ledger <-
    ledger %>%
    mutate(year      = year(transaction_date),
           month     = month(transaction_date),
           month_lab = as.character(month(transaction_date, label=TRUE, abbr = FALSE)))


## SAVE ------------------------------------------------------------------------
save(ledger, file = file_name)
if (file.exists(file_name)) {
    message('Complete: ', file_name)
} else {
    stop('Unable to locate: ', file_name)
}
