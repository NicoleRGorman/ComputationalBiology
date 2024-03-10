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

# subset the genotype column
genotype <- vecg$Genotype

# add vecg as a column to the dataset
z$Genotype <- genotype

# I tried this way, but did not get anywhere, might need this later
# #rownames(dataMatrix) <- c("0","10","100")
# colnames(dataMatrix) <-c("WT",
#                          "CCDC22",
#                          "CCDC93",
#                          "CCDC22CCDC93",
#                          "CCDC22RFP",
#                          "CCDC93RFP")
# str(dataMatrix)
# print(dataMatrix)

# predictor variables are vec1 and vc2...these would be treatments
# column names are response variable

# Sample size, n = 10 plants/genotype/treatment
# There are 3 independent biological replicates, but only the first replicate is included with this dataset

# get the structure and summary metrics of the new dataset
str(z)
summary(z)

# take a peek to make sure that the genotype column is all there
head (z)
tail (z)

# Remove NAs here
z<-na.omit(z)
# get the structure of z wuithout the NAs
str(z)

# Use myVar for my response variable (length) so I can run the code with any response variable by 
# changing the variable name to myVar
z$myVar <- z$Length

# define variables for easier downstream analysis
ID <- seq_len(nrow(z)) # creates a sequence from 1:n (if n > 0!)
varA <- z$Plant.ID
varB <- z$Genotype
myVar <- z$Length

head(ID)
head (varA)
head(varB)
head (myVar)

# Plot histogram of data
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",linewidth=0.2) 
print(p1)

# Add empirical density curve
p1 <-  p1 +  geom_density(linetype="dotted",linewidth=0.75)
print(p1)

# Get maximum likelihood parameters for the normal distribution
normPars <- fitdistr(z$myVar,"normal")
print(normPars)

str(normPars)
normPars$estimate["mean"] # get a named attribute, I think this might be redundant with below
normPars$estimate["sd"] # get a named attribute, I think this might be redundant with below

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

# Assume that each of the treatments follows a normal distribution  
# Get maximum likelihood (ML) parameters for normal distribution for each treatment
# First get the maximum likelihood parameters for a normal distribution fitted to these data by calling fitsdir 
# Fit normal distributions for each group defined by 'Genotype'

# Fit normal distributions for each treatment (genotype)
# norm_pars <- tapply(z$Length, z$Genotype, function(x) fitdistr(x, "normal"))

# Fit normal distributions for each treatment (genotype/hormone treatment)
norm_pars <- tapply(z$Length, z$Plant.ID, function(x) fitdistr(x, "normal"))

# Come back and do the analysis another time after editing dataset
# Need to make treatment its own column and add all three reps\
# For this analysis, simplify and fit normal distribution for each genotype only

norm_pars <- tapply(z$Length, z$Genotype, function(x) fitdistr(x, "normal"))

# these are rough estimates of root length if using both ACC and genotype
# Save this information for next time :)
# Skip these data and see below for parameter estimates if using JUST genotype

# mean         sd    
######### 0nM
# $`1_1_0nM_WT`
# 10.700000    4.472109 
# ( 1.999988) ( 1.414205)
# $`1_2_0nM_ccdc22`
# 11.328000    4.436014 
# ( 1.983846) ( 1.402791)
# $`1_1_0nM_ccdc93`
# 13.874000    4.813488 
# ( 2.152657) ( 1.522158)
# $`1_2_0nM_ccdc22ccdc93`
# 13.704000    5.159452 
# ( 2.307377) ( 1.631562)
# $`1_2_0nM_ccdc22RFP`
# 14.682000    5.267760 
# ( 2.355814) ( 1.665812)
# $`1_1_0nM_ccdc93RFP`
# 14.800200    5.222040 
# ( 2.335368) ( 1.651354)


######### 10nM
# $`1_1_10nM_WT`
# 13.582000    5.310267 
# ( 2.374824) ( 1.679254)
# $`1_1_10nM_ccdc22`
# 7.300000   3.756972 
# (1.680169) (1.188059)
# $`1_1_10nM_ccdc93`
# 9.972000   3.797154 
# (1.698139) (1.200765)
# $`1_1_10nM_ccdc22ccdc93`
# 8.1960000   1.8234100 
# (0.8154537) (0.5766129)
# $`1_1_10nM_ccdc22RFP`
# 12.638000    4.624255 
# ( 2.068030) ( 1.462318)
# $`1_1_10nM_ccdc93RFP`
# 10.2852000    2.2828781 
# ( 1.0209341) ( 0.7219095)

