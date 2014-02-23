library(WDI)
library(plyr)
library(reshape2)
library(ggplot2)

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
e <- melt(d, id.vars = c('Country.Name','Year','n.datasets'), value.name = 'value', variable.name = 'stat')

p1 <- ggplot(e) + aes(x = Year, y = value, color = stat, size = n.datasets, group = Country.Name) +
  geom_line() + facet_wrap(~stat, scales="free_y", ncol = 1) +
  scale_y_log10('') +
  ggtitle('Open Data Index results compared to typical country statistics')

p.cpi <- ggplot(subset(e, Year == 2012 & stat == 'cpi')) +
  aes(x = value, y = n.datasets, label = Country.Name) +
  xlab('CPI') + ylab('Number of ODI datasets') +
  geom_text() +
  ggtitle('CPI doesn\'t seem to say much about the number of available important datasets')


p.gdp <- ggplot(subset(e, Year == 2010 & stat == 'gdp')) +
  aes(x = value, y = n.datasets, label = Country.Name) +
  xlab('CPI') + ylab('Number of ODI datasets') +
  geom_text() +
  ggtitle('CPI doesn\'t seem to say much about the number of available important datasets')

ggsave('plot.png', p.gdp)
