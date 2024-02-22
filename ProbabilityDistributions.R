#Working woith probability distributions in R
# 20 Feb 2024
#NRG

library(ggplot2)
library(MASS)

#Poisson distribution
# Discrete X >= 0
# Random events w a constant rate lambda
#(observations per time or per unit area)
# Parameter lambda > 0

# "d" function generates probability density
hits <- 0:10
myVec <- dpois(x=hits,lambda=1) # 1 is rate of process
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

# Now let's change this to get a feel for the function, double rate
myVec <- dpois(x=hits,lambda=2) # 2 is rate of process
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

# Now again, six times rate
# Need to extend axis to get the rest of the probability mass
hits <- 0:15
myVec <- dpois(x=hits,lambda=6) # 6 is rate of process
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

# Does not need to have an integer value for rate process
hits <- 0:15
myVec <- dpois(x=hits,lambda=0.2) # 0.2 is rate of process
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

# sum up myVec
sum(myVec) # sum of density function = 1.0 (total area under curve)
# returns [1] 1

# For a Poisson distribution with lambda = 2,
# What is the probability that a single draw will yield X = 0?

dpois(x=0,lambda=2)
# returns [1] 0.1353353
# "p" function generates cumulative probability density; gives the 
# "lower tail" cumulative area of the distribution


# for a Poisson distribution with lambda=2, 
# what is the probability of getting 1 or fewer hits?
ppois(q=1, lambda=2)

# do with ppois (instead of dpois)
hits <- 0:10
myVec <- ppois(q=hits,lambda=2) # 2 is rate of process
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

# could also do this using dpois
# We could also get this through dpois
p_0 <- dpois(x=0,lambda=2)
p_0
p_1 <- dpois(x=1,lambda=2)
p_1
p_0 + p_1

#########
#q function() - inverse
##########

# The q function is the inverse of p
# What is the number of hits corresponding to 50% of the probability mass
qpois(p=0.5,lambda=2.5)
qplot(x=0:10,y=dpois(x=0:10,lambda=2.5),geom="col",color=I("black"),fill=I("goldenrod"))


# but distribution is discrete, so this is not exact
ppois(q=2,lambda=2.5)

# finally, we can simulate individual values from a poisson
ranPois <- rpois(n=1000,lambda=2.5)
qplot(x=ranPois,color=I("black"),fill=I("goldenrod"))


# for real or simulated data, we can use the quantile
# function to find the empirical  95% confidence interval on the data

quantile(x=ranPois,probs=c(0.025,0.975))

#Binomial distribution
#################################

#for real or simulated data, we can use the quantile
# function to find empirical 95% 

quantile(x=)

# BINOMIAL DISTRIBUTION
#p= prob of a dichotomous outcome
# size =- number of trials
# x= possible outcomes
# outcome x is bounded betweeen 0 and number of traisl

# use "d" binom 

hits <- 1:10
myVec <- dbinom()
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


###
#Negative Binomial
###
# number of failures 

hits <- 0:40
myVec <- dnbinom(x=hits, size=5, prob=0.5)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


# shift...biased against getting heads, more failures
hits <- 0:40
myVec <- dnbinom(x=hits, size=5, prob=0.2)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))
# not used in biology, but can rework so more useful

#alternatively specify mean = mu of dstribution and size
# the dispresion nparameter ( small is more disperse)
# this gives us a poisson with a lambda value that varies

nbiRan <- rnbinom(n=1000, size=10, mu=5)
##(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

###########################
#Experimental Designs
##########################

#uniform distribution

#runif for randome data
qplot(x=runif(n=100,min=0,max=5),color=I("black"),fill=I("goldenrod"))
qplot(x=runif(n=1000,min=0,max=5),color=I("black"),fill=I("goldenrod"))

#normal dostribvution
myNorm <-rnorm(n=100,mean=1000,sd=2)
qplot(myNorm,color=I("black"),fill=I("goldenrod"))


#problems with normal when mean is small but zero is not allowed
myNorm <-rnorm(n=100,mean=2,sd=2)
qplot(myNorm,color=I("black"),fill=I("goldenrod"))
summary(myNorm)
tossZeroes <- myNorm[myNorm>0]
qplot(tossZeroes,color=I("black"),fill=I("goldenrod"))
##missing line of coding hgere

myGamma <- rgamma(n=100,shape=0.1,scale=10)
qplot(myGamma,color=I("black"),fill=I("goldenrod"))

#look at how scale changes shape of distribution
qplot(rgamma(n=100,shape=0.1,scale=10),color=I("black"),fill=I("goldenrod"))
qplot(rgamma(n=100,shape=0.1,scale=100),color=I("black"),fill=I("goldenrod"))
qplot(rgamma(n=100,shape=0.1,scale=1),color=I("black"),fill=I("goldenrod"))
qplot(rgamma(n=100,shape=0.1,scale=0),color=I("black"),fill=I("goldenrod"))

####################
#beta distribution
####################

#Need this from the notes...tried to just listen

#Missed a bunch here


# two tosses, 1 head amd 1 tail
myBeta <-

#Keep jacking up sample size
# Depends on how much data we have
  
#Missed a bunch here
  
# problem with real data is that we don't actually know parameters
  
  