######### 100nM
# $`1_1_100nM_WT`
# 6.7160000   1.9861279 
# (0.8882234) (0.6280688)
# $`1_1_100nM_ccdc22`
# 7.6620000   3.1125706 
# (1.3919839) (0.9842813)
# $`1_1_100nM_ccdc93`
# 9.5980000   3.1054880 
# (1.3888165) (0.9820415)
# $`1_1_100nM_ccdc22ccdc93`
# 9.934000   3.391782 
# (1.516851) (1.072576)
# $`1_1_100nM_ccdc22RFP`
# 10.2300000    2.3405384 
# ( 1.0467206) ( 0.7401432)
# $`1_1_100nM_ccdc93RFP`
# 7.1680000   1.8515218 
# (0.8280257) (0.5855026)

######### 1000nM (1uM)
# $`1_1_1uM_WT`
# 10.0180000    1.8260164 
# ( 0.8166194) ( 0.5774371)
# $`1_1_1uM_ccdc22`
# 8.3880000   1.7285069 
# (0.7730118) (0.5466019)
# $`1_1_1uM_ccdc93`
# 10.4520000    2.5107003 
# ( 1.1228193) ( 0.7939531)
# $`1_1_1uM_ccdc22ccdc93`
# 8.1420000   2.2386013 
# (1.0011330) (0.7079079)
# $`1_1_1uM_ccdc22RFP`
# 9.9660000   1.9445884 
# (0.8696464) (0.6149328)
# $`1_1_1uM_ccdc93RFP`
# 9.6238000   2.0015200 
# (0.8951069) (0.6329362)

# View the ML parameters for each treatment
print(norm_pars)
summary(norm_pars)
str (norm_pars)

# These are the ML parameters for genotype only

# $WT
# mean          sd    
# 11.8440500    4.6060560 
# ( 0.3256973) ( 0.2303028)
#
# $ccdc22
# mean         sd    
# 9.5992222   4.8467498 
# (0.3612554) (0.2554461)
# 
# $ccdc93
# mean          sd    
# 11.3043333    4.7605129 
# ( 0.3548277) ( 0.2509011)
#
# $ccdc22ccdc93
# mean          sd    
# 10.0921805    4.0788841 
# ( 0.3536841) ( 0.2500924)
# 
# $ccdc22RFP
# mean          sd    
# 10.9336154    4.2258974 
# ( 0.3706357) ( 0.2620790)
# 
# $ccdc93RFP
# mean          sd    
# 10.9235856    4.2714427 
# ( 0.3174938) ( 0.2245020)

# Using the methods we have covered in class, write code to create a random data set that has these attributes. 

# this set of calls creates individual normal distributions for each variable
rWT <- rnorm(50,11.8,4.6)
mean(rWT)  
sd(rWT)  

r22 <- rnorm(50,9.6,4.8)
mean(r22)  
sd(r22)  

r93 <- rnorm(50,11.3,4.8)
mean(r93)  
sd(r93)  

r2293 <- rnorm(50,10.1,4.1)
mean(r2293)  
sd(r2293)  

r22R <- rnorm(50,10.9,4.2)
mean(r22R)
sd(r22R)  

r93R <- rnorm(50,10.9,4.3)
mean(r93R)  
sd(r93R) 

# string these into a single vector

resVar <- c(rWT,r22,r93,r2293,r22R,r93R)
#head (resVar)

# associate each response variable with the appropriate genotype, n=50
rGen <- c(rep("WT", 50), rep("CCDC22", 50), rep("CCDC93", 50), 
          rep("CCDC22CCDC93", 50), rep("CCDC22RFP", 50), 
          rep("CCDC93RFP", 50))

head(rGen)
tail(rGen)

# this is another way to do the same thing
# rep(nName, each=50)
  
# BUT...now that I have written the code above, I don't think I am actually going to use it 
# I can create the dataframe and generate the random numbers in the same call like we did in class

# Data frame construction for one-way ANOVA
# create a dataframe of random variables

nGroup <- 6 # number of treatment groups
nName <- c("WT","CCDC22", "CCDC93", "CCDC22CCDC93", "CCDC22RFP", "CCDC93RFP") # names of groups
nSize <- c(50,50,50,50,50,50) # number of observations in each group, these are all equal in the simulated dataset
# the mean and variance are estimated using pilot trial numbers

