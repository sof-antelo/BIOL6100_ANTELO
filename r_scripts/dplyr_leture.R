#filter(), arrange(), select(), summarize(), group_by(), and mutate()

#start with built-in dataset
library(tidyverse)
dplyr::filter()
stats::filter()

data(starwars)
class(starwars)

head(starwars)
tail(starwars)
glimpse(starwars)
structure(starwars)

#cleaning NAs
#Base R has the complete.cases, removes all rows containing NAs

starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
  #indexing within complete cases 1:10 only applies it to the first ten rows

#filter() subsets observations by their values
#uses >, <=, >=, ==, and !
#logical operators like & and |
#automatically excludes NA, have to ask for them specifically

filter(starwarsClean, gender == "masculine" & height < 180)

filter(starwarsClean, gender == "masculine", height < 180, height > 100 )

filter()

#arrange rewords rows
arrange(starwarsClean, by=height)
arrange(starwarsClean, by=desc(height))

#select choose variables based on their names/columns
select(starwarsClean, 1:10)
select(starwarsClean, name:homeworld)
select(starwarsClean, -(films:starships))

#rearrange columns
select(starwarsClean, homeworld, name, gender, species, everything())

select(starwarsClean, contains("color"))

#rename columns
select(starwars, haircolor=hair_color)

#mutate creates new varribles with funtions of existing variables

#create new column thats height/mass (isnt that bmi? lol)
y <- mutate(starwarsClean, ratio=height/mass)
starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2)

#you can transmute a function to just have it make a new variable
transmute(starwarsClean, mass_lbs=mass*2.2)

#summarize and group_by collapse values down to single summary
summarize(starwars, meanHeight=mean(height)) #doesnt work because there are NAs
summarize(starwars, meanHeight=mean(height, na.rm=TRUE), TotalNumber=n())

#group by for aditional calculations
starwarsGender <- group_by(starwars, gender)
summarize(starwarsGender, meanHeight=mean(height, na.rm=TRUE), number=n())

# pipe statements -the pipe operator is %>%, or |>

#these are sequences of actions that will change your dataset
#its going to pass intermediate results onto the next functions in sequence
#should avoid this whe yo need to manipulate more than one object
#formatting: always have a space before and auto indent

starwarsClean%>%
  group_by(gender)%>%
  summarize(meanHeight=mean(height, na.rm=TRUE), number=n())

starwarsClean%>%
  mutate(sp=case_when(species=="Human"~"Human", TRUE~ "Non-human"))%>%
  select(name, sp, everything())
unique(starwarsClean$species)

glimpse(starwarsClean)

#pivot from long to wide format using pivot_wider or pivot_longer

wideSW <- starwarsClean%>%
  select(name,sex,height)%>%
  pivot_wider(names_from=sex, values_from = height, values_fill = NA)
wideSW

pivotSW <- starwars%>%
  select(name,homeworld)%>%
  group_by(homeworld)%>%
  mutate(rn=row_number())%>%
  ungroup()%>%
  pivot_wider(names_from = homeworld, values_from = name)

wideSW%>%
  pivot_longer(cols=male:female, names_to = "sex", values_to = "height",
values_drop_na = TRUE)
