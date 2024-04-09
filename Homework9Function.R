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
my_data <- cln_dat("ACCData_HW9.csv", "Plant.ID", "Genotype", "Length")


##########################################################################
# FUNCTION dat_stat
# returns histogram and summary statistics 
# input: clean data, response variable (= "response")
# output: list of summary statistics and histogram
#----------------------------------------------------------------

dat_stat <- function(my_data, resVar) {
  
  # Plot histogram of data with empirical density curve to smooth out the profile of the distribution
  p1 <- ggplot(data = my_data, aes(x=.data[[resVar]])) +
    geom_histogram(aes(y = ..density..), color="grey60",fill="cornsilk", alpha = 0.7 , bins=20, linewidth=0.2) +
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
# FUNCTION anova
# sets up data frame and then returns anova results 
# input: clean data, response variable (= "response", # treatment groups, treatment groups names)
# output: anova results and box plot

anova <- function(my_data, resVar, nGroup, nName) {
  
  # Data frame construction for one-way ANOVA
  TGroup <- rep(nName, each = nGroup * nrow(my_data) / length(nName))
  ANOdata <- data.frame(TGroup = TGroup, resVar = my_data[[resVar]])
  
  # Run basic ANOVA
  ANOmodel <- aov(resVar ~ TGroup, data = ANOdata)
  
  summary(ANOmodel)
  
  mean_data <- aggregate(resVar ~ TGroup, data = ANOdata, FUN=mean)
  f_val <- summary(ANOmodel)[[1]]$"F value"[1]

  # Use ggplot to visualize the ANOVA data
  ANOPlot <- ggplot(data = ANOdata) + 
    aes(x = TGroup, y = resVar, fill = TGroup) +
    geom_boxplot()

return(list(plot = ANOPlot, mean_data = mean_data, F_val = f_val))
}

# end of anova function
##########################################################################

ANOplot <- anova(my_data, "resVar", 6, c("WT", "CCDC22", "CCDC93", "CCDC22CCDC93", "CCDC22RFP", "CCDC93RFP"))
print(ANOplot)

