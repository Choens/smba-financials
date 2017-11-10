## DATA ------------------------------------------------------------------------
## Imports the CSV data from Adirondack Trust and creates three tibbles.
## - cal_months: A convenience table of months
## - ledger: Contains all SMBA financial data.
## - ledger_months: Contains a monthly roll-up of ledger.
##
## The order these run in is important.
##
data: data/cal_months.R data/ledger.R data/ledger_monthly.R data/smba-2015.csv data/smba-2016.csv data/smba-2017.csv
	Rscript 'data/cal_months.R'
	Rscript 'data/ledger.R'
	Rscript 'data/ledger_monthly.R'

reports: annual.R annual.Rmd
	Rscript "annual.R"

current_annual: annual.Rmd
	Rscript -e 'rmarkdown::render("annual.Rmd")'
