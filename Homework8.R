#Homework #8
#NRG
#20 March 2024

#Data manipulations using the dplyr package
#This homework assignment focus on data manipulation in R. 
#Complete these problems using the dplyr and tidyverse packages.

#load libraries
library(dplyr)
library(tidyverse)

#1. Examine the structure of the iris data set. 
data("iris")
str_iris<-str(iris)

#print(str_iris) # does not work
#tried print() so that answer would print to the screen, does not work

#How many observations and variables are in the data set?
#'data.frame':	150 obs. of  5 variables:

#2. Create a new data frame iris1 that contains only the species virginica and versicolor with sepal lengths longer than 6 cm and sepal widths longer than 2.5 cm. 

#Filter function() : pick/subset observations by their values
#uses >, >=, <, <=, !=, == (not just one!) for comparison
#logical operators: & | (or) !(not/negative)
#filter automatically excludes NAs, have to ask for them specifically

iris1<-filter(iris, Species == "virginica" | Species == "versicolor", "Sepal.Length" > 6, "Sepal.Width" > 2.5)
str(iris1)
View(iris1)

#How many observations and variables are in the data set?
#'data.frame':	100 obs. of  5 variables:
  
#3. Now, create a iris2 data frame from iris1 that contains only the columns for Species, Sepal.Length, and Sepal.Width. 
iris2<-select(iris1, "Species", "Sepal.Length", "Sepal.Width")
str(iris2)

#How many observations and variables are in the data set?



#4. Create an iris3 data frame from iris2 that orders the observations from largest to smallest sepal length. 
#Show the first 6 rows of this data set.



#5. Create an iris4 data frame from iris3 that creates a column with a sepal area (length * width) value for each observation. 
# How many observations and variables are in the data set?
  


#6. Create iris5 that calculates the average sepal length, the average sepal width, 
# and the sample size of the entire iris4 data frame and print iris5.



#7. Finally, create iris6 that calculates the average sepal length, the average sepal width, 
# and the sample size for each species of in the iris4 data frame and print iris6.



#8. In these exercises, you have successively modified different versions of the data frame iris1 iris2 iris3 iris4 iris5 iris6. 
# At each stage, the output data frame from one operation serves as the input fro the next. 




# A more efficient way to do this is to use the pipe operator %>% from the tidyr package. 
# See if you can rework all of your previous statements (except for iris5) into an extended piping operation that uses iris as the input and generates irisFinal as the output.



#9. Create a ‘longer’ data frame using the original iris data set with three columns named “Species”, “Measure”, “Value”. 
# The column “Species” will retain the species names of the data set. 
# The column “Measure” will include whether the value corresponds to Sepal.Length, Sepal.Width, Petal.Length, or Petal.Width 
# and the column “Value” will include the numerical values of those measurements.



