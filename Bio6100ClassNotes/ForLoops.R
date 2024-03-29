# Introduction to for Loops
# 21 March 2024
# NRG


##########
# FOR LOOPS
##########

# the workhouse function for doing repetitive tasks
# universal in all computer languages
# Controversial in R

# often not necessary (use vectorized operations)
# very slow with binding operations (c,rbind,cbind,list)
# many operations

#anatomy of a for loop

#for(var in seq) { #start of for loop

  # body of for loop, integer sequence

 # } # end of for loop

#var is a counter variable that will hold the current value of the loop
#seq is an integer vector (or a vector of character strings) that defines the starting and ending values of the loop
# naming conventions
# when you specify value for var, use i, j, k
# comes from statistical conventions
# makes sure the code is readable, important for nesting
# avoid using t for time bc it is an R function
#repeatedly carry out a function on an atomic vector

for (i in 1:5) {
  cat("stuck in a loop","\n")
  cat(3 + 2,"\n")
  cat(runif(1),"\n")
}
# loop above includes standard R functions
# cat print character strings, prints results, \n is a line return
# do 5 times in a row bc of the length of the loop
# third element in loop is the thing that changes for each iteration
#It is traditional in the statistics literature to use variables i,j,k to indicate counters


print(i)
## [1] 5

#Instead, we want to use a counter variable that maps to the position of each element

my_dogs <- c("chow", "akita", "malamute", "husky","samoyed")
for (i in 1:length(my_dogs)){
  cat("i=",i,"my_dogs[1] =" ,my_dogs[i], "\n")
}
#increases the value of i for each iteration of the loop

#This is the typical way we make a loop. One potential hazard is if the vector we are working with is empty
# be careful that the vector is specified
# does not throw an error, but likely a mistake....vector is "empty"
my_bad_dogs <- NULL
for (i in seq_along(my_dogs)){
  cat("i=",i,"my_dogs[i] =", my_dogs[i], "\n")
}

# instead do this
#So, a safer way is to use seq_along function:
for (i in seq_along(my_dogs)){
  cat("i=",i,"my_bad_dogs[1] =" ,my_dogs[i], "\n")
}

#But notice now what happens when the vector is empty:
# This time we correctly skip my_bad_dogs and do not make the loop
for (i in seq_along(my_bad_dogs)){
  cat("i =",i,"my_bad_dogs[i] =" ,my_bad_dogs[i],"\n")
}
#try it with a vector that has a missing value
my_bad_dogs <- NA
for (i in seq_along(my_dogs)){
  cat("i=",i,"my_bad_dogs[1] =" ,my_dogs[i], "\n")
}

#Alternatively, we may have a constant that we use to define the length of the vector:
zz <- 5
for (i in seq_len(zz)){
  cat("i=",i,"my_bad_dogs[1] =" ,my_dogs[i], "\n")
}

#IMPORTANT TIP#1: Dont do things in a loop if you dont have to
for (i in 1:length(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i])
  cat("i=",i,"my_dogs[1] =" ,my_dogs[i], "\n")
}

my_dogs <- tolower(my_dogs)
print(my_dogs)


#IMPORTANT Tip #2: Do not change object dimensions (cbind,rbind,c,list) in the loop!
# dont resize objects inside of a for loop

my_dat <-runif(1)
for (i in 2:10){
  temp <- runif(1)
  my_dat <- c(my_dat,temp) # do not change vector size in loop
  cat("loop number =",i,"vector element=",my_dat[i], "\n")
}
print(my_dat)

#IMPORTANT Tip #3: Do not write a loop if you can vectorize an operation
#always vectorize when you can instead of looping

my_dat <- 1:10
for (i in seq_along(my_dat)) {
  my_dat[i] <-  my_dat[i] + my_dat[i]^2
  cat("loop number =",i,"vector element =", my_dat[i],"\n")
}

# No loop is needed here!
z <- 1:10
z <- z + z^2
print(z)

#IMPORTANT Tip #4: Always be alert to the distinction between the counter variable i and the vector element z[i]
z <- c(10,2,4)
for (i in seq_along(z)) {
  cat("i=",i,z[i],"\n")
}
################

z <-1:20
#what if we want to work with only the odd-numbered elements?
for (i in seq_along(z)){
  if(i %% 2==0) next
  print(i)
}

# What is value of i at this point?
print(i)

#IMPORTANT Tip #5: Use next to skip certain elements in the loop

z <- 1:20
# What if we want to work with only the odd-numbered elements?
for (i in seq_along(z)) {
  if(i %% 2==0) next
  print(i)
}

# another method, probably faster (why?)
z <-1:20
zsub <- z[z %% 2!=0] # contrast with logical expression in previous if statement!
length(z)

for (i in seq_along(zsub)) {
  cat("i = ",i,"zsub[i] = ",zsub[i],"\n")
}

/Bio381/Lectures/ForLoops_I.html

# use break to set up a conditional break out of loop early

# create a simple random growth population
###############################################################################
#FUNCTION: ran_walk
#stochastic random walk
#input: times = number of time steps
#      n1 = initial population size
#.



################################################################################
# functions should have a max of 4 "things"
# if more should break up

