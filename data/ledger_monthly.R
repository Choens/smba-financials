## #############################################################################
## ledger_monthly
##
##
## #############################################################################

## INIT ------------------------------------------------------------------------
message(' ')
message('Ledger Monthly', rep('=', 40))
library(dplyr)
library(lubridate)

file_name <- 'data/ledger_monthly.RData'
if (file.exists(file_name)) unlink(file_name)

## DATA ------------------------------------------------------------------------
load('data/cal_months.RData')
load('data/ledger.RData')

## Creates ledger_monthly, which contains monthly stats on SMBA's finances for
## that month such as min/max balance, etc.
## This is step 1 of 3.
ledger_monthly <-
    cal_months %>%
    left_join(ledger, by = c('year', 'month', 'month_lab')) %>%
    group_by(year, month, month_lab) %>%
    summarize(first_row = min(row_num),
              last_row = max(row_num),
              first_transaction = min(transaction_date),
              last_transaction = max(transaction_date),
              n_transactions = n(),
              max_balance = max(running_balance),
              min_balance = min(running_balance),
              avg_balance = mean(running_balance),
              tot_deposits = sum(ifelse(amount > 0, amount, 0)),
              tot_expenses = abs(sum(ifelse(amount < 0, amount, 0)))
              )

## Adds the balance as of the end of the month.
## This is step 2 of 3
ledger_monthly <-
    ledger_monthly %>%
    left_join(ledger, by = c('year' = 'year',
                            'month' = 'month',
                            'month_lab' = 'month_lab',
                            'last_transaction' = 'transaction_date',
                            'last_row' = 'row_num')) %>%
    select(year,
           month,
           month_lab,
           last_row,
           last_transaction,
           n_transactions,
           last_balance = running_balance,
           max_balance,
           min_balance,
           avg_balance,
           tot_deposits,
           tot_expenses)

## Cleans up ledger_monthly, replacing some of the NULLS (months where we have no expenses)
## Step 3 of 3
ledger_monthly <- bind_cols(row_num = 1:nrow(ledger_monthly), ledger_monthly)
missing_values <- length(ledger_monthly$row_num[is.na(ledger_monthly$last_row)])

while(missing_values > 0) {
    which_dest <- ledger_monthly$row_num[is.na(ledger_monthly$last_row)]
    which_source <- which_dest - 1

    ledger_monthly$n_transactions[which_dest] <- 0
    ledger_monthly$tot_deposits[which_dest]   <- 0
    ledger_monthly$tot_expenses[which_dest]   <- 0
    ledger_monthly$last_balance[which_dest]   <- ledger_monthly$last_balance[which_source]
    ledger_monthly$last_row[which_dest]       <- ledger_monthly$last_row[which_source]
    ledger_monthly$max_balance[which_dest]    <- ledger_monthly$max_balance[which_source]
    ledger_monthly$min_balance[which_dest]    <- ledger_monthly$min_balance[which_source]
    ledger_monthly$avg_balance[which_dest]    <- ledger_monthly$avg_balance[which_source]

    ## This drives this loop.
    missing_values <- length(ledger_monthly$row_num[is.na(ledger_monthly$last_row)])
}
## SAVE ------------------------------------------------------------------------
save(ledger_monthly, file="data/ledger_monthly.RData")
if (file.exists(file_name)) {
    message('Complete: ', file_name)
} else {
    stop('Unable to locate: ', file_name)
}
