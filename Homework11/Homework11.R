# Homework 11 ----
# Date 10 April 2024
# NRG

library(log4r)
library(TeachingDemos)
library(tidyverse)
library(pracma)
library(ggmosaic)

# Question #1. ----

## Download dataset ----
## Set working directory ----
dir <- "~/Documents/UVM_Coursework/ComputationalBiology/Original Data"

# Question #2. ----
# Within each year’s folder, you will only be using a file from each year labeled “countdata” in its title. Using for loops, iterate through each year’s folders to gather the file names of these “countdata” .csv files.

# iterate through each folder-go through each folder-go to levels down each time 
# pattern ="countdata"

filenames <- list.files(dir, pattern ="countdata", recursive = TRUE, full.names = TRUE) 
print(filenames)

# Read in the data
# data_list contains dataframes
data_list <- lapply(filenames, read.csv) 

# use a loop to pull out files
my_files <- c()

for (i in seq_along(filenames)) {
   my_files <- c(my_files, filenames[i])
 }
 
 print(my_files)

# Question #3. ----
### Step 1: Create Pseudo-code ----
# Starting with pseudo-code, generate functions for 1) Cleaning the data for any empty/missing cases 2) Extract the year from each file name, 3) Calculate Abundance for each year (Total number of individuals found), 4) Calculate Species Richness for each year(Number of unique species found)

### Step 2: Write function for each list item ----
##### 1) Cleaning the data ----
# for any empty/missing cases 

##########################################################################
# FUNCTION clean_data
# read in data, omit NAs
# input: data set 
# output: cleaned data set 
#__________________________________________________________________________

clean_data <- function(data) {
  cleaned <- data[complete.cases(data$scientificName), ]  # remove NAs to clean data
  return(cleaned)
  }

# end of clean_data function
##########################################################################

# I could not get this to work inside the function

cleaned_data_list <- list() # create empty list

for (i in seq_along(filenames)) {
  data <- read.csv(filenames[i], row.names = NULL) # Read CSV file
  
  cleaned_data <- clean_data(data) 
  
  # Store cleaned data in the list
  cleaned_data_list[[i]] <- cleaned_data
}

head (cleaned_data)

# Now cleaned_data_list contains the cleaned data for each file

##### 2) Extract the year ----
# from each file name

##########################################################################
# FUNCTION extract_year
# Extract year from each file name, "_countdata" followed by date "YYYY-MM", replaces filenames w/ only year
# input: data set 
# output: list of years
#__________________________________________________________________________

extract_year <- function(filename) {
 
  years <- gsub(".*_countdata\\.(\\d{4})-\\d{2}.*\\.csv", "\\1", filename)  # Extract the year from each filename
  years <- as.numeric(years)   # Convert the years to numeric
  years_list <- as.list(years)   # Convert the numeric vector to a list
  print(years_list) # Print the extracted years
  
  return(years)
}

# end of clean_data function
##########################################################################

results <- extract_year(my_data)
print(results)

##### 3) Calculate Abundance ----
# for each year (Total number of individuals found), 

##########################################################################
# FUNCTION abundance
# Read count data from each file and calculate abundance for each year (total number of individuals found)
# input: data set, years 
# output: abundance for each year
#__________________________________________________________________________

abundance <- function(filename) {
  year_abundance <- numeric()  # Create an empty numeric vector to store abundance for each year
  count_data <- read.csv(filename) # Read count data from file
  year <- extract_year(filename)  # Extract year from filename
  year_abundance[year] <- sum(count_data$Count) # Calculate abundance
  return(year_abundance)
}

# end of abundance function
##########################################################################

results <- abundance("NEON.D01.BART.DP1.10003.001.brd_countdata.2022-06.basic.20231229T053256Z.csv")
tail (results)

##### 4) Calculate Species Richness ----
# for each year (Number of unique species found)

##########################################################################
# FUNCTION calculate_richness
# Calculate species richness for each year (number of species found)
# input: data set 
# output: species richness
#__________________________________________________________________________

calculate_richness <- function(filename) {
  count_data <- read.csv(filename) # Read count data from file
  year <- extract_year(filename) # Extract year from filename
  richness <- length(unique(count_data$Species)) # Calculate richness
  return(richness)
}

# end of richness function
##########################################################################

results <- calculate_richness("NEON.D01.BART.DP1.10003.001.brd_countdata.2022-06.basic.20231229T053256Z.csv")
print (results)

# Question #4. ----
## Create empty data frame ----
# to hold the above summary statistics-you should have 4 columns, one for the file name, one for abundance, one for species richness, and one for year.

sum_stats <- data.frame(
  filename = character(),
  abundance = numeric(),
  species_richness = numeric(),
  year = integer(),
  stringsAsFactors = FALSE
)

str(sum_stats)

# Question #5. ----
### Step 3: Create function templates as batch operation ----
## Batch process----
# Using a for loop, run your created functions as a batch process for each folder, changing the working directory as necessary to read in the correct files, calculating summary statistics with your created functions, and then writing them out into your summary statistics data frame.

# Get the list of subdirectories within the main directory
subdirs <- list.dirs(dir, recursive = TRUE)

# Iterate over each subdirectory
for (subdir in subdirs) {
  
  setwd(subdir) # Set working directory to the current subdirectory
  
  # Get the filenames for countdata files in the current subdirectory
  filenames <- list.files(pattern = "countdata", full.names = TRUE)
  
  # Create an empty list to store summary statistics for the current subdirectory
  subdir_summary <- list()
  
  # Iterate over each file in the subdirectory
  for (filename in filenames) {
  
    # Clean the data
    cleaned_data <- clean_data(read.csv(filename))
    
    # Extract the year from the filename
    year <- extract_year(filename)
    
    # Calculate abundance for the current file
    file_abundance <- sum(cleaned_data$Count)
    
    # Calculate species richness for the current file
    file_richness <- calculate_richness(filename)
    
    # Append summary statistics to the subdir_summary list
    subdir_summary[[filename]] <- list(
      filename = filename,
      abundance = file_abundance,
      species_richness = file_richness,
      year = year
    )
  }
  
# Combine summary statistics for the current subdirectory into a data frame
subdir_summary_df <- do.call(rbind, subdir_summary)
  
# Append the subdir_summary_df to the sum_stats data frame
sum_stats <- rbind(sum_stats, subdir_summary_df)
}

# Print the summary statistics data frame
print(sum_stats)

### Step 4: Source all function templates as a batch operation ----
### Step 5: Run each function template ----