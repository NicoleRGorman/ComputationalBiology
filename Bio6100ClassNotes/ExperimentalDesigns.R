# Experimental Designs
# 27_Fe_2024

# Archetype Experimental Designs
# independent versus dependent variables
# discrete versus continuous variables
# continuous variables (integer and real)
# direction of cause and effect, x axis is independent
# continuous versus discrete (natural or arbitrary or statistical bins)

# Regression (dependent: continuous, independent: continuous)
# linear model of y=a+bx
# statistical tests for null of hypothesis of slope and/or intercept = 0
# confidence and prediction intervals of uncertainty
# goodness of fit tests for linearity

library(tidyverse)

n = 50  # number of observations (rows)


varA <- runif(n) # random uniform values (independent)
varB <- runif(n) # a second random column (dependent)
varC <- 5.5 + varA*10 # a noisy linear relationship with varA
ID <- seq_len(n) # creates a sequence from 1:n (if n > 0!)
regData <- data.frame(ID,varA,varB,varC)
head(regData)
str(regData)

# model
regModel <- lm(varB~varA,data=regData) #runs anova for us?

# model output
regModel # printed output is sparse
str(regModel) # complicated, but has "coefficients"
head(regModel$residuals) # contains residuals

# 'summary' of model has elements
summary(regModel) # 
summary(regModel)$coefficients
str(summary(regModel))

# best to examine entire matrix of coefficients:
summary(regModel)$coefficients[] #shows all

# can pull results from this, but a little wordy
summary(regModel)$coefficients[1,4]   #p value for intercept
summary(regModel)$coefficients["(Intercept)","Pr(>|t|)"] # uggh


# alternatively unfurl this into a 1D atomic vector with names
z <- unlist(summary(regModel))
str(z)
z
z$coefficients7

# grab what we need and put into a tidy list
# Bundle everything into a list so don't need a bunch of different things
# Below are the typical things you want
# Need to do what was above to figure out which coefficients are which, will be different depending on your model. When you add or change anything, it will change
# I think this is really just pulling specific metrics out of a statistical model

regSum <- list(intercept=z$coefficients1,
               slope=z$coefficients2,
               interceptP=z$coefficients7,
               slopeP=z$coefficients8,
               r2=z$r.squared)

# much easier to query and use
print(regSum)
regSum$r2
regSum[[5]]

#### Basic ggplot of regression model
# Use ggplot function to create a model
# ggplot must only use a dataframe
# Pieces of the function van be broken up and combined with the addition sign

regPlot <- ggplot(data=regData) +
  aes(x=varA,y=varB) +
  geom_point() +
  stat_smooth(method=lm,se=0.50) # default se=0.95, this is the default, but here it is set at 0.99, ggplot makes some additional calculations in this step
# all opf gthe above pieces are being put in the object regPlot

print(regPlot)
# ggplot recognizes print and will render the graph

# Use the following command to save the plot rather than just grabbing from image viewer
# Better for outputting final image
# All about being reproducable
# ggsave(filename="Plot1.pdf",plot=regPlot,device="pdf")

# consider regression approach with experimens
# ofte use ANOVA, but can also use regression of replication is cost porohititve

########
# Data frame construction for one-way ANOVA
#######
nGroup <- 3 # number of treatment groups
nName <- c("Control","Treat1", "Treat2") # names of groups
nSize <- c(12,17,9) # number of observations in each group, don't often have equal
# before you run an experiment, you should have an estimate of mean and variance before starting

nMean <- c(40,41,60) # mean of each group
nSD <- c(5,5,5) # standard deviation of each group, just making this up, mighyt not actually all be equal

ID <- 1:(sum(nSize)) # id vector for each row, all all observations up to give us the number of observations
resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]), 
            rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]),
            rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3]))
# sets up single conlumn with all data, this is long form

TGroup <- rep(nName,nSize)
ANOdata <- data.frame(ID,TGroup,resVar) # create dataframe, don't need ID here, but this is a good habit
str(ANOdata)
print(ANOdata)

#############
## Basic ANOVA in R
#############

ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))
z <- summary(ANOmodel)
str(z)
aggregate(resVar~TGroup,data=ANOdata,FUN=mean)
unlist(z)
unlist(z)[7]
ANOsum <- list(Fval=unlist(z)[7],probF=unlist(z)[9])
ANOsum

# aggregate function pulls things out of the structure

#############
# Basic ggplot of ANOVA data
#############

ANOPlot <- ggplot(data=ANOdata) + 
  aes(x=TGroup,y=resVar,fill=TGroup) +
  geom_boxplot()
print(ANOPlot)
# ggsave(filename="Plot2.pdf",plot=ANOPlot,device="pdf")
# fill command allows us to fill the shape, it is part pf aesthetic mapping

########
# Data frame construction for logistic regression
########

xVar <- sort(rgamma(n=200,shape=5,scale=5)) # just randomly creating a model
yVar <- sample(rep(c(1,0),each=100),prob=seq_len(200)) # just randomly creating a model
lRegData <- data.frame(xVar,yVar)

########
# Logistic regression analysis in R
########

lRegModel <- glm(yVar ~ xVar,
                 data=lRegData,
                 family=binomial(link=logit))
summary(lRegModel)
summary(lRegModel)$coefficients
# glm = general inear model, rather than just an lm (linear model function)

#############
#  Basic ggplot of logistic regression
##############

lRegPlot <- ggplot(data=lRegData) + 
  aes(x=xVar,y=yVar) +
  geom_point() +
  stat_smooth(method=glm, method.args=list(family=binomial))
print(lRegPlot)

###############
# Data for contingency table analysis
###############
# this is the least used analysis

# integer counts of different data groups
vec1 <- c(50,66,22)
vec2 <- c(120,22,30)
dataMatrix <- rbind(vec1,vec2)
rownames(dataMatrix) <- c("Cold","Warm")
colnames(dataMatrix) <-c("Aphaenogaster",
                         "Camponotus",
                         "Crematogaster")
str(dataMatrix)
print(dataMatrix)

# predictor variables are vec1 and vc2...these would be treatments
# column names are response variable

#################
# Basic contingency table analysis in R
#################

print(chisq.test(dataMatrix))
# this is just a chi square
# built into R

#################
# Plotting contingency table analyses
#################

# there is likely a pakage that does this now, but this is how you would do it in base R
# some simple plots using baseR
mosaicplot(x=dataMatrix,
           col=c("goldenrod","grey","black"),
           shade=FALSE)
barplot(height=dataMatrix,
        beside=TRUE,
        col=c("cornflowerblue","tomato"))
# bar plot is more traditional, but the mosaic is helpful for looking at proportions

dFrame <- as.data.frame(dataMatrix)
dFrame <- cbind(dFrame,list(Treatment=c("Cold","Warm")))
dFrame <- gather(dFrame,key=Species,Aphaenogaster:Crematogaster,value=Counts) 

p <- ggplot(data=dFrame) + 
  aes(x=Species,y=Counts,fill=Treatment) + 
             geom_bar(stat="identity",position="dodge",color=I("black")) +
  scale_fill_manual(values=c("cornflowerblue","coral"))
print(p)

# coercing a matrix into a datafram
# bind on a column that is going to add labels
# dodge puts the bars on top of each other
# not that much better....mosaic is really the best/better thank bar graph
