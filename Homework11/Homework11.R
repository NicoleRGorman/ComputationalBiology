# Homework 11
# Date
# NRG

# check grocery list
# Dinner party function

setwd ("~/Documents/UVM_Coursework/ComputationalBiology/Original Data")

# iterate through each folder-go through each folder-go to levels down each time 
#pattern="countdata"

filelist <- list.files("~/Documents/UVM_Coursework/ComputationalBiology/Original Data", pattern="BART") 
filelist

# will gather strings
#paste0() function
#paste0("here is", " the", " filepath:", filelist[1])

# use a loop for number of files that I am concerned with, pull out files
filenames <- c()
for (i in 1:9){
  setwd(paste0("~/Documents/UVM_Coursework/ComputationalBiology/Original Data", "/", filelist[i]))
  
  filenames[i] <- list.files(pattern="countdata")
  
}
filenames

data.frame <- c("countdata")

# Starting with pseudo-code, generate functions for 1) Cleaning the data for any empty/missing cases, 2) Extract the year from each file name, 3) Calculate Abundance for each year (Total number of individuals found), 4) Calculate Species Richness for each year(Number of unique species found)

##########################################################################
# FUNCTION cln_dat
# read in data, omit NAs
# input: data set 
# output: cleaned data set 
#----------------------------------------------------------------

for (i in 1:9){
  (paste0("~/Documents/UVM_Coursework/ComputationalBiology/Original Data", "/", filelist[i])) 
  
  cln_dat <- function(filenames) {
  my_data<-read.csv(filenames[[i]])
    
  my_data<-na.omit(data)  # remove NAs to clean data
}
}  
  return(my_data)

# end of cln_dat function
##########################################################################
cln_dat()


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


      