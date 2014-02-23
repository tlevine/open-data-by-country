if (!all(c('cpi','gdp','odi','pop') %in% ls())) {
  cpi <- read.csv('data/cpi.csv')
  gdp <- read.csv('data/gdp.csv')
  odi <- read.csv('data/open-data-index.csv')
  pop <- read.csv('data/population.csv')
}
