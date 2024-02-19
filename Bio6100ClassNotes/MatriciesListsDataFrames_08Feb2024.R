#Matricies, Lists and Data Frames
# 8 February 2024
# NRG

# a matrix is an atomic vector that is organized into rows and columns

my_vec<- 1:12

m <- matrix(data=my_vec,nrow=4) # have to specify at least one, this example is 4
print(m)

m <- matrix(data=my_vec,nrow=7) # throws an error bc 7 is not a multiple of 12
print(m)


m <- matrix(data=my_vec,ncol=3) # same except can specify columns
print(m)

m <- matrix(data=my_vec,nrow=4,byrow=TRUE) # we can fill across rather than by columns, columns is default
print(m)

my_m_data <- c(1,2,3,
               4,5,6,
               7,8,9)
my_new_matrix <- matrix(data=my_m_data,nrow=3,byrow=TRUE)
print(my_new_matrix)

#LISTS

# lists are atomic vectors but each element
# can hold things that are different types and different sizes

myList <-list(1:10, matrix(1:8,nrow=4,byrow=TRUE), letters[1:3],pi)
str(myList)
print(myList)

# using [] gives you a single item, which is of type of list
myList[4]

mylist[4] - 3 # no! Cannot subtract a number from an item on a list

myList  [[no]] # use a double bracket

myList[[4]]

myList[[4]] - 3 # now we have the contents

#if a list has 10 elements it is like a train with 10 cars
#[[5]] gives you the contents of car #5
# [5] creates a train with just car 5
# [c[4,5,6]] gives you a little train with cars 4,5,6

myList[[2]]
myList[[2]][4,1] #give me the contents of the first col, row 4, [1] 7

# name list items when they are created
myList2 <- list(Tester=FALSE,littleM=matrix(1:9,nrow=3)) #creates a second list, second list has an individual name

# now we can use the name

myList2$little[2,3] # get row 2, column 3
##ASK....what does th dollar sign mean?

myList2$littleM #show whole matrix...DID NOT WORK???
myList2$littleM[2,] #take the second row, then after comma nothing, so take all columns

myList2$littleM[2]
#What does this give you, [1] 2
#Recognizing the matrix as a vector bc no comma as was included before
#Can be a problem because now a vector not a matrix

# Good R hack for working with lists
# The "unlist" strips everythong back into
# a single atomic vector; coercion is used if there are mixed data types
unRolled <- unlist(myList2)
print(unRolled)

#The most common use of list: output from a linear model is a list
library(ggplot2)
yVar <- runif(10) #generates random numbers
xVar <- runif(10)
myModel <- lm(yVar~xVar)
qplot(x=xVar,y=yVar)
print(myModel)
# Call:
#   lm(formula = yVar ~ xVar)
#
# Coefficients:
#   (Intercept)         xVar
#kind of lame

#need to use the call summary instead

print(summary(myModel))
# returns lots...we only need some of it
# what is the structure of the summary?

str(summary(myModel))
summary(myModel)$coefficients #adds labels to rows and columns
summary(myModel)$coefficients["xVar","Pr(>|t|)"] #specifies a specific number
# gives you when slope =0

summary(myModel)$coefficients[2,4] # if you know where your metric should fall in the matrix

#can use the unlist call to root through the data
u <- unlist(summary(myModel))
print(u)

mySlope <- u$coefficients2
myPval <- u$coeffients8


#####################
#DATA FRAMES
#####################

# A data frame is a list of equal-lengthed atomic vectors, each of which is a column
# All columns have to be the same length, can have NA, but dimensions have to square up

varA <- 1:12 #creates an integer so that every row will have an assigned number
varB <- rep(c("Con","LowN","HighN"),each=4) #create atomic vectors of character strings, should be short and simple, used rep function so that each label will repeat 4 times...that's the 4
varC <- runif(12) # generating random values

dFrame <- data.frame(varA,varB,varC)
print(dFrame)
str(dFrame)
# 'data.frame':	12 obs. of  3 variables:
#   $ varA: int  1 2 3 4 5 6 7 8 9 10 ...
# $ varB: chr  "Con" "Con" "Con" "Con" ...
# $ varC: num  0.451 0.997 0.723 0.104 0.209 ...
head(dFrame) # gives the first 6 rows

#how can we expand the data frame?

#Add another row to the data set with rbind
#make sure you add a list, with each item corresponding to a column
#newData <- data.frame(list(varA=13,varB="HighN",varC=0.668))

#better to do it this way
newData <- list(varA=13,varB="HighN",varC=0.668)
print(newData)
str(newData)

# List of 3
# $ arA : num 13
# $ varB: chr "HighN"
# $ varC: num 0.668

dFrame <- rbind(dFrame,newData)
str(dFrame)
tail(dFrame) # checks to see that the data was added

newVar <- runif(13)
dFrame <- cbind(newVar,dFrame)
head(dFrame)

