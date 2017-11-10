## rmarkdown::render("annual.Rmd",
##                   output_file = "reports/annual-2013.pdf",
##                   params = list(cy = 2013, cy_beg="2013-01-01", cy_end="2013-12-31", incomplete_year = FALSE)
##                   )

## rmarkdown::render("annual.Rmd",
##                   output_file = "reports/annual-2014.pdf",
##                   params = list(cy = 2014, cy_beg="2014-01-01", cy_end="2014-12-31", incomplete_year = FALSE)
##                   )

rmarkdown::render("annual.Rmd",
                  output_file = "reports/annual-2015.pdf",
                  params = list(cy = 2015, cy_beg="2015-01-01", cy_end="2015-12-31", incomplete_year = FALSE)
                  )

rmarkdown::render("annual.Rmd",
                  output_file = "reports/annual-2016.pdf",
                  params = list(cy = 2016, cy_beg="2016-01-01", cy_end="2016-12-31", incomplete_year = FALSE)
                  )

rmarkdown::render("annual.Rmd",
                  output_file = "reports/annual-2016.pdf",
                  params = list(cy = 2016, cy_beg="2016-01-01", cy_end="2016-12-31", incomplete_year = FALSE)
                  )

rmarkdown::render("annual.Rmd",
                  output_file = "reports/annual-2017.pdf",
                  params = list(cy = 2017, cy_beg="2017-01-01", cy_end="2017-12-31", incomplete_year = TRUE)
                  )
