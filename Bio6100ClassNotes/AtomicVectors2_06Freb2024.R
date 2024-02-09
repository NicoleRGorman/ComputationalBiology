# Atomic vectors II
# 06 february 2024
# NRG

# create an empty vector, specify mode and length
z <- vector(mode="numeric",length=0)
print(z)

z <-c(z,5)
print(z)
# This "dynamic sizing" is VERY SLOW....so don't do it unless no other option

# has 100 0s in a numeric vector
z <- rep(0,100)
length(z)
head(z)
tail(z)

z[c(50,51,52)]

# preferred way to build a vector, better to start with NAs
z <- rep(NA,100)
head(z)

# what type of variable is this?
typeof(z)

# need to rely on coersion
z[1] <- "washington"
head(z)
typeof(z)

# Efficiently create vectors

#using the sequence function, and the paste function 
# ****** DID NOT WORK????
# can add an underscore or whatever between the quotes
my_vector <- runif(100)
my_names <- paste("Genus",seq(1:length(my_vector)),
                  "species", 
                  sep="")
head(my_names)
names(my_vector) < my_names
head(my_vector)
str(my_vector)

# rep for repeating elements
rep(0,5,6) #give the element (or vector) and number of times to repeat
rep(x=0,5,times=5) #using the argument name is always prudent
rep(times=6,x=0.5) #which argument names, order is not important
my_vec <- c(1,2,3)
rep(x=my_vec,times=2) # number applies to entire vector
rep # repeat each element individually
rep(x=my_vec,times=my_vec) # what does this do?
rep(x=my_vec,each=my_vec) # what about this?
rep(x=my_vec,each=c(3,2,1)) # what about this?

# Using seq
seq(from=2, to=1) #set limits for integer sequences
2:4 # very common short cut with no explicit function wrappers
seq(from=2,to=4,by=0.5) #use a by function can generate real numbers
x <- seq(from=2, to=4,length=7) #sometimes easier to just specify length
my_vec <- 1:length(x) # commonly used, but actually slow
print(my_vec)
seq_along(my_vec)
# this is also faster than 1:5 
# much faster for models and big data
seq_len(5) 

#using random number generators
#explore
set.seed(2400) 
runif(5) # 5 random uniform values between 0 and 1
runif(n=3, min=100, max=101) # 3 random uniform values between 100 and 101

rnorm(6) # 6 random normal values with mean 0 and standard deviation 1
rnorm(n=5, mean=100, sd=30) # 5 random normal values with mean 100 and sd 30

#Explore distributions by sampling and plotting
library(ggplot2) #do this at the very start
z <- runif(1000) #default uniform (0,1)
qplot(x=z)
z <- rnorm(1000) #default normal (0,1)
qplot(x=z)

long_vec <- seq_len(10)
typeof(long_vec)
str(long_vec)

sample(x=long_vec) #with no other params, this reorders the vector, no other changes, =s not saved this way, would do this with an +
sample(x=long_vec, size=3) # specify a number (sampling without replacement)
sample(x=long_vec, size=11) # Can't do bc sampling wo replacement, run out of options...need replacement
sample(x=long_vec, size=16,replace=TRUE) #can generate duplicates
# above is even sampling from all
# sometimes want to sample some elements more than others
my_weights <- c(rep(20,5),rep(100,5))
print(my_weights)
my_weights <- c(rep(c(20,500),each=5))# Can also write it this way
print(my_weights)
my_weights <- c(rep(c(20,500),each=5))
my_weights <-c(100,100,100,500,100,100,100,100,100,100)
print(my_weights)
sample(x=long_vec,replace=TRUE,prob=my_weights) #sampling with reaplcement and weights
# almost all n umbers are greater than 5, weighted sampling

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)

#positive index values
z[c(2,3)]

# negative index values exclude elements
sample(z[-c(2,3)])

#create a vector of logical elements to select conditions

z[z<3]

tester <- z<3
print(tester)
z[tester]

which(z<3)

z[which(z<3)] # this is the same as above, but overkill

z[-(length(z):(length(z)-2))]

names(z) <- letters[1:5]
names(z) <- LETTERS[1:5]
#z[c("b","c")]
z

#Logical Operators

# < less than
# > greater than
# <= less than or equal to
# >= greater than or equal to
# == equal to

# ! not
# & and (vector)
## | or (vector)
# xor(x,y)

x <- 1:5
y <- c(1:3,7,7)

x == 2
x != 2
x == 1 & y == 7
x
y
y_special <- c(y,7)
x == 1 & y_special == 7
x==1 | y ==7
x
y
x ==3 | y ==3
xor(x==3, y==3)

set.seed(90)
z <- runif(10) # simple integer sequence
print(z)

z < 0.5 # create logical vector
z[z < 0.5] # use as index call
which(z < 0.5) # use to get indicies for logical
z[which(z < 0.5)] # does same as above

zD <- c(z,NA,NA) # concatinate it
zD[zD < 0.5] # NA values carried along!
zD[which(zD < 0.5)] # NA values dropped


