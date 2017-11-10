## #############################################################################
## CAL_MONTHS
##
## Useful collection of month begin/end dates.
##
## #############################################################################


## INIT ------------------------------------------------------------------------
library(dplyr)
library(lubridate)

file_name <- 'data/cal_months.RData'
if (file.exists(file_name)) unlink(file_name)


## DATA ------------------------------------------------------------------------

## begin <- ymd(20130101) + months(0:11)
## end   <- begin + months(1) - 1
## cal2013 <- tibble(begin, end)

## begin <- ymd(20140101) + months(0:11)
## end   <- begin + months(1) - 1
## cal2014 <- tibble(begin, end)

begin <- ymd(20150101) + months(0:11)
end   <- begin + months(1) - 1
cal2015 <- tibble(begin, end)

begin <- ymd(20160101) + months(0:11)
end   <- begin + months(1) - 1
cal2016 <- tibble(begin, end)

begin <- ymd(20170101) + months(0:11)
end   <- begin + months(1) - 1
cal2017 <- tibble(begin, end)

##cal_months <- bind_rows(cal2013, cal2014, cal2015, cal2016, cal2017)
cal_months <- bind_rows(cal2015, cal2016, cal2017)
cal_months$year <- year(cal_months$begin)
cal_months$month <- month(cal_months$begin)
cal_months$month_lab <- as.character(month(cal_months$begin, label=TRUE, abbr = FALSE))

## SAVE ------------------------------------------------------------------------
save(list = 'cal_months', file = file_name)
if (file.exists(file_name)) {
    message('Complete: ', file_name)
} else {
    stop('Unable to locate: ', file_name)
}


