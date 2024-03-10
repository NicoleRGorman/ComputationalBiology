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
my_func <- f

