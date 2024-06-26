# Homework #9
# 27_March_2024
# NRG

###############################################
#Organizing Code With Structured Programming
###############################################

# Use the code that you worked on in Homework #7 (creating fake data sets), and re-organize it following the principles of structured programming.  
# Do all the work in a single chunk in your R markdown file, just as if you were writing a single R script. 
# Start with all of your annotated functions, preliminary calls, and global variables. 
# The program body should be only a few lines of code that call the appropriate functions and run them in the correct order. 
# Make sure that the output from one function serves as the input to the next. You can either daisy-chain the functions or write separate lines of code to hold elements in temporary variables and pass them along.


# Call in libraries
library(tidyverse)
library(ggplot2)
library(MASS)

# Read in the data
setwd("~/Documents/UVM_Research/UVM Rotation Project/ACC Trials")
x<-list.files(pattern="HW9")

# call the new functions with my data set as an argument
# source("Homework9Functions.R")

my_data <- cln_dat("ACCDataHW9.csv", "treatment", "genotype", "length")
# returns clean data set

result <- dat_stat(my_data,"resVar")
print(result)
# returns histogram and summary statistics 

results <- do_anova(my_data, "resVar", "testB")
# Perform ANOVA and create box plot

print(results$ANOVA_summary)
# Print ANOVA summary

print(results$boxplot)
# Print box plot

# Once your code is up and working, modify your program to do something else: record a new summary variable, code a new statistical analysis, or create a different set of random variables or output graph. 
# Do not rewrite any of your existing functions. Instead, copy them, rename them, and then modify them to do new things. 
# Once your new functions are written, add some more lines of program code, calling a mixture of your previous functions and your new functions to get the job done.


# calling a modified function to make a bargraph instead of a boxplot. Pretty lame, but I finally got the code to run...considering this a victory :)
# Read in the data
setwd("~/Documents/UVM_Research/UVM Rotation Project/ACC Trials")
x<-list.files(pattern="HW9")

# call the new function with my data set as an argument

# my_data <- cln_dat("ACCData_HW9.csv", "treatment", "genotype", "length")
# # returns clean data set
# # no change to this function
# 
# result <- dat_stat(my_data,"resVar")
# print(result)
# # returns histogram and summary statistics 
# # no change to this function

results <- do_anova2(my_data, "resVar", "testB")
# Perform ANOVA and create bar plot
# Not saving the world here, but I understand the point

print(results$ANOVA_summary)
# Print ANOVA summary

print(results$barplot)
# Print box plot


# Optional. If time permits and you have the skills, try putting your program inside of a for loop and repeat the analysis with a different stochastic data set 
# (each time you call a function that invokes the random number generator, it will create a new set of data for you to process). 
# Can you create a data structure to store the summary statistics created in each pass through the loop? 
# If not, your program will work, but it will only show the results from the final replicate (the previous results will be written over each time you traverse the loop).




