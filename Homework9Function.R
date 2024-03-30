# Homework #9 Functions
# 27_March_2024
# NRG

# Call in libraries
library(tidyverse)
library(ggplot2)
library(MASS)

# Read in the data
# z <- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_HW9_ACCTrials.csv",header=TRUE,sep=",")

##########################################################################
# FUNCTION cln_dat
# read in and clean data by removing NAs 
# input: dataset
# output: dataset with NAs removed
#----------------------------------------------------------------

cln_dat <- function(z) {
  if (missing(z)) {
  z<- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_HW9_ACCTrials.csv",
               header=TRUE,sep=",")
}

  cln_z<-na.omit(z)
  # remove NAs to clean data
  
  return(cln_z)
}

# end of cln_dat function
##########################################################################


head(cln_dat())
str(cln_dat())

cln_dat() # how would i make default values or what would be useful here?

##########################################################################
# FUNCTION my_vars
# reasign generic variable names for easier downstream analysis 
# input: dataset with original variable names
# output: dataset with generic variable names
#----------------------------------------------------------------

my_vars <- function(z) {
  ID <- seq_len(nrow(z))
  # Create sequence for ID

  varA <- z$Plant.ID
  varB <- z$Genotype
  resVar <- z$Length
  # assign variables for easier downstream analysis

  return(data.frame(ID, varA, varB, resVar))
}
# end of my_vars function
##########################################################################

head(my_vars(z))
str(my_vars(z))

# Global variables
#Do I specify a global variable here? Seems like better at the beginning...
# How can I edit the function so that mI can change my response variable and run the same code?

resVar <- my_vars(z)$Length

##########################################################################
# FUNCTION dat_stat
# returns histogram and summary statistics 
# input: clean data (NAs removed), response variable name
# output: list of summary statistics
#----------------------------------------------------------------

dat_stat <- function(z, Length) {
  require(ggplot2)
  require(MASS)
  
  # Plot histogram of data with empirical density curve to smooth out the profile of the distribution
  # alpha adjusts bar transparency, bins are intervals
  p1 <- ggplot(data = z, aes(x=Length, y=..density..)) +
    geom_histogram(color="grey60",fill="cornsilk", alpha = 0.7 , bins=20, linewidth=0.2) +
    geom_density(linetype="dotted",linewidth=1.0)
  print(p1)
  
  # Get summary stats
  sum_stats <-summary(z[[Length]])

# Get maximum likelihood parameters for the normal distribution
  normPars <- fitdistr(z[[Length]],"normal")

return(list(summary = sum_stats, norm_pars = normPars$estimate))
}

# end of dat-stat function
##########################################################################

str(z) 

print(dat_stat(z))
dat_stat(z)

# 1: Removed 196 rows containing non-finite values (`stat_bin()`). 
# 2: Removed 196 rows containing non-finite values (`stat_density()`). 






