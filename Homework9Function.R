# Homework #9 Functions
# 27_March_2024
# NRG

# Call in libraries
library(tidyverse)
library(ggplot2)
library(MASS)

# Read in the data
setwd("~/Documents/UVM_Research/UVM Rotation Project/ACC Trials")
x<-list.files(pattern="HW9")

##########################################################################
# FUNCTION cln_dat
# read in data, omit NAs, and reassign generic variable names for downstream analysis 
# input: data set with original variable names
# output: cleaned data set with generic variable names
#----------------------------------------------------------------

cln_dat <- function(filename, varA, varB, resVar) {
  data<-read.csv(filename)
  
  data<-na.omit(data)  # remove NAs to clean data
  ID <- seq_len(nrow(data)) # Create sequence for ID
  
  a <- data [[varA]]
  b <- data [[varB]]
  res <- data [[resVar]]
  # assign variables for easier downstream analysis
  
  my_data<-data.frame(ID, testA=a, testB=b, resVar=res)  
  # create dataframe
  
  return(my_data)
}
# end of cln_dat function
##########################################################################

# Read in and clean data
my_data <- cln_dat("ACCData_HW9.csv", "treatment", "genotype", "length")

##########################################################################
# FUNCTION dat_stat
# returns histogram and summary statistics 
# input: clean data, response variable (= "response")
# output: list of summary statistics and histogram
#----------------------------------------------------------------

dat_stat <- function(my_data, resVar) {
  
  # Plot histogram of data with empirical density curve to smooth out the profile of the distribution
  p1 <- ggplot(data = my_data, aes(x=.data[[resVar]])) +
    geom_histogram(aes(y = after_stat(density)), color="grey60",fill="cornsilk", alpha = 0.7 , bins=20, linewidth=0.2) +
    geom_density(linetype="dotted",linewidth=1.0) + 
    stat_function(fun = dnorm, args = list(mean = mean(my_data[[resVar]]), sd = sd(my_data[[resVar]])), color="red")

  print(p1)
  
  # Get summary stats
  sum_stats <-summary(my_data[[resVar]])

# Get maximum likelihood parameters for the normal distribution
  normPars <- fitdistr(my_data[[resVar]],"normal")

return(list(summary = sum_stats, norm_pars = normPars$estimate))
}

# end of dat-stat function
##########################################################################

result <- dat_stat(my_data,"resVar")
print(result)

##########################################################################
# FUNCTION do_anova
# sets up data frame and then returns anova results 
# input: clean data, response variable (= "response", # treatment groups, treatment groups names)
# output: anova results and box plot

# Define the function
do_anova <- function(my_data, resVar, groupVar) {
  
  # Construct the dataframe for one-way ANOVA
  ANOdata <- data.frame(Group = my_data[[groupVar]], resVar = my_data[[resVar]])
  
  # Perform one-way ANOVA
  ANOVA_result <- aov(resVar ~ Group, data = ANOdata)
  
  # Summary of ANOVA results
  ANOVA_summary <- summary(ANOVA_result)
  
  # Create a box plot using ggplot
  boxplot <- ggplot(ANOdata, aes(x = Group, y = resVar, fill = Group)) +
             geom_boxplot() +
             labs(title = "Response Variable by Genotype", x = groupVar, y = resVar)
  
  # Return a list containing ANOVA results and the box plot
  return(list(ANOVA_summary = ANOVA_summary, boxplot = boxplot))
}

# end of do_anova function
##########################################################################

# Perform ANOVA and create box plot
results <- do_anova(my_data, "resVar", "testB")

# Print ANOVA summary
print(results$ANOVA_summary)

# Display box plot
print(results$boxplot)

##########################################################################
# FUNCTION do_anova2
# sets up data frame and then returns anova results 
# input: clean data, response variable (= "response", # treatment groups, treatment groups names)
# output: anova results and bar plot

# Define the function
do_anova2 <- function(my_data, resVar, groupVar) {
  
  # Construct the dataframe for one-way ANOVA
  ANOdata <- data.frame(Group = my_data[[groupVar]], resVar = my_data[[resVar]])
  
  # Perform one-way ANOVA
  ANOVA_result <- aov(resVar ~ Group, data = ANOdata)
  
  # Summary of ANOVA results
  ANOVA_summary <- summary(ANOVA_result)
  
  # Create a barplot, change grouping
  barplot <- ggplot(ANOdata, aes(x = Group, y = resVar)) +
    geom_bar(stat = "identity") +
    labs(title = "Mean Response by Treatment", x = "Treatment", y = "Mean Response")

  # Display the plot
  print(barplot)
  
  # Return a list containing ANOVA results and the box plot
  return(list(ANOVA_summary = ANOVA_summary, boxplot = boxplot))
}

# end of do_anova function
##########################################################################

# Perform ANOVA and create box plot
results <- do_anova2(my_data, "resVar", "testB")














