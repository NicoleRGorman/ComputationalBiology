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

#U se the same template and add in the curve for the exponential:
# Plot exponential probability densityexpoPars <- fitdistr(z$myVar,"exponential")
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

summary(z)
# Plant.ID             Length      
# Length:1200        Min.   : 0.610  
# Class :character   1st Qu.: 7.342  
# Mode  :character   Median :10.520  
# Mean   :10.829  
# 3rd Qu.:13.943  
# Max.   :23.310  
# NA's   :196 # Going to need to remove these later     

# Do I need to remove NAs here? Yes!
z<-na.omit(z)
z$myVar <- z$Length

#Plot histogram of data
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

#Add empirical density curve
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

#Get maximum likelihood parameters for normal
normPars <- fitdistr(z$myVar,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute

#Plot normal probability density
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

#Plot exponential probability density
expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2

#Plot uniform probability density
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat3

#Plot gamma probability density
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4

#Plot beta probability density
pSpecial <- ggplot(data=z, aes(x=myVar/(max(myVar + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=z$myVar/max(z$myVar + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(z$myVar), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial

#As predicted, the gamma fits the data set best
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4
stat4

# But the normal also is a pretty good fit
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

# Using the best-fitting distribution, go back to the code and get the maximum likelihood parameters. 

# The best fitting distribution is the gamma
gammaPars <- fitdistr(z$myVar,"gamma")
# Getting Warning messages...
# 1: In densfun(x, parm[1], parm[2], ...) : NaNs produced
# 2: In densfun(x, parm[1], parm[2], ...) : NaNs produced
# 3: In densfun(x, parm[1], parm[2], ...) : NaNs produced
# 4: In densfun(x, parm[1], parm[2], ...) : NaNs produced
# Does this mean it is NOT a good fit?

# Extract the estimated parameters
# Pretty sure this is the same at the maximum likelihood parameters
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
size_parameter <- gammaPars$estimate["size"]

print(gammaPars)
# This returns the same result as getting each separately, see below
#shape         rate   
#4.83401978   0.44639828 
#(0.20872994) (0.02031225)

str(gammaPars)
# gammaPars is  a list of 5 elements
# Not sure why I get two values for each, does each refer to shape and rate?
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

gammaPars$estimate["mean"] # get a named attribute
# NA
# this returns NA, so not sure it can work to generate a new data set
# mean = shape*scale...but not sure how to apply this here, or even if it should be applied
# Here is each parameter separately

shapeML
# 4.83402 
rateML
# 0.4463983 
size_parameter
# NA
# is size the same as mean?

meanML <- gammaPars$estimate["mean"]
print (meanML)
#NA
sdML <- gammaPars$estimate["sd"]
print (sdML)
#NA
# from the structure call above...
# $ sd      : Named num [1:2] 0.2087 0.0203

# Use maximum likelihood parameters from my data set to simulate a new data set, with the same length as your original vector, and plot that in a histogram and add the probability density curve. Right below that, generate a fresh histogram plot of the original data, and also include the probability density 

# I am going to use these parameters in the code that we used to generate the original practice data set

head(z$myVar)
# First I am going to take a look at my variable just for kicks
#[1]  3.57  8.17 11.35 14.27 16.14  6.22
str(z$myVar)
#  num [1:1004] 3.57 8.17 11.35 14.27 16.14 ...
# Does this mean that I have 1004 numbers?

# We generated the randome data set different ways
# I am not sure which one is appropriate, so I will try a couple

qplot(rgamma(n=1004,shape=4.83402,scale=100),color=I("black"),fill=I("goldenrod"))
# Here one way that we generated a data set
# I substituted values returned with the calls above
# $ n       : int 1004
# shapeML, 4.83402
# I am not sure what to do with scale
# I will leave it at 100 for now

nbiRan <- rnbinom(n=1004,size=.5,mu=4.83402 )
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))
nbiRan <- rnbinom(n=1004,size=5,mu=4.83402 )
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))
nbiRan <- rnbinom(n=1004,size=50,mu=4.83402 )
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))
nbiRan <- rnbinom(n=1004,size=500,mu=4.83402 )
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))
nbiRan <- rnbinom(n=1004,size=5000,mu=4.83402 )
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))
# I think mu=mean, n was returned in the results above, size returnes NA


myVec <- dpois(x=hits,lambda=1)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))
# here is the code for the "d" function which generates probability density
# It seems like I should chage some of the inputs, but not sure how to do this

