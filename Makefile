all: data/open-data-index.csv data/cpi.csv data/population.csv data/gdp.csv

data/open-data-index.csv:
	mkdir -p data
	wget -O data/open-data-index.csv 'https://docs.google.com/spreadsheet/pub?key=0Aon3JiuouxLUdEVnbG5pUFlyUzBpVkFXbXJ2WWpGTUE&output=csv'

data/cpi.csv:
	mkdir -p data
	wget -O data/cpi.csv 'https://github.com/datasets/cpi/raw/master/data/cpi.csv'

data/population.csv:
	mkdir -p data
	wget -O data/population.csv 'https://github.com/datasets/population/raw/master/data/population.csv'

data/gdp.csv:
	mkdir -p data
	wget -O data/gdp.csv 'https://github.com/datasets/gdp/raw/master/data/gdp.csv'
