# Homework 11
# Date 10 April 2024
# NRG

library(log4r)
library(TeachingDemos)
library(tidyverse)
library(pracma)
library(ggmosaic)

# check grocery list
# dinner party function

setwd ("~/Documents/UVM_Coursework/ComputationalBiology/Original Data")

# 2. Within each year’s folder, you will only be using a file from each year labeled “countdata” in its title. Using for loops, iterate through each year’s folders to gather the file names of these “countdata” .csv files.

# iterate through each folder-go through each folder-go to levels down each time 
# pattern ="countdata"

filenames <- list.files("~/Documents/UVM_Coursework/ComputationalBiology/Original Data/", pattern ="countdata", recursive = TRUE) 
print(filenames)

# use a loop for number of files that I am concerned with, pull out files
my_files <- c()

for (i in seq_along(filenames)) {

  my_files <- c(my_files, filenames[i])
}

print(my_files)

# Starting with pseudo-code, generate functions for 1) Cleaning the data for any empty/missing cases, 2) Extract the year from each file name, 3) Calculate Abundance for each year (Total number of individuals found), 4) Calculate Species Richness for each year(Number of unique species found)

##########################################################################
# FUNCTION clean_data
# read in data, omit NAs
# input: data set 
# output: cleaned data set 
#----------------------------------------------------------------
clean_data <- function(data) {

  cleaned <- my_data[complete.cases(data$scientificName), ]  # remove NAs to clean data
  return(cleaned)
  }

# end of clean_data function
##########################################################################

cleaned_data_list <- list() # create empty list

#filelist <- list.files("~/Documents/UVM_Coursework/ComputationalBiology/Original Data", full.names = TRUE)
 
 for (i in seq_along(filenames)) {
 # Read CSV file
   my_data <- read.csv(filenames[i], row.names = NULL)
 
 # Clean the data
 cleaned_data <- clean_data(my_data)
 
 # Store cleaned data in the list
 cleaned_data_list[[i]] <- cleaned_data
 }

head (cleaned_data)

# Now cleaned_data_list contains the cleaned data for each file

# 2) Extract the year from each file name

##########################################################################
# FUNCTION data_years
# Extract the year from each file name
# input: data set 
# output: list of years
#----------------------------------------------------------------

data_years <- function(data) {
  
  # Extract the year from each filename
  years <- gsub(".*_countdata\\.(\\d{4})-\\d{2}.*\\.csv", "\\1", filenames)
  
  # Convert the years to numeric
  years <- as.numeric(years)
  
  # Convert the numeric vector to a list
  years_list <- as.list(years)
  
  # Print the extracted years
  print(years_list)
  
  return(years)
}

# end of clean_data function
##########################################################################

data_years(my_data)

# Read count data from each file and calculate total abundance for each year
abundance <- numeric()  # Create an empty numeric vector to store abundance for each year

for (filename in filenames) {
  # Read count data from file
  count_data <- read.csv(filenames)
  
  # Extract year from filename
  year <- as.numeric(gsub(".*_countdata\\.(\\d{4})-\\d{2}.*\\.csv", "\\1", filenames))
  
  # Calculate total abundance for the year and add it to the corresponding position in the vector
  abundance[year] <- abundance[year] + sum(count_data$Count)
}

# Print the abundance for each year
print(abundance)



















##########################################################################
# FUNCTION cln_dat
# read in data, omit NAs
# input: data set with original variable names
# output: cleaned data set with generic variable names
#----------------------------------------------------------------

cln_dat <- function(filenames) {
  data<-read.csv(filenames)
  
  data<-na.omit(data)  # remove NAs to clean data
  
  my_data<-data.frame(year)  
  # create dataframe
  
  return(my_data)
}
# end of cln_dat function
##########################################################################









year <- seq_len(nrow(data)) # Create sequence for ID

trt <- data [[treatment]]
geno <- data [[genotype]]
resVar <- data [[resVar]]
# assign variables for easier downstream analysis


















# Create an initial empty data frame to hold the above summary statistics-you should have 4 columns, one for the file name, one for abundance, one for species richness, and one for year.
#
# Using a for loop, run your created functions as a batch process for each folder, changing the working directory as necessary to read in the correct files, calculating summary statistics with your created functions, and then writing them out into your summary statistics data frame.


      