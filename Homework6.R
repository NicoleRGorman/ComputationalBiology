#Open libraries
library(ggplot2) # for graphics
library(MASS) # for maximum likelihood estimation
library(dplyr)

#Read in data vector
# quick and dirty, a truncated normal distribution to work on the solution set
z <- rnorm(n=3000,mean=0.2)
z <- data.frame(1:3000,z)
names(z) <- list("ID","myVar")
z <- z[z$myVar>0,]
str(z)
summary(z$myVar)

#Plot histogram of data
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)
# Switching from qplot to ggplot for more graphics options
# Rescaling the y axis of the histogram from counts to density, so that the area under the histogram equals 1.0

#Add empirical density curve
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)
# Modify the code to add in a kernel density plot of the data.
# This is an empirical curve that is fitted to the data. 
#It does not assume any particular probability distribution, but it smooths out the shape of the histogram

#Get maximum likelihood parameters for normal
normPars <- fitdistr(z$myVar,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute
# Fit a normal distribution to your data and grab the maximum likelihood estimators of the two parameters of the normal, the mean and the variance

#Plot normal probability density
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat
# Call the dnorm function inside ggplot’s stat_function to generate the probability density for the normal distribution. 
# Note that we first get the maximum likelihood parameters for a normal distribution fitted to these data by calling fitdistr. 
# Then we pass those parameters (meanML and sdML to stat_function)
# Notice that the best-fitting normal distribution (red curve) for these data actually has a biased mean. That is because the data set has no negative values, so the normal distribution (which is symmetric) is not working well.

#Use the same template and add in the curve for the exponential:
# Plot exponential probability density
expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2

# Plot uniform probability density
# For the uniform, we don’t need to use fitdistr because the maximum likelihood estimators of the two parameters are just the minimum and the maximum of the data
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3

#Plot gamma probability density
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

#Plot beta probability density
#This one has to be shown in its own plot because the raw data must be rescaled so they are between 0 and 1, and then they can be compared to the beta.
pSpecial <- ggplot(data=z, aes(x=myVar/(max(myVar + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=z$myVar/max(z$myVar + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(z$myVar), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial

# Now with my own dataset
# Read in dataset
z <- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_ACCTrials.csv",header=TRUE,sep=",")

str(z)
#'data.frame':	1200 obs. of  2 variables:
# $ Plant.ID: chr  "1_1_0nM_WT" "1_1_0nM_WT" "1_1_0nM_WT" "1_1_0nM_WT" 
# $ Length  : num  3.57 8.17 11.35 14.27 16.14 ...

# summary returns the results of model fitting functions  
# in this case, returns mean and sd needed to model the normal distribution  
summary(z)
# Plant.ID             Length      
# Length:1200        Min.   : 0.610  
# Class :character   1st Qu.: 7.342  
# Mode  :character   Median :10.520  
# Mean   :10.829  
# 3rd Qu.:13.943  
# Max.   :23.310  
# NA's   :196 # Going to need to remove these later     

# remove NAs here  
z<-na.omit(z)
# z$myVar <- z$Length
# I don't know why I need the z$ in the object name. I am going to try and change this so that the variable without the nas is called myVar
myVar <- z$Length

# plot histogram of data  
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

# add empirical density curve to smooth out the shape of the data
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# get maximum likelihood parameters for normal
normPars <- fitdistr(myVar,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # get named attribute

# plot normal probability density using mean and sd
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(myVar),len=length(myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

# plot exponential probability density
expoPars <- fitdistr(myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(myVar), args = list(rate=rateML))
p1 + stat + stat2

# plot uniform probability density
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(myVar), args = list(min=min(myVar), max=max(myVar)))
p1 + stat + stat2 + stat3

# plot gamma probability density
gammaPars <- fitdistr(myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

# plot beta probability density
pSpecial <- ggplot(data=z, aes(x=myVar/(max(myVar + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=myVar/max(myVar + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(myVar), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial

# There are two distributions that fit the data set.
# As predicted, the gamma fits the data set 
gammaPars <- fitdistr(myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4
stat4

# But the normal also is a pretty good fit
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(myVar),len=length(myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

# Using the best-fitting distribution, go back to the code and get the maximum likelihood parameters.
# I'll get the parameters for both the normal and the gamma distributions

# The parameters for the normal distribution are mean and sd
# I can get them all at once, or one at a time

# get maximum likelihood parameters for normal
normPars <- fitdistr(myVar,"normal")
print(normPars)
# mean          sd    
# 10.8289333    4.5714441 
# ( 0.1442735) ( 0.1020168)

# call the structure of the normal distribution
str(normPars)
# normPars$estimate["mean"] # get named attribute
# List of 5
# $ estimate: Named num [1:2] 10.83 4.57
# ..- attr(*, "names")= chr [1:2] "mean" "sd"
# $ sd      : Named num [1:2] 0.144 0.102
# ..- attr(*, "names")= chr [1:2] "mean" "sd"
# $ vcov    : num [1:2, 1:2] 0.0208 0 0 0.0104
# ..- attr(*, "dimnames")=List of 2
# .. ..$ : chr [1:2] "mean" "sd"
# .. ..$ : chr [1:2] "mean" "sd"
# $ n       : int 1004
# $ loglik  : num -2951
# - attr(*, "class")= chr "fitdistr"

# plot normal probability density using mean and sd
meanML <- normPars$estimate["mean"]
print (meanML)
# mean = 10.82893 
sdML <- normPars$estimate["sd"]
print (sdML)
# sd = 4.571444 

# The parameters for the gamma distribution are shape and rate
# I can get them all at once or one at a time

gammaPars <- fitdistr(myVar,"gamma")

# This call returns the same result as getting ML parameters separately
print(gammaPars)
# shape         rate   
# 4.83401978   0.44639828 
# (0.20872994) (0.02031225)

# Getting Warning messages, I think this is ok
# 1: In densfun(x, parm[1], parm[2], ...) : NaNs produced
# 2: In densfun(x, parm[1], parm[2], ...) : NaNs produced
# 3: In densfun(x, parm[1], parm[2], ...) : NaNs produced
# 4: In densfun(x, parm[1], parm[2], ...) : NaNs produced

# Extract each of the estimated parameters
shapeML <- gammaPars$estimate["shape"]
print(shapeML)

rateML -> gammaPars$estimate["rate"]
print(rateML)

str(gammaPars)
# gammaPars is  a list of 5 elements
# List of 5
# $ estimate: Named num [1:2] 4.834 0.446
# ..- attr(*, "names")= chr [1:2] "shape" "rate"
# $ sd      : Named num [1:2] 0.2087 0.0203
# ..- attr(*, "names")= chr [1:2] "shape" "rate"
# $ vcov    : num [1:2, 1:2] 0.043568 0.004023 0.004023 0.000413
# ..- attr(*, "dimnames")=List of 2
# .. ..$ : chr [1:2] "shape" "rate"
# .. ..$ : chr [1:2] "shape" "rate"
# $ loglik  : num -2952
# $ n       : int 1004
# - attr(*, "class")= chr "fitdistr"

# Use maximum likelihood parameters from my data set to simulate a new data set, 
# with the same length as your original vector, and plot that in a histogram and add 
# the probability density curve. Note that I adjusted the number of observations to 1000
# (rather than 1004) in order to check that I was modeling the simulated dataset.

# I am going to use the parameters from my dataset in the code that we used to generate the original practice data set

# First I am going to take a look at my data set and then also my variable just for kicks
head(z)
#[1]  3.57  8.17 11.35 14.27 16.14  6.22
head(myVar)
# [1]  3.57  8.17 11.35 14.27 16.14  6.22

str(myVar)
#  num [1:1004] 3.57 8.17 11.35 14.27 16.14 ...
# This means that I have 1004 measurements

# use `rnorm` to simulate a new dataset with the maximum likelihood parameters of my dataset to test this as a model for the distribution of the data

# plot histogram of data to visualize
# p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
#   geom_histogram(color="grey60",fill="cornsilk",size=0.2) 

# First simulate the dataset by generating random data using the ML parameters
# I am not sure whether it make a difference if you create a single call as commented out 
# below or break it up into two like we did in class. 
# I am going to break it up like we did in class

#newz <- data.frame(x = rnorm(n = 1000, mean = 10.8289333))

z <- rnorm(n=1000, mean=10.8289333, sd=4.571444)
z <- data.frame(1:1000,z)
names(z) <- list("ID","newVar")
z <- z[z$newVar>0,]
str(z)
summary(z$newVar)

# Create the histogram as a ggplot object
p1 <- ggplot(z, aes(x = newVar, y=..density..)) +
  geom_histogram(color = "grey60", fill = "cornsilk", size = 0.2) +
  geom_density(linetype = "dotted", size = 0.75)

# Display the plot
print(p1)
str(newVar)
print (newVar)

# Get maximum likelihood parameters for normal by calling fitdistr
# Fit a normal distribution to the data and grab the maximum likelihood estimators 
# of the two parameters of the normal, the mean and the variance
# The simulated dataset should be the same as with the original because it was 
# generated with the ML parameters...right?
normPars <- fitdistr(z$newVar,"normal")
print(normPars)
str(normPars)

#Plot normal probability density
meanML <- normPars$estimate["mean"] 
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$newVar),len=length(z$newVar))
# xval <- seq(min(newVar), max(newVar), length.out = length(newVar))

print (xval)
str(xval)

# pass the parameters (meanML and sdML) to stat_function
# Call the dnorm function inside ggplot’s stat_function to generate the probability density for the normal distribution.
stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$newVar), args = list(mean = meanML, sd = sdML))
p1 + stat

# Right below that, generate a fresh histogram plot of the original data, and also include the probability density curve.

# Read in original data
z <- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_ACCTrials.csv",header=TRUE,sep=",")
str(z)

# remove NAs  
z<-na.omit(z)
myVar <- z$Length

# plot histogram of data  
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

# add empirical density curve to smooth out the shape of the data
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# get maximum likelihood parameters for normal
normPars <- fitdistr(myVar,"normal")
print(normPars)
str(normPars)

# plot normal probability density using mean and sd
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(myVar),len=length(myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

# How do the two histogram profiles compare? Do you think the model is doing a good job 
# of simulating realistic data that match your original measurements? 
# Why or why not?

# Yes...the simulated data is a relatively good model with a couple of exceptions:
# the slope of the curve from the men is steeper in the simulation 
# the tails are more protracted/elongated in the simulation
# additional work might be needed to identify a better fitting model depending on the application
