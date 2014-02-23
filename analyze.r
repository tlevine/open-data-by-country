library(WDI)
library(plyr)
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
names(cpi)[4] <- 'cpi'
names(gdp)[4] <- 'gdp'
names(pop)[4] <- 'pop'

odi.country <- dcast(odi, Census.Country ~ Data.Availability..Does.the.data.exist.., value.var = 'Census.Country.1')[c(1,4)]
names(odi.country) <- c('Country.Name','n.datasets')
.r <- function(a,b) {
  join(a, b, by = c('Country.Name','Year'))
}
d <- join(.r(.r(cpi, gdp), pop), odi.country, type = 'inner', by = 'Country.Name')
while ('Country.Code' %in% names(d)) {
  d$Country.Code <- NULL
}
