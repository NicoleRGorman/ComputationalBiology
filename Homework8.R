#Homework #8
#NRG
#20 March 2024

#Data manipulations using the dplyr package
#This homework assignment focus on data manipulation in R. Complete these problems using the dplyr and tidyverse packages.

#load libraries
library(dplyr)
library(tidyverse)

#1. Examine the structure of the iris data set. 
data("iris")
str_iris<-str(iris)

#not working, come back to this
#print(str_iris)

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
  