ran_walk <-function(times=100,n1=50,lambda=1.00,noise_sd=10) {
  n <- rep(NA,times) #create output vector, local variable n, only exists in function
  n[1] <- n1 #initialize with starting population size, plug in very first value (n1=50), only exists in function
  noise <- rnorm(n=times,mean=0,sd=noise_sd) #create noise vector
  for(i in 1:(times-1)) {
    n[i + 1] <- lambda*n[i] + noise[i]
  if(n[i + 1] <=0) {
    n[i+1] <- NA
    cat("Population extinction at time",i-1, "\n")
    break} # stops the entire for loop
}

  return(n)
}

library(ggplot2)
qplot(x=1:100,y=ran_walk(noise_sd=0,lambda=0.98),geom="line")


#################################
# Extensions of the model for realistic populations
#################################
# discrete integers to represent counts of individuals (use round())
# check notes
#
#

############
# Using Round For Loops
##########

m <- matrix(round(runif(20), digits=2),nrow=5)
# loop over rows
for (i in 1:nrow(m)) { # could use for (i in seq_len(nrow(m)))
  m[i,] <- m[i,] + i
}
print(m)

# Loop over cols
m <- matrix(round(runif(20), digits=2),nrow=5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# double for loop
# put the things above together
m <- matrix(round(runif(20), digits=2),nrow=5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
  m[i,j] <- m[i,j] + i + j
  } # end of col j loop
} # end of row i loop
print(m)

###############################################
# Writing functions for equations and sweeping over parameters
###############################################

#s = cA^z species are function, but what does it look like

###############################################
# function : species_area_plot
# creates power function relationship for S and A
# input: A is a vector of island areas
#        c is the intercept constant
#        z is the slope constant
#output: S is a vector of species richness values
#______________________________________________
species_area_curve <- function(A=1:5000,c= 0.5, z=0.26){

  S <- c*(A^z)
  return(S)
}
head(species_area_curve())

###############################################
# function : species_area_plot
# creates power function relationship for S and A
# input: A is a vector of island areas
#        c = single value for c parameter
#        z = single value for z parameter
#output: smoothed curve with parameters in graph
#______________________________________________

species_area_plot <- function(A=1:5000,c= 0.5, z=0.26){
  plot(x=A,y=species_area_curve(A,c,z),type="l",xlab="Island Area",ylab="S",ylim=c(0,2500))
  mtext(paste("c=", c," z=",z),cex=0.7)
  #.      return()
}
species_area_plot()

####
# Now build a grid of plots
####

# global variables
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)
par(mfrow=c(3,4))
for (i in seq_along(c_pars)){
  for (J in seq_along(z_pars)) {
    species_area_plot(c=c_pars[i],z=z_pars[i])
  }
}

#only bc working in base R
par(mfrow=c(1,1))

#######
# Looping with while or repeat
#######

#...don't use
# get notes from online link
#
#
#
#
#

# Using the expand.grid()
# important , use vectors, creates a dataframe

expand.grid(c_pars,z_pars)
# runs function

expand.grid(c_pars=c_pars,z_pars=z_pars)
# running function to name each of the variables

str(expand.grid(c_pars=c_pars,z_pars=z_pars))
# this is a dataframe!
# now don;t have to write a double for loop

#######################################################
# function: sq_output
# Summary stats for species-area power function
# output: list of max-min, coefficient of variation
#_______________________________________________________
sa_output <- function(S=runif(1:10)) {

  sum_stats <- lists(s_gain=max(s)-min(S))

  return(sum_stats)
}

# Global variables
area<- 1:5000
c_pars<- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

model_frame <-expand.grid(c=c_pars,z=z_pars)
model_frame$s_gain <- NA
model_frame$s_cv<-NA
print(model_frame)

  sa_output()

# cycle through model calculations
  for (i in 1:nrow(model_frame)) {

    # generate S vector
    temp1 <- species_area_curve(A=area,
                                c=model_frame[i,1],
                                z=model_frame{i,2})

# calculate output stats
    temp2 <- sa_output(temp1)
    # pass results to columns in data frames
    model_frame[i,c(3,4)] <- temp2
  }

print(model_frame)

######
# Parameters sweeping redux with ggplot graphics

library(ggplot2)

area <- 15 # keep this small initially
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

# set up model frames
model_frame <- expand.grid(c=c_pars,z=z_pars,A=area)
model_frams$S <- NA

# loop through parameters and fill with SA function

for (i in 1:length(c_pars)) {
  for (j in 1:length(z_pars))
    model_frame[model_frame$c==c_pars[i] & model_frame$z==z_pars[j],"S")) <- species_area_curve(A=area,c=c_pars[i],z=z_pars[j])
  }
}

for (i in 1:nrow(model_frame))  {
  model_frame[i,"S"] <- species_area_curve (A=model_frame,
                                            c= model_frame$c[i],
                                            z=model_frame)$z[i]
}

####### miising code chunk here

## Class notes 28 March
library(ggplot2)

p1 <- ggplot(data=model_frame)
# p1 + geom_point(mapping= aes(x=A,y=S))
p1 + geom_line(mapping= aes(x=A,y=S)) +
facet_grid(c~z)
# returns multi-pane graph, can plot 4 dimensions of data

p2 <- p1
p2 + geom_line(mapping=aes(x=A,y=S,group=z)) +
  facet_grid(.~c)
# period is part of the ggplot language

p3 <- p1
p3 + geom_line(mapping=aes(x=A,y=S,group=c)) +
  facet_grid(z~.)
# flips from col to row arrangement


