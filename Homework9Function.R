# Homework #9 Functions
# 27_March_2024
# NRG

# Call in libraries
library(tidyverse)
library(ggplot2)
library(MASS)


##########################################################################
# FUNCTION cln_dat
# reads in data and removes NAs 
# input: dataset
# output: dataset with NAs removed
#----------------------------------------------------------------

cln_dat <- function(z=read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_HW9_ACCTrials.csv",header=TRUE,sep=",")) {

  cln_z<-na.omit(z)
  return(cln_z)
}

# end of cln-dat function
##########################################################################


head(cln_dat())
str(cln_dat())

cln_dat() # how would i make default values or what would be useful here?


##########################################################################
# FUNCTION dat_stat
# returns summary statistics 
# input: clean data (NAs removed)
# output: summary statistics
#----------------------------------------------------------------

dat_stat <- function(z=cln_dat()) {
  
  stats<-summary(z)
  stats2<-c(mean(z),sd(z))
  return(stats2)
}

# end of cln-dat function
##########################################################################

print(dat_stat())
dat_stat()
