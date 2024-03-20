#dplyr and SQL

# loading packages
library(tidyverse)
library(sqldf)

#First, load the data set

species_clean<-read.csv("/Users/nicolegorman/Downloads/doi_10_5061_dryad_4mw6m90b9__v20210929/site_by_species.csv")
var_clean<-read.csv("/Users/nicolegorman/Downloads/doi_10_5061_dryad_4mw6m90b9__v20210929/site_by_variables.csv")

#start using operations with only one file

#subsetting rows

#dplyr: filter() method
species<-filter(species_clean, Site<30)
var<-filter(var_clean, Site<30)

#SQL Method
# Create a query first

query="select Site, Sp1, Sp2, Sp3 FROM secies WHERE Site < '30'"

sqldf(query)

#subset cols we use the

edit_species<-species%>%
  select(Site, Sp1, Sp2, Sp3)

edit_species22<-species%>%

#Query entire table in SQL
query="SELECT * FROM species"

a=sqldf(query)
sqldf(query)


# reordering columns

query="SELECT Sp1, Sp2, Sp3, Sire FROM species"
sqldf(query)

#Pivot longer and pivot wider
#gather=longer, spread=wider
#Pivot_longer (gather) lengthens the data, decreases the number of cols, and increases the number of runs

species_long<-pivot_longer(edit_species, cols=c(Sp1, Sp2, Sp3), names_to="ID")
head(species_long)

#go back to where you started
species_wide<-pivot_wider(especies_long,names_from="ID")
head(species_wide)

#SQL Method
##Aggregate to gve object types

query="
SELECT SUM(Sp1+Sp2+Sp3)
FROM species_wide
GROUP BY SITE
"

sqld(query)

# Same thing adds the output as a column
query="
SELECT SUM(Sp1+Sp2+Sp3) AS OCCURANCE
FROM species_wide
GROUP BY SITE
"

# AS OCCURANCE is the same as mutate function
#Mutate in SQL -create new column
query="
ALTER TABLE species_wide
ADD new_column VARCHAR
"
sqldt(query)

#2 File Optopns
#Joins: gathering data into usable formats. People will ofetn store data into differetvariables/types of data into different files. As opposed to just bindiong tjins, we ofeten need to join them together.

#Left/Right/Umnion joins

#Let's start with a clean set of fiules: reset the species and var variables, and filter them to a s,al;;er size

edit_species<-speices_clean%>%
  filter(Site <30)%>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)

edit_var<-var_clean%>%
  filter(Site <30)%>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.,
BIO1_Annual_men_temperature,
BIO12_Annual_precipitation)

#Left join - stitching the matching rows of file A to file B
#dplyr method
left<-left_join(edit_species, edit_var, by="Site")


#Right join - stitching the matching rows of file A to file B
#dplyr method
right<-right_join(edit_species, edit_var, by="Site")

#Inner_join - retains rows that match between both rows of file A to file B. It loses a lot of info (sometimes)
inner<-inner_join(edit_species, edit_var, by="Site")

#Full_join - opposite of inner_join, retains all rows, instead of losing many rows, you just have a bunch of NA's wherever there is missing data
full<-full_join(edit_species, edit_var, by="Site")

query="
SELECT BIO1_Annual_men_temperature,
BIO12_Annual_precipitation FROM edit_var
INNER JOIN edit_species ON edit_var.Site=edit_species.Site
"
x<-sqldf(query)



