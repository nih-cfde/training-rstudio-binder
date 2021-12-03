# Seattle Pet Names

The [Seattle Open Data Portal](https://data.seattle.gov/) contains many interesting datasets, including one with the names of registered pets [here](https://data.seattle.gov/Community/Seattle-Pet-Licenses/jguv-t9rb). ing this data!

A few articles examined the most popular pet names in 2018, one from [Seattle](https://seattle.curbed.com/2019/1/2/18165658/seattle-popular-pet-names-2018) specifically, and another from [Australia](https://www.countryliving.com/uk/wildlife/pets/a25302522/2018s-popular-pet-names-bella-luna-max/). 

This dataset has also been used for a [Tidy Tuesday event](https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-03-26/readme.md)

## Data Overview

License Issue Date,License Number,Animal's Name,Species,Primary Breed,Secondary Breed,ZIP Code

|variable           |class     |description |
|:------------------|:---------|:-----------|
|License Issue Date | date | Date registered   |
|License Number    | numeric | Unique license number          |
|Animal's Name     |character | Animal's name          |
|Species            |character | Generic name (e.g. dog, cat, goat)           |
|Primary Breed      |character | Primary breed of the animal          |
|Secondary Breed    |character | (if mixed)         |
|ZIP Code           | numeric | Seattle zip code registered under           |