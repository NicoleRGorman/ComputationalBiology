# First comment to explain what this program is doing.
# Be expansive and describe in great detail This may seem trivial, but needs to happen
# Simple script to examine the distribution of the produce of two uniform  variable
#. 25 January 2024
# NRG

# Preliminaries
library(ggplot2)
set.seed(100)
library(TeachingDemos) #use this to set the random number seed from a character string
char2seed("green tea")
char2seed("green tea", set=FALSE)
# [1] 7023541 large random integer
# Run down in console and get the same
# [1] 0.2495337 0.5074827 0.5284712 0.5035891
# Allows for reproducibility

# Global variables
nRep <- 10000

ranVar1 <-
