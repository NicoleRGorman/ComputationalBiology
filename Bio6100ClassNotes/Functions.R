# Functions
# 27_February_2024
# NRG

#################
#Part 1: Online lecture
################

# load library
library(ggplot2)

# everything in R is a function

sum(3,2) # a "prefix" function
3 + 2 # an "operator", but it is actually a function
`+`(3,2) # the operator is an "infix" function

y <- 3
print (y)
`<-` (yy,3) # another "infix" function

# to see the contents of a function, print it
print(read.table)

# three different ways to call (approach) a function
# 1. print the function
sd # prints the contents of function
# 2. calling function with inputs
sd(c(3,2)) # function calling another function, calling data, calls function with parameters
# 3. Call with no inputs for defaults
sd() #call function with default parameters, does not work iof function needs data inputs

#################
#Part 2: Online lecture
################

#################################################################
# FUNCTION h_weinberg
# calculates Hardy-Weinberg equilibrium values
# input: an allele frequency p (0,1)
# output : p and the frequencies of the three genotypes AA, AB, BB
#----------------------------------------------------------------
h_weinberg <- function(p=runif(1)) {
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA,AB=f_AB,BB=f_BB),
                    digits=3)
  return(vec_out)
}
#################################################################

h_weinberg() # try with default values
# go into console and then use up arrow and return several times to test function with default values
h_weinberg(p=0.05) # pass value to the input
print(p) # not found because p is a local variable inside function
pp <- 0.6
h_weinberg(p=pp)
print(pp)
p <- 0.7 # this is a global variable, so can use as a parameter
h_weinberg(p=p)

# can write functions with multiple return values

#################################################################
# FUNCTION h_weinberg2
# calculates Hardy-Weinberg equilibrium values
# input: an allele frequency p (0,1)
# output : p and the frequencies of the three genotypes AA, AB, BB
#----------------------------------------------------------------
h_weinberg2 <- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    return("Function failure: p must be >= 0 amd <= 1.0")
  } # end of if statement
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA,AB=f_AB,BB=f_BB),
                    digits=3)
  return(vec_out)
} # end of h_weinberg function
#################################################################

h_weinberg() # first run with default
h_weinberg2(1.1) # OK gives message
z <- h_weinberg2(1.10) # hmmmm, no error message
print(z) # ugh, z contains the message


#################
#Part 3: Online lecture
################

# programming for errors
# do not necessarily need if not intending to distribute code
# can make code difficult to read

# proper call for error trapping is the stop function
# do not use multiple return statement
#################################################################
# FUNCTION h_weinberg3
# calculates Hardy-Weinberg equilibrium values
# input: an allele frequency p (0,1)
# output : p and the frequencies of the three genotypes AA, AB, BB
#----------------------------------------------------------------
h_weinberg3 <- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    stop("Function failure: p must be >= 0 amd <= 1.0")
  } # end of if statement
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA,AB=f_AB,BB=f_BB),
                    digits=3)
  return(vec_out)
} # end of h_weinberg function
#################################################################

zz <- h_weinber3(1.1)
print(zz) # Good! No object which means program terminated in the correct way

## Scoping Rules
# explore scoping and local variables
my_func <- function(a=3,b=4){
  z <- a + b
  return(z)
}
my_func()


my_func_bad <- function (a=3){
  z <- a + b
  return(z)
}
my_func_bad()
# Error in my_func_bad() : object 'b' not found
b <- 100
my_func_bad() # runs because b is in global, but this is NOT good

# fine to create variables locally

my_func_OK <- function(a=3){
  bb <-100
  z <- a + bb
  return (z)
}
my_func_OK()
# commenting out call immediately following so will knit in the Rmd file
# print(bb)
# not found because bb lives inside function

#################
#Part 4: Online lecture
################

###########################################################
# FUNCTION fit_linear
# fits a simple linear regression line
# inputs: numeric vector of predictor(x) and response(y)
# outputs: slope and p-value
#---------------------------------------------------------
fit_linear <-function(x=runif(20),y=runif(20)) {
  my_model <- lm(y~x)
  my_out <- c(slope=summary(my_model)$coefficients[2,1],
              pval=summary(my_model)$coefficients[2,4])
  #plot(x=x,y=y) #quick and dirtly plot to check output
  z <- ggplot2::qplot(x=x,y=y)
  plot(z)
  return(my_out)
}
###########################################################
fit_linear()

###########################################################
# FUNCTION fit_linear2
# fits a simple linear regression line
# inputs: numeric vector of predictor(x) and response(y)
# outputs: slope and p-value
#---------------------------------------------------------
fit_linear2 <-function(p=NULL) {
  if(is.null(p)) {
    p <- list(x=runif(20),y=runif(20))
  } # end of input NULL case
  my_model <- lm(p$y~p$x)
  my_out <- c(slope=summary(my_model)$coefficients[2,1],
              pval=summary(my_model)$coefficients[2,4])
  #plot(x=x,y=y) #quick and dirtly plot to check output
  z <- ggplot2::qplot(x=p$x,y=p$y)
  plot(z)
  return(my_out)
}
###########################################################
fit_linear2()
my_pars <- list(x=1:10,y=runif(10))
fit_linear2(my_pars)

z <- c(runif(99),NA) # 99 values with an NA

# go to help to explore parameters of mean
mean(z) # doesn't work if NA is present
mean(z,na.rm=TRUE) # change default value!
mean(z,na.rm=TRUE,trim=0.05) # throws out extreme values, trims 5% of the tails
my_pars <- list(x=z,na.rm=TRUE,trim=0.05)
do.call(mean,my_pars) # works for a function and a list of parameters