nMean <- c(11.8,9.6,11.3,10.1,10.9,10.9) # mean of each group
nSD <- c(4.6,4.8,4.8,4.1,4.2,4.3) # standard deviation of each group

# id vector for each row, just numbers each row for organization and/or reference
ID <- 1:(sum(nSize)) 

# create a vector by concatenating six sets of random normal variables
# reVar is the response variable, root length
resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]), 
            rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]),
            rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3]), 
            rnorm(n=nSize[4],mean=nMean[4],sd=nSD[4]),
            rnorm(n=nSize[5],mean=nMean[5],sd=nSD[5]),
            rnorm(n=nSize[6],mean=nMean[6],sd=nSD[6]))
# sets up single column with all data, this is now in long form

TGroup <- rep(nName,nSize) # TGruop = genotype
ANOdata <- data.frame(ID,TGroup,resVar) # create dataframe
str(ANOdata)
print(ANOdata)

# Run basic ANOVA
# the aggregate function calculates the mean of resVar (root length)for each level 
# of TGroup (genotype) in the ANOdata data frame
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel)) # Estimated effects may be unbalanced, not sure if this message is a problem?
z <- summary(ANOmodel)
str(z)
aggregate(resVar~TGroup,data=ANOdata,FUN=mean)
unlist(z)
unlist(z)[7] # F value1 multiple run results 3.460314 |1.790044  | 3.486434 | 2.642683 | 1.430171 | 2.554768 
ANOsum <- list(Fval=unlist(z)[7],probF=unlist(z)[9])
ANOsum  # Pr(>F)1 multiple run results 0.004699716 | 0.1147189 | 0.004460621 | 0.02346638 | 0.2132236 | 0.02778633 
# Pr(>F) p-value associated with the F-statistic 
# If Pr(>F) is < 0.05, then at least one of the groups is different 

# Use ggplot to visualize the ANOVA data
ANOPlot <- ggplot(data=ANOdata) + 
  aes(x=TGroup,y=resVar,fill=TGroup) +
  geom_boxplot()
print(ANOPlot)

# Try running your analysis multiple times to get a feeling for how variable the results are with the same parameters, but different sets of random numbers.

# Now begin adjusting the means of the different groups. Given the sample sizes you have chosen, how small can the differences between the groups be (the “effect size”) for you to still detect a significant pattern (p < 0.05)?

# commenting out this first method of generating random normal numbers for each genotype separately 
# this set of calls creates individual normal distributions for each variable
# rWT <- rnorm(50,11.8,4.6)
# mean(rWT)  
# sd(rWT)  
# 
# r22 <- rnorm(50,9.6,4.8)
# mean(r22)  
# sd(r22)  
# 
# r93 <- rnorm(50,11.3,4.8)
# mean(r93)  
# sd(r93)  
# 
# r2293 <- rnorm(50,10.1,4.1)
# mean(r2293)  
# sd(r2293)  
# 
# r22R <- rnorm(50,10.9,4.2)
# mean(r22R)
# sd(r22R)  
# 
# r93R <- rnorm(50,10.9,4.3)
# mean(r93R)  
# sd(r93R) 
# 
# # string these into a single vector
# 
# resVar <- c(rWT,r22,r93,r2293,r22R,r93R)
# #head (resVar)
# 
# # associate each response variable with the appropriate genotype, n=50
# rGen <- c(rep("WT", 50), rep("CCDC22", 50), rep("CCDC93", 50), 
#           rep("CCDC22CCDC93", 50), rep("CCDC22RFP", 50), 
#           rep("CCDC93RFP", 50))
# 

# Adjusted Mean 1: Make the data fit the expected model

# Data frame construction for one-way ANOVA
# create a dataframe of random variables

nGroup <- 6 # number of treatment groups
nName <- c("WT","CCDC22", "CCDC93", "CCDC22CCDC93", "CCDC22RFP", "CCDC93RFP") # names of groups
nSize <- c(50,50,50,50,50,50) # number of observations in each group, these are all equal in the simulated dataset
# the mean and variance are estimated using pilot trial numbers

nMean <- c(16,8,8,8,16,16) # adjust the mean of each group
nSD <- c(4.6,4.8,4.8,4.1,4.2,4.3) # leave the standard deviation of each group as estimated by the pilot

