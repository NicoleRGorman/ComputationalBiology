# Using the assignment operator
x <- 5 # preferred
y = 4 # Legal but not used except function default
y = y + 1.1
print(y)
y<-y+1.1
print(y)


##Variable Names

z <- 3 #Begin with lower case letter
plantHeight <- 10 # optin "camelCaseFormatting"
plant.height <- 4.2 # avoid periods
plant_height <- 3.3 # optimal "snake_case_formatting"
. <- 5.5 # reserve this for a general temporary name, will talk about this later

#R's Four Data Types

# Dimensions
# 1-dimension = atomic vector
# 2-dimensions = matrix
# n-dimensions = array, don;t use this very often

# Data frame = heterogenous in 2-dimensions

# Types of atomic vecotors

# CS = letters, nums, etc....has to be bracketed by single or double quotes, green in code
# Numerical values, integers = don;t need to worry
# logicals = very important for efficient coding
# (factor) = use this during stats analysis
# vector of lists = important for ....not sure


# One dimensional Atomic Vectors

z <- c(3.2,5,5,6) #c is combine function
print(z)
typeof(z) #query object
is.numeric(z) #gives it an object, evaluates whether numeric?

# c() always "flattens" to an atomic vector
# need to read from inside out
z <-c(c(3,4),c(5,6))
print(z)

#Build character strings
z <-c("perch","bass","trout")
print(z)

#Use both with an internal quote
z <-c("This is the only 'one' character string", 'a second')
print(z)
typeof(z)
is.character(z)

#Building locals
#Boolean, not with quotes, all caps
z <- c(TRUE,TRUE,FALSE)
# avoid abbreviations T, F which will work
print(z)
typeof(z)
is.logical(z)
is.integer(z)

# vector of character strings
dogs <-c("chow","pug","beagle","greyhound","akida")

#use number in brackets to refer to a single element in vecotor, First slot is "1"
dogs[1] # picks first element
dogs[2] # picks last element
dogs[3] # NA, but not an error

#pass the brackets a group of elements (= a vector) to subset the vector
dogs[c(3,5)]

#works with multiple repeats
dogs[c(1,1,1,4)]
my_dogs <-c(1,4)
dogs[my_dogs]

#Very Useful
# grab the entire list by leaving the brackets empty, this grabs everything
dogs[]

# pass function to calculate the element needed
length(dogs)
dogs[2]
dogs[length(dogs)]

# use negative numbers to EXCLUDE elements
# Take the vector but take out an element
dogs[-1]

# ok to use multiple negations
dogs[c(-2,-4)]
dogs[-c(2,4)]

#can't mix positive and negative elements in brackets
# dogs[c(1,-5)]

z <- c(1.1, 1.2, 3, 4.4)
typeof(z) # gives type
is.numeric(z) # is. gives logical
as.character(z) # as. coerces variable
print(z)
typeof(z)

length(z) #gives number of elements
length(y_not) # throws error variable does not exist, then you know you need to go back and create

z <- runif(5)
print(z)
#optional attribute not initiall assigned
names(z)
print(z)
#add names later after variable in crteated
names(z) <- c("chow","pug","beagle","greyhound","akida")
print(z)

# add names when variable is build (ith or without quotes)
z2 <- c(gold=3.3, silver=10, lead=2)
print(z)

# can reset names
names(z2) <- NULL

# names can be added for only a few elements
# names do not have to be distinct, but often are
names(z2) <-c("copper","zinc")
print(z2)
names(z2) <-c("copper", NA, "lead")
print(z2)

#NA values for missing data
z <- c(3.2,3.3,NA) # NA missing value
typeof(z)
length(z)
typeof(z[3]) #what is the type of third element

z1 <- NA
typeof(z1) # different NA types

is.na(z) # logical operator to find missing values
mean(z) # won't bc of NA
is.na(z) # evaluate to find missing values
!is.na(z) # use ! for NOT missing values
mean(!is.na(z)) # wrong answer based on TRUE FALSE!! This is the wrong way to do it!!!
mean(z[!is.na(z)]) # correct use of indexing...use this instead, structure is different

# Nan -Inf and Inf from numeric division
z <- 0/0 #NaN
typeof(z)
z<- 1/0 # Inf
print(z)
-1/0 # -Inf


#NULL is an object that is nothing!
# a reserved word in R
z<- NULL
typeof(z)
length(z)
is.null(z)
 #only operatiopn that works on a null

# All atomics are of the same type
# if they are different, R coerces them
# logical -> integer -> double -> character

a <- c(2, 2.0)
print(a)
typeof(a) #technicaly integer coerced to numeric


b<- c("purple", "green")
typeof(b)

d <- c(a,b)
print(d)
typeof(d)

# "Mistakes" in numeric variable convert to strings
# very useful when working with logical variables

a <- runif(10)
print(a)

# Conparison operators yield a logical result

a > 0.5

# do math on a logical and it coerves the integer

# how many elements are greater than 0.5?
sum(a > 0.5)

#What proprtion of the vecotor elements are gtreater than 0.5?
mean(a > 0.5)

# Break dow the result, period is a place holder

. <- a > 0.5
print(.)
. <- as.integer(.)
print(.)
print(sum(.))
print(mean(.))
 
#Qualifying exam question! Aproximately what proprtion of observations drawn from a normal (0,1) distribution are larger than 2.0?

mean(rnorm(1000) > 2)
print(sum(.))
print(mean(.))

# adding a constant to a vector
z <- c(10,20,30)
z + 1

#What happens when vecors are added?
y <- c(1,2,3)
z + y

# results is an "element by element" operation of the ector
# most vector operations can be dome this way
z^2

# Recycling
# But what if vectors are not equal in length?
# Give a warning just bc vectors are of different lengths, but ok if that's what you are rtrying to do
 z <-c(10,20,30)
 x <- c(1,2)
 z + x
 