#create a matrix and data frame with some structures
zMat <- matrix(data=1:30,ncol=3,byrow=TRUE)
zDframe <- as.data.frame(zMat) #coerce it

str(zMat) #an atomic vecors with 2 dimensions
str(zDframe) # note horizontal layout of variables!
head(zDframe) #note atomic variables names
head(zMat) # note identical layout

# element referencing is the same in both, [1] 9
zMat[3,3]
zDframe[3,3]

# so is column referencing

zMat[,3]
zDframe[,3] # [1]  3  6  9 12 15 18 21 24 27 30

zDframe$V3 # note use of $ and named variable column

zMat[3,]
zDframe[3,] # note variable names and row number shown

# what happens if we only reference one dimension?
# new they are different because dimensions are different types of data

zMat[2] #takes a second element of atomic vector (column fill)
zDframe[2] #takes second atomic vector (=column) from list
zDframe["V2"]
zDframe$V2

##############################
#Eliminating Missing Values
##############################
print(zDframe)
head(zDframe) #look at the top
zDframe[2,2] <- NA 
head(zDframe) # contaminate data frame, add an NA into second row and second col to show adding an NA. This is more realistic of actual dataframes

complete.cases(zDframe$V2)
#does an operation on a vector...returns TRUE and FALSE

# access individual columns using assigned names, starts with $
# complete cases returns a boolean vector showing trues and falses, gives back a false for any NA value

zDframe$V2[complete.cases(zDframe$V2)]
#To clean the dataframe out, the [ allows for subsetting], the [pulls something out]
#[1]  2  8 11 14 17 20 23 26 29, shows that NA has been pulled out

which(!complete.cases(zDframe$V2)) #finds NA slot
#which will select the elements of what it contains, so ! says NOT, the will return what is NOT
#[1] 2, returns the NA value

which(complete.cases(zDframe$V2)) #finds "not" NA slot

#Heres how we can apply this...

m <- matrix(1:20,nrow=5) #matrix is a vector that has been folded up
m[1,1] <- NA #contaminate matrix in line 215 and 216
m[5,4] <- NA
print(m)

m[complete.cases(m),] #took values out that were not present, missing first col and last row
# common function, cleaning data set

# now get complete cases for only certain columns!
m[complete.cases(m[,c(1,2)]),] 
# matrix, all rows (this is the no number before the , before the c), only col 1 and 2, call complete cases on that, eliminate any row that has a missing value in 1 or 2 col
m[complete.cases(m[,c(2,3)]),] 
#       [,1] [,2] [,3] [,4]
# [1,]   NA    6   11   16
# [2,]    2    7   12   17
# [3,]    3    8   13   18
# [4,]    4    9   14   19
# [5,]    5   10   15   NA
#does not change anything bc NA not in col 2 or 3
m[complete.cases(m[,c(3,4)]),] # drops row 4
m[complete.cases(m[,c(1,4)]),] # drops row 1&4

######################################
#Techniques for Assignments and Subsetting Matricies and Dataframes
######################################

# same principle applied to both dimesions of a matrix
m <- matrix(data=1:12,nrow=3) # Build matrix
dimnames(m) <- list(paste("Species", 
                            LETTERS[1:nrow(m)],
                            sep=""),
                            paste("Site",1:ncol(m),sep=""))
# LETTERS is built in letter vector
# past function is....
# dimnames call assigns names
# does not change the dimension of the matrix
print(m)

#subsettng based on elements
m[1:2,3:4] #gives first and second rows and third and four columns

m[c("SpeciesA","SpeciesB"), c("Site3","Site4")]
# same as above, better bc more readable, worse bc have to type more

#use blank before or after comma to indicate full rows or cols

m[1:2, ]
m[ ,3:4]

#### Use logicals to build more complex subsetting
# e.g. select all columns for which the totals are > 15

# first try this logical

colSums(m)
colSums(m) >15

m[ , colSums(m) > 15]

m[rowSums(m)!=22,]
# e.g. select all rows for which row total is 22
m[ , colSums(m) == 22]

# note == for logical equal and != for logic NOT equal
m[ , colSums(m) == 22]

###############
#Need to go back and edit this from html

#first, try this
###############

#and try this logical for columns
m["SpeciesA",]<5
# add this in and select with all rows 
m[ ,m["SpeciesA", ]<5]

#now combine both
#####NEED TO FIX THIS WITH HTML
#m[m[ ,"Site1"<5],m["SpeciesA, "]<5}

print(m)

# caution! simple subscripting (is this supposed to be subsetting) to a vector changes the data type
z <- m[1,]
print(z)
str(z)

z2 <- m[1, ,drop=FALSE]
print(z2)
str(z2)

# caution #2! when working with a matrix always use both dimensions, or you will select a single matrix element

m2 <- matrix(data=runif(9),nrow=3)
print(m2)
m2[2,]

# but now this will just pull the second element

# if you are actually trying tp do this, use 
m2[2,1]
print(m2)

# add in the notes here....soooooosleepy! 

m2[m2>0.6,1] <- NA
print(m2)