# id vector for each row, just numbers each row for organization and/or reference
ID <- 1:(sum(nSize)) 

# create a vector by concatenating six sets of random normal variables
resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]), 
            rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]),
            rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3]), 
            rnorm(n=nSize[4],mean=nMean[4],sd=nSD[4]),
            rnorm(n=nSize[5],mean=nMean[5],sd=nSD[5]),
            rnorm(n=nSize[6],mean=nMean[6],sd=nSD[6]))
# sets up single column with all data, this is now in long form

# create dataframe
TGroup <- rep(nName,nSize)
ANOdata <- data.frame(ID,TGroup,resVar) 
str(ANOdata)
print(ANOdata)

# Run basic ANOVA
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))
z <- summary(ANOmodel)
str(z)
aggregate(resVar~TGroup,data=ANOdata,FUN=mean)
unlist(z)
unlist(z)[7] # F value1 of multiple runs 54.76695 | 45.17885 | 55.38637
ANOsum <- list(Fval=unlist(z)[7],probF=unlist(z)[9])
ANOsum  # Pr(>F)1 of multiple runs 4.354116e-40 | 1.596278e-34 | 1.974105e-40 
# Pr(>F) p-value associated with the F-statistic 
# If Pr(>F) is < 0.05, then at least one of the groups is different 

# Use ggplot to visualize the ANOVA data
ANOPlot <- ggplot(data=ANOdata) + 
  aes(x=TGroup,y=resVar,fill=TGroup) +
  geom_boxplot()
print(ANOPlot)

# Adjusted Mean 2: Does a smaller difference still generate significant values

nGroup <- 6 # number of treatment groups
nName <- c("WT","CCDC22", "CCDC93", "CCDC22CCDC93", "CCDC22RFP", "CCDC93RFP") # names of groups
nSize <- c(50,50,50,50,50,50) # number of observations in each group, these are all equal in the simulated dataset
# the mean and variance are estimated using pilot trial numbers

nMean <- c(10,8,8,8,10,10) # adjust the mean of each group
nSD <- c(4.6,4.8,4.8,4.1,4.2,4.3) # leave the standard deviation of each group as estimated by the pilot

# id vector for each row, just numbers each row for organization and/or reference
ID <- 1:(sum(nSize)) 

# create a vector by concatenating six sets of random normal variables
resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]), 
            rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]),
            rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3]), 
            rnorm(n=nSize[4],mean=nMean[4],sd=nSD[4]),
            rnorm(n=nSize[5],mean=nMean[5],sd=nSD[5]),
            rnorm(n=nSize[6],mean=nMean[6],sd=nSD[6]))
# sets up single column with all data, this is now in long form

# create dataframe
TGroup <- rep(nName,nSize)
ANOdata <- data.frame(ID,TGroup,resVar) 
str(ANOdata)
print(ANOdata)

# Run basic ANOVA
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))
z <- summary(ANOmodel)
str(z)
aggregate(resVar~TGroup,data=ANOdata,FUN=mean)
unlist(z)
unlist(z)[7] # F value1 of multiple runs  3.460314 | 3.057447 | 4.37688 
ANOsum <- list(Fval=unlist(z)[7],probF=unlist(z)[9])
ANOsum  # Pr(>F)1 of multiple runs 0.004699716 | 0.01045411 | 0.0007376741
# Pr(>F) p-value associated with the F-statistic 
# If Pr(>F) is < 0.05, then at least one of the groups is different 

# Use ggplot to visualize the ANOVA data
ANOPlot <- ggplot(data=ANOdata) + 
  aes(x=TGroup,y=resVar,fill=TGroup) +
  geom_boxplot()
print(ANOPlot)


# Adjusted Mean 3: Does an even smaller difference (1mm) still generate significant values

nGroup <- 6 # number of treatment groups
nName <- c("WT","CCDC22", "CCDC93", "CCDC22CCDC93", "CCDC22RFP", "CCDC93RFP") # names of groups
nSize <- c(50,50,50,50,50,50) # number of observations in each group, these are all equal in the simulated dataset
# the mean and variance are estimated using pilot trial numbers

nMean <- c(10,9,9,9,10,10) # adjust the mean of each group
nSD <- c(4.6,4.8,4.8,4.1,4.2,4.3) # leave the standard deviation of each group as estimated by the pilot

# id vector for each row, just numbers each row for organization and/or reference
ID <- 1:(sum(nSize)) 

