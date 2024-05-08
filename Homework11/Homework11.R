# Homework 11 ----
# Date 10 April 2024
# NRG

# load libraries
library(log4r)
library(TeachingDemos)
library(tidyverse)
library(pracma)
library(ggmosaic)

setwd("/Users/nicolegorman/Documents/UVM_Coursework/ComputationalBiology/Homework11/barracudar")

# source barracudar function files
source("QContour.R")
source("QBub.R")
source("QScat.R")
source("Qcon2.R")
source("Qcon1.R")
source("QBox.R")
source("QLogis.R")
source("QHist.R")
source("AddFolder.R")
source("BuildFunction.R")
source("CreatePaddedLabel.R")
source("DataTableTemplate.R")
source("InitiateSeed.R")
source("MetaDataTemplate.R")
source("SetUpLog.R")
source("SourceBatch.R")

# Question #1. ----
## Download dataset ----
# create original data folder
# ~/Documents/UVM_Coursework/ComputationalBiology/Original Data

# Question #2. ----
# Within each year’s folder, you will only be using a file from each year labeled “countdata” in its title. Using for loops, iterate through each year’s folders to gather the file names of these “countdata” .csv files.

# iterate through each folder-go through each folder-go to levels down each time 
# pattern ="countdata"

## Set working directory ----
setwd("~/Documents/UVM_Coursework/ComputationalBiology/Original Data")

filelist <- list.files("~/Documents/UVM_Coursework/ComputationalBiology/Original Data") 
print(filelist)

###########
# was not able to use a loop to pull out countdata files, kept getting an error message about setting a working directory in a for loop

# filenames <- c()
# 
# for (i in seq_along(filelist)) {
#   setwd(paste0("~/Documents/UVM_Coursework/ComputationalBiology/Original Data","/", filelist[i]))
#   
#   filenames[i] <- list.files(pattern="countdata") # pulls out any file with "countdata"
# }
# 
# print(filenames)  
###########

# code below worked, but not in a loop
# List all files recursively
all_files <- list.files(recursive = TRUE)

# Select all files with "countdata" in their name
filelist <- all_files[grep("countdata", all_files)]

# Print the filenames
print(filelist)

# Read in the data
# data_list contains dataframes
# not sure I need this
data_list <- lapply(filelist, read.csv) 
data_list

# Question #3. ----
### Step 1: Create Pseudo-code ----
# Starting with pseudo-code, generate functions for 1) Cleaning the data for any empty/missing cases 2) Extract the year from each file name, 3) Calculate Abundance for each year (Total number of individuals found), 4) Calculate Species Richness for each year(Number of unique species found)

### Step 2: Write function for each list item ----
##### 1) Cleaning the data ----
# for any empty/missing cases 

for (i in 1:8){
  setwd(paste0("/Users/nicole/Desktop/BIOL6100_Homework11/OriginalData", "/", filelist[i]))
  a=read.csv(file = filenames[i], na.strings = c("","NA"))
  b=a[complete.cases(a["scientificName"]), ]
  setwd("/Users/nicole/Desktop/BIOL6100_Homework11/CleanedData")
  write.csv(b,paste0("CleanedData_",years[i],".csv"))
}
##########################################################################
# FUNCTION clean_data
# read in data, omit NAs
# input: data set 
# output: cleaned data set 
#__________________________________________________________________________

clean_data <- function(data) {
  cleaned_data_list <- list() # create empty list
  
  for (i in seq_along(filelist)) {
    data <- read.csv(filenames[i], row.names = NULL) # Read CSV file
    cleaned <- data[complete.cases(data$scientificName), ]  # remove NAs to clean data
    cleaned_data_list[[i]] <- cleaned_data # Store cleaned data in the list
    setwd("~/Documents/UVM_Coursework/ComputationalBiology/CleanedData")
    write.csv(cleaned,paste0("CleanedData_",filenames[i],".csv"))
    
    return(cleaned_data_list)
  }

# end of clean_data function
##########################################################################

# I could not get this to work inside the function

cleaned_data <- clean_data(data) 
 
}

head (cleaned_data_list)


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