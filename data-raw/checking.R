## #############################################################################
## checking
## #############################################################################

library(readr)

checking <- read_csv("data-raw/datadownload.csv")

names(checking) <- gsub( " ", "_", tolower(names(checking)) )

save(checking, file = "data/checking.RData")

