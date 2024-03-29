# Manipulating data using dplyr
# NRG
# 19-20 March, 2024

#dplyr and SQL

# loading packages
library(tidyverse)
library(sqldf)
library(dplyr)

#First, load the data set

species_clean<-read.csv("/Users/nicolegorman/Downloads/doi_10_5061_dryad_4mw6m90b9__v20210929/site_by_species.csv")
var_clean<-read.csv("/Users/nicolegorman/Downloads/doi_10_5061_dryad_4mw6m90b9__v20210929/site_by_variables.csv")

#Take a look at the datasets first
head(species_clean)
head(var_clean)

#start using operations with only one file

#subsetting rows
# How to subset rows
#dplyr: filter() method
species<-filter(species_clean, Site<30)
var<-filter(var_clean, Site<30)

#SQL Method
# Create a query first

query="select Site, Sp1, Sp2, Sp3 FROM species WHERE Site < '30'"
sqldf(query)

##How to subset columns
#Dplyr method-uses select() function, which can use either column # or name
#dplyr method
edit_species<-species%>%
  select(Site, Sp1, Sp2, Sp3)

edit_species22<-species%>% #Using column #s doesn't require any indicators
  select(1, 2, 3, 4)

#SQL method-
#Query entire table in SQL
query="SELECT * FROM species"

a=sqldf(query) # save results to data frame
sqldf(query) # dump to console

#Specify columns
# reorder columns
query ="
SELECT Sp1, Sp2, Sp3, Site
FROM species
"
sqldf(query)

# reordering columns
query="SELECT Sp1, Sp2, Sp3, Site FROM species"
sqldf(query)

#If we want to rename columns, we can just use the rename() function
#Dplyr method

species<-rename(species, Long=Longitude.x., Lat=Latitude.y.)

#Pull out all the numerical columns
#dplyr method

num_species<-species%>%
  mutate(letters=rep(letters, length.out=length(species$Site)))
num_species<-select(num_species, Site, Long, Lat, Sp1,letters)
num_species_edit<-select(num_species, where(is.numeric))

#Pivot longer and pivot wider
#gather=longer, spread=wider
#Pivot_longer (gather) lengthens the data, decreases the number of cols, and increases the number of runs
#Pivot_longer lengthens the data, decreasing the number of columns, and increases the number of rows. Can use either pivot_longer or gather, but gather is outdated
species_long<-pivot_longer(edit_species, cols=c(Sp1, Sp2, Sp3), names_to="ID")
head(species_long)

#Pivot_wide
#Pivot_wide goes from long to wide, widens the data, increasing the number of columns, decreases the number of rows. Can use pivot_wider or spread
#go back to where you started
species_wide<-pivot_wider(species_long,names_from="ID")
head(species_wide)

#SQL Method
##Aggregate and give counts with new variable name

query="
SELECT SUM(Sp1+Sp2+Sp3)
FROM species_wide
GROUP BY SITE
"
sqldf(query)

#Aggregate and give counts with new variable name
# Same thing adds the output as a column

query="
SELECT SUM(Sp1+Sp2+Sp3) AS OCCURANCE
FROM species_wide
GROUP BY SITE
"
sqldf(query)

#Mutating/Adding columns Dplyr method-uses mutate function()-we’ve already covered this!
#SQL Method
# AS OCCURANCE is the same as mutate function
#Mutate in SQL -create new column

query="
ALTER TABLE species_wide
ADD new_column VARCHAR
"
sqldf(query)

#Re-ordering columns
#Dplyr method-using the select() method
reorder<-select(species, Sp1, Sp2, Site)

#SQL Method reorder columns
query ="
SELECT Sp1, Sp2, Sp3, Site
FROM species
"
sqldf(query)

#2 File Operations
#Joins: gathering data into usable formats.
#People will often store data into different variables/types of data into different files.
#As opposed to just binding things, we often need to join them together.
#binding just immediately pastes the rows/columns together, and by position, not by anything meaningful
# interact with 2 data files (.csv’s), and try to gather them into a usable form

#Left/Right/Union joins

#Let's start with a clean set of files: reset the species and var variables, and filter them to a smaller size

edit_species<-species_clean%>%
  filter(Site <30)%>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)

edit_var<-var_clean%>%
  filter(Site <30)%>%
  select(Site, Longitude.x., Latitude.y.,
BIO1_Annual_mean_temperature,
BIO12_Annual_precipitation)

#Left join - stitching the matching rows of file A to file B
#Left_join-a left join basically means you are stitching the matching rows of file B
#to file A-this does require that there be some matching/marker column to actually link.
#dplyr method
left<-left_join(edit_species, edit_var, by="Site")
head(left)


#Right join - stitching the matching rows of file A to file B
#The difference here is what is lost when you match them together
#dplyr method
right<-right_join(edit_species, edit_var, by="Site")
head(right)

#Inner_join - retains rows that match between both rows of file A to file B. It loses a lot of info (sometimes)
inner<-inner_join(edit_species, edit_var, by="Site")
head(inner)

#Full_join - opposite of inner_join, retains all rows, instead of losing many rows, you just have a bunch of NA's wherever there is missing data
full<-full_join(edit_species, edit_var, by="Site")
head(full)

# SQL method
query="
SELECT BIO1_Annual_mean_temperature,
BIO12_Annual_precipitation FROM edit_var
INNER JOIN edit_species ON edit_var.Site=edit_species.Site
"
x<-sqldf(query)

# ------------------------------
# left join keeps all rows from the first table and adds
# data from second table for matches and NAs for mismatches (n = 500 rows = row number in Orders table)
query="
SELECT BIO1_Annual_mean_temperature, BIO12_Annual_precipitation
FROM edit_var
LEFT JOIN edit_species ON edit_var.Site = edit_species.Site
"
x<-sqldf(query)


