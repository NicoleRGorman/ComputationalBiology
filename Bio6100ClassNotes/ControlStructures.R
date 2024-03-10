# if statements and other control structures
# 7 March 2024
# NRG

5 > 3 # Boolean
# [1] TRUE
5 > 3 | 5 < 3 # pipe is the `or` operator
# [1] TRUE
5 > 3 & 5 < 3
# [1] FALSE because using the and operator

##################################
# Set Operations

# boolean algebra on sets of atomic vectors (logical, numeric, character strings)

a <- 1:7
b <- 5:10

# union to get all elements
union (a,b)
#  [1]  1  2  3  4  5  6  7  8  9 10
# different than concatinate function
c(a,b)
# [1]  1  2  3  4  5  6  7  5  6  7  8  9 10

# does the same thing as union, except can do it with a single vector
unique(c(a,b))

# intersect to get common elements
intersect(a,b)

# setdiff to get distinct elements in a
# order matters for setdiff, but not for any of the others above
setdiff(a,b)
# [1] 1 2 3 4
setdiff(b,a)
# [1]  8  9 10

# setequal to check for identical elements
setequal(a,b)

# more generally, to compare any two objects
z <-matrix(1:12,nrow=4,byrow=TRUE)
z1 <-matrix(1:12,nrow=4,byrow=FALSE)

z
z1

# this just compares element by element
z==z1

# Use identical for entire structures
identical(z,z1)
z1 <- z
identical(z,z1)

# most useful for if statements is %in% or is.element
# these two are equivalent, but I prefer the %in% for readability
d <- 12
d %in% union(a,b)
is.element(d,union(a,b))

# check for partial matching with vector comparisons

d <- c(10,12)
d %in% union(a,b)
d %in% a


###########################################
# IF STATEMENTS
###########################################

# structure of an if statement
# expression will execute if condition is met
# curly brackets allow for multiple lines of code
# if small amount of code, actually don't need the brackets
# if (condition) {expression}

x <- 5
if (x==5) {print('met the condition')
           print('do something further')
           }

x <- 4
if (x==5) print('met the condition')

x <- 4
if (x==3|5) {print('met the condition')
   print('do something further')
   }
# prints out because not set up properly
as.logical(5)

# instead should set up like this
x <- 4
if (x==3|x==5) {print('met the condition')
  print('do something further')
  }
# now runs properly, careful with compound statements
x <- 5
if (x %in% c(3,5)) {print('met the condition')
  print('do something further')
  }

x <- 4
if (x %in% c(3,5)) {print('met the condition')
    print('do something further')
} else print('condition not met')

# Missed some code here

z <- signif(runif(1),digits=2)
print(z)

z > 0.5
if (z > 0.5) cat(z,'is a biffer average number', '\n')

if(z > 0.8) cat(z,'is a large number','\n') else
  if(z < 0.8) cat(z,'is a large number','\n') else
  {cat(z,'is a large number','\n')
    cat('z^2 =',z^2,'\n')}

# if statement requires a single ....

# this does not do anything
if (z[1] >7) print(z)

# probably not what you want
if (z < 7) print(z)

# use subsetting!
print(z[z<7])

##############################
#ifelse to fill vectors
##############################

# suppose we have an insect population in which each female lays, on average, 10.2 eggs, following a Poisson distribution with lambda =10.2. However, there is a 35% chance of parasitism, in which case no eggs are laid. Here is the distribution of eggs laid for 1000 individuals.

tester <- runif(1000) # start with random uniform elements
eggs <- ifelse(tester>0.35,rpois(n=1000,lambda=10.2),0)
hist(eggs)

pVals <- runif(100)
z <- ifelse(pVals<=0.025,"lowerTail","nonsig")
z[1:50]
z[pVals>0.975] <- "uppertail"
table(z)

# ifelse statements can be confusing, this is another way to do it

z1 <- rep("nonsig", 1000)
z1[pVals<=0.025] <- "lowerTail"
z1[pVals>=0.025] <- "upperTail"
table(z1)
