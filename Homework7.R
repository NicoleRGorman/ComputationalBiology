# Homework #7
# 28_February_2024
# NRG

# Call in the libraries
library(tidyverse)
library(ggplot2)
library(MASS)

# Read in the data
z <- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_ACCTrials.csv",header=TRUE,sep=",")

# Use regular expressions to subset genotype and then add this column to my dataset
# SEARCH: (\w+_)(\w+),(.*) REPLACE: \2

vecg <- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_ACCTrials_Genotypes.csv",header=TRUE,sep=",")

x <- data.frame(z, vecg)

dataMatrix <- rbind(z,vecg)
#rownames(dataMatrix) <- c("0","10","100")
colnames(dataMatrix) <-c("WT",
                         "CCDC22",
                         "CCDC93",
                         "CCDC22CCDC93",
                         "CCDC22RFP",
                         "CCDC93RFP")
str(dataMatrix)
print(dataMatrix)

# predictor variables are vec1 and vc2...these would be treatments
# column names are response variable

# get the structure and summary metrics
str(z)
summary(z)

# Remove NAs here
z<-na.omit(z)

# Use myVar so I can run the code with any variable  
# just by changing any variable name to myVar
z$myVar <- z$Length

# Plot histogram of data
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

# Add empirical density curve
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# Get maximum likelihood parameters for the normal distribution
normPars <- fitdistr(z$myVar,"normal")
print(normPars)

str(normPars)
normPars$estimate["mean"] # get a named attribute, I think this might be redundant with below

# Specify the sample sizes, means, and variances for each group that would be reasonable if your hypothesis were true. I am going to use the actual parameters from my data set. 
# I will use the null hypothesis, that ACC has no effect on root growth in mutant plants.

m_length <- mean(z$myVar)
print(m_length)

sd_length <- sd(z$myVar)
print(sd_length)

#Plot normal probability density
#meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = m_length, sd = sd_length))
p1 + stat

# Sample size, n = 10 plants/treatment, 3 independent biological replicates

# Using the methods we have covered in class, write code to create a random data set that has these attributes. Organize these data into a data frame with the appropriate structure.
r <- rnorm(1000,10.8,4.6)
mean(r)  
sd(r)    

########## data.frame(r)





