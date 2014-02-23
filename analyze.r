library(WDI)
library(reshape2)

if (!all(c('cpi','gdp','odi','pop','wdi') %in% ls())) {
  cpi <- read.csv('data/cpi.csv')
  gdp <- read.csv('data/gdp.csv')
  odi <- read.csv('data/open-data-index.csv', stringsAsFactors = FALSE)
  pop <- read.csv('data/population.csv')
  wdi <- list()
  for (i in WDIsearch()[,'indicator']) {
    wdi[i] <- WDI(indicator=i, start=2013, end=2013)
  }
}
