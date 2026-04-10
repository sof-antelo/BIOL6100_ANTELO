# Basics of SQL

library(tidyverse)
library(sqldf)

# Read in the dataset
species_clean <- read.csv("site_by_species.csv")

head(species_clean)

var_clean <- read.csv("site_by_variables.csv")
var <- filter(var_clean, Site < 30)

# Start with operations/functions on just one file

# Subsetting rows
# dplyr:use filter()

species <- filter(species_clean, Site < 30) # Get all of the sites less than 30
species

# SQL Method-you first need to specify a query you'll use, and then run the sqldf()

query <- "SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE Site < '30'" # select specific columns from a specific data/object, where filters for a condition

sqldf(query)

# Dplyr for subsetting columns

edit_species <- species|>
  select(Site, Sp1, Sp2, Sp3)

edit_species2 <- species|>
  select(1, 2, 3, 4) # Calling on column names/positions are equivalent

# Query the entire table
query <- "SELECT * FROM species"
a <- sqldf(query)

# Renaming columns
# in dplyr you would just use rename() function

species <- rename(species, Long=Longitude.x., Lat=Latitude.y.)
head(species)

# If you're doing this in SQL, you can use the AS command

query <- "SELECT Long AS Longitude FROM species"
sqldf(query)

# Pull out all of the numeric columns

num_species <- species|>
  mutate(letters=rep(letters, length.out=length(species$Site)))

num_species <- select(num_species, Site, Long, Lat, Sp1, letters)

num_species_edit <- select(num_species, where(is.numeric))

# Pivot longer to lengthen the dataset, decreasing the number of columns and increasing the number of rows
# You may also see gather() but that's an outdated function

species_long <- pivot_longer(edit_species, cols=c(Sp1, Sp2, Sp3), names_to="ID")

species_wide <- pivot_wider(species_long, names_from=ID) # Don't need quotes because it's specifically looking for a column name

# Aggregation of data, getting kinds of calculation

# SQL
query <- "SELECT SUM(Sp1+Sp2+Sp3) FROM species_wide GROUP BY SITE"
sqldf(query)

query <- "SELECT SUM(Sp1+Sp2+Sp3) AS Occurence FROM species_wide GROUP BY SITE"
sqldf(query)

# 2 file operations joining datasets together
# Joining things can often left/right/union joins
# Check graphic from website on joins

# Start with clean versions of these variables
edit_species <- species_clean|>
  filter(Site<30)|>
  select(Site, Sp1, Sp2, Sp3, Longitude.x., Latitude.y.)

edit_var <- var_clean|>
  filter(Site<30)|>
  select(Site, Longitude.x., Latitude.y., BIO1_Annual_mean_temperature, BIO12_Annual_precipitation)

# Left join-stitching the matching rows from file B to file A-it requires a matching/marker column to link the two datasets

left <- left_join(edit_species, edit_var, by="Site")
right <- right_join(edit_species, edit_var, by="Site")

inner <- inner_join(edit_species, edit_var, by="Site")
# Retain the rows that match between both files it loses a lot of information if they aren't matching

# full joins are the opposite, retaining all values but you end up with a tradeoff of having a lot of NAs instead of missing data

full <- full_join(edit_species, edit_var, by="Site")

# SQL method for joining data
query <- "SELECT * FROM edit_var RIGHT JOIN edit_species ON edit_var.Site=edit_species.Site;"
x <- sqldf(query)