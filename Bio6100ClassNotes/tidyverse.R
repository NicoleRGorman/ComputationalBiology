# Ggplot is a component of tidyverse
# opinionated collection of packages
# analogous function, this is not the only way, available in base R
# ggplot2...recommend using
# dplyr also useful

# Using dplyr to manipulate datasets
library(tidyverse) # has dplyer in it

# Core verbs/functions to use
  # filter()
  # arrange()
  #select()
  #summarize and group_by()
  #mutate()

data("starwars")
class(starwars) # tibble is a modern re imagining of a data frame

#tibbles do less, as a trade off to make code simpler and prone to crashing. Don't have to use them but sometimes easier to work with a tibble (but can just do a dataframe)

glimpse(starwars) #glimpse is similar to head
head(starwars) # another way to look at just a part of the data

#Cleaning our data, clean dataset first
#complete.cases is. not part of dplyr, but it is useful

starwarsClean<-starwars[complete.cases(starwars[,1:10]),] #all rows but only one through ten columns

#Check for NAs
is.na(starwarsClean[ ,1]) #Useful for only a few observations since it returns a list of true/false
anyNA(starwarsClean[,1:10])

#Filter function() : pick/subset observations by their values
#uses >, >=, <, <=, !=, == (not just one!) for comparison
#logical operators: & | (or) !(not/negative)
#filter automatically excludes NAs, have to ask for them specifically

filter(starwarsClean, gender== "masculine" & height < 180) # comma or ampersand

filter(starwarsClean, gender== "masculine", height < 180, height > 100) # add multiple conditions for the same variable

# %in% looking for things in which this applies
filter(starwarsClean, eye_color %in% c("blue", "brown"))

# arrange() re-ordering rows in different ways
# Will default to ascending order
# By arguments orders based on which column
arrange(starwarsClean, by=height) #defaults to ascending order
arrange(starwarsClean, by=desc(height))
# Second column to "break ties"
arrange(starwarsClean, height, desc(mass))
starwars1<-arrange(starwars, height) #missing values are at the end, note we have not been assigning anything to a variable, just printing (until now)
tail(starwars1)

#select () function
#choose variables their names
#All of these do the same thing (subset)
starwarsClean[ ,1:10] # using base R
select(starwarsClean, 1:10) # can use column numbers
select(starwarsClean, name:species) #can use column names
select(starwarsClean, -(films:starships)) #subset everything except these particular variables, these three

# Rearrange columns
select(starwarsClean, homeworld, name, gender, species)

select(starwarsClean, homeworld, name, gender, species, everything()) #using everything() helper function if you only have a few variables to move ta the beginning

select(starwarsClean, contains("color")) #Helper functions include: ends_with, start_with, matches (reg ex), num_range

select(starwars, haircolor=hair_color) # helpful to rename functions but only keeps specified variable

rename(starwarsClean, haircolor=hair_color) # just to rename without selecting

#select(starwars, haircolor=hair_color)
rename(starwars, haircolor=hair_color) #keeps all the variables

#mutate() function
#create new variables with functions of existing variables
# Adding new columns. New variables with functions of existing variables

#create a new column of height divided by mass

x<-mutate(starwarsClean, ratio=height/mass) # note we use arithmetic operators

starwars_lbs<-mutate(starwarsClean, mass_lbs=mass*2.2)

select(starwars_lbs, 1:3, mass_lbs, everything()) # bringing mass_lbs to the beginiing using select()

transmute(starwarsClean, mass_lbs=mass*2.2) # just single column

transmute(starwarsClean, mass, mass_lbs=mass*2.2) # you can mention variables you want to keep in the new dataset

# Summarize and group_by. Collapsing many values down to a single summary
summarize(starwarsClean, meanHeight=mean(height)) # gives summary stats for the entire tibble

# Summarize and group_by. Collapsing many values down to a single summary
summarize(starwarsClean, meanHeight=mean(height)) # gives summary stats for the entire tibble

# Cannot summarize with NAs
summarize(starwars, meanHeight=mean(height)) # error
summarize(starwars, meanHeight=mean(height, na.rm=TRUE),TotalNumber=n()) # na.rm, remove any NAs
summarize(starwarsClean, meanHeight=mean(height), number=n())

# Use group_by in conjuction with summarize()
starwarsGenders <- group_by(starwars, gender)

summarize(starwarsGenders, meanHeight=mean(height, na.rm=TRUE), number=n())

#pipe statements
#are use to create a sequence of actions
#passes an intermediate result onto the next functions
#think of the pipe statement as "and then"
# warnings: avoid when you need to manipulate more than one object at a time or there are  meaningful intermediate objects
#formatting: should always have a space before it and usually a new line (usually automatically indent)

starwarsClean %>%
  group_by(gender)%>%
  summaraize(meanHeight=mean(height, na.rm=T), number=n())


#use the case_when (when you have multiple ifelse statements)
 starwarsClean %>%
   mutate(sp= case_when(species=="Human" ~ "Human", TRUE ~ "Non-Human")) %>%
   select(name, sp, everything())

 starwarsClean %>%
   group_by(films)%>%
   mutate(sp= case_when(species=="Human" ~ "Human", TRUE ~ "Non-Human"), status=case_when(str_detect(films, "A New Hope") ~ "OG", TRUE ~ "Later")) %>%
   select(name, sp, status, everything()) %>%
   arrange(status)

 #converting datasets from long to wide format and vice versa
 glimpse(starwarsClean)

 wideSW <- starwarsClean%>%
   select(name,sex, height) %>%
   pivot_wider(names_from = sex, values_from=height, values_fill=NA)
wideSW


pivotSW<-starwars%>%
  select(name, homeworld)%>%
  group_by(homeworld)%>%
  mutate(rn=row_number())%>%
  ungroup()%>%
  pivot_wider(names_from= homeworld, values_from=name)%>%
  select(-rn)

pivotSW

#make data set longer

glimpse(wideSW)

wideSW %>%
  pivot_longer(cols=male:female, names_to = "sex", values_to= "height", values_drop_na=T)