# create a vector by concatenating six sets of random normal variables
resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]), 
            rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]),
            rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3]), 
            rnorm(n=nSize[4],mean=nMean[4],sd=nSD[4]),
            rnorm(n=nSize[5],mean=nMean[5],sd=nSD[5]),
            rnorm(n=nSize[6],mean=nMean[6],sd=nSD[6]))
# sets up single column with all data, this is now in long form

# create dataframe
TGroup <- rep(nName,nSize)
ANOdata <- data.frame(ID,TGroup,resVar) 
str(ANOdata)
print(ANOdata)

# Run basic ANOVA
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))
z <- summary(ANOmodel)
str(z)
aggregate(resVar~TGroup,data=ANOdata,FUN=mean)
unlist(z)
unlist(z)[7] # F value1 of multiple runs  0.8566817 | 2.737496 | 2.725934
ANOsum <- list(Fval=unlist(z)[7],probF=unlist(z)[9])
ANOsum  # Pr(>F)1 of multiple runs 0.5106597 | 0.01953694 | 0.01997955
# Pr(>F) p-value associated with the F-statistic 
# If Pr(>F) is < 0.05, then at least one of the groups is different 

# Use ggplot to visualize the ANOVA data
ANOPlot <- ggplot(data=ANOdata) + 
  aes(x=TGroup,y=resVar,fill=TGroup) +
  geom_boxplot()
print(ANOPlot)
























###########################################################
# A bunch of code that didn't end up doing anything...ever
###########################################################
# regData <- data.frame(resVar,)
# head(regData)
# str(regData)
# 
# resVar <- c(r1,r2,r3,r4,r5,r6)
# # sets up single conlumn with all data, this is long form
# # 
# # Organize these data into a data frame with the appropriate structure
# # Is this what I am doing here?
# # model
# regModel <- lm(myVar~varB,data=regData) # runs ANOVA
# 
# # model output
# regModel # printed output 
# str(regModel) # complicated, but has "coefficients"
# head(regModel$residuals) # contains residuals
# 
# # 'summary' of model
# summary(regModel)
# summary(regModel)$coefficients
# str(summary(regModel))
# 
# # better to examine entire matrix of coefficients
# summary(regModel)$coefficients[] 
# 
# # an unfurl this into a 1D atomic vector with names
# z <- unlist(summary(regModel))
# str(z)
# z$coefficients7
# 
# # Bundle everything I need into a list raher than asking for each separately
# # I think this is just pulling specific metrics out of a statistical model
# 
# regSum <- list(intercept=z$coefficients1,
#                slope=z$coefficients2,
#                interceptP=z$coefficients7,
#                slopeP=z$coefficients8,
#                r2=z$r.squared)
# 
# # easier to use and query regSum than deal with each separately
# print(regSum)
# regSum$r2
# regSum[[5]]
# 
# #### Basic ggplot of regression model
# # Use ggplot function to create a model
# # ggplot must only use a dataframe
# # Pieces of the function van be broken up and combined with the addition sign
# 
# print(myVar)
# print(varB)
# 
# regPlot <- ggplot(data=regData) +
#   aes(x=myVar,y=varB) +
#   geom_point() +
#   stat_smooth(method=lm,se=0.50) 
# 
# # default se=0.95
# # all of the above pieces are being put in the object regPlot
# 
# ################
# ## Not working?
# print(regPlot)
# ###############
# 
# # Make Data frame for one-way ANOVA
# nGroup <- 6 # number of treatment groups
# # names of groups
# nName <- c("WT","CCDC22", "CCDC93", "CCDC22CCDC93", "CCDC22RFP", "CCDC93RFP") 
# 
# nSize <- c(50,50,50,50,50,50) # number of observations in each group, don't often have equal
# # before you run an experiment, you should have an estimate of mean and variance before starting
# 
# nMean <- c(40,41,60) # mean of each group
# nSD <- c(5,5,5) # standard deviation of each group, just making this up, mighyt not actually all be equal
# 
# ID <- 1:(sum(nSize)) # id vector for each row, all all observations up to give us the number of observations
# resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]), 
#             rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]),
#             rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3]))
# # sets up single conlumn with all data, this is long form
# 
# TGroup <- rep(nName,nSize)
# ANOdata <- data.frame(ID,TGroup,resVar) # create dataframe, don't need ID here, but this is a good habit
# str(ANOdata)
# print(ANOdata)

