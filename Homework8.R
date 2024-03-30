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
#'data.frame':	100 obs. of  5 variables
  
#3. Now, create a iris2 data frame from iris1 that contains only the columns for Species, Sepal.Length, and Sepal.Width. 

#Dplyr method-uses select() function, which can use either column # or name
#dplyr method
iris2<-select(iris1, "Species", "Sepal.Length", "Sepal.Width")


#How many observations and variables are in the data set?
# get the dataframe structure
str(iris2)
# 'data.frame':	100 obs. of  3 variables

#4. Create an iris3 data frame from iris2 that orders the observations from largest to smallest sepal length. 

# Create iris3 data frame with ordered observations
iris3 <- iris2 %>% 
arrange(desc(Sepal.Length))
#print(iris3) 
# Use print see the entire data frame

#Show the first 6 rows of this data set.
head (iris3)
# Use head to see just the first six rows

#5. Create an iris4 data frame from iris3 that creates a column with a sepal area (length * width) value for each observation. 
#use mutate to change dataframe
#add new variable by multiplying specified columns
iris4 <- iris3 %>% 
mutate(Sepal.Area = Sepal.Length * Sepal.Width)

# How many observations and variables are in the data set?
str(iris4) # 'data.frame':	100 obs. of  4 variables
# there should be four variables because of the addition of Sepal.Area
# Calling structure returns that there are still 100 observations, but now there are 4 variables

#6. Create iris5 that calculates the average sepal length, the average sepal width, 
# and the sample size of the entire iris4 data frame and print iris5.
iris5 <- iris4 %>% 
summarise(Avg_Sepal.Length = mean(Sepal.Length),
          Avg_Sepal.Width = mean(Sepal.Width),
          SampleSize = n())
          print(iris5)

# Use summarise() to create a new data frame with summary statistics
# The output is a single row summarizing all observations in the input
# It will contain one column for each of the specified summary statistics

# Avg_Sepal.Length Avg_Sepal.Width SampleSize
#     1            6.262           2.872        100
# Makes sense that there are still 100 observations, should not change
          
#7. Finally, create iris6 that calculates the average sepal length, the average sepal width, 
# and the sample size for each species of in the iris4 data frame and print iris6.

iris6 <- iris4 %>% 
#  select(Species)  # Why won't select() work?
group_by(Species) %>%
# use group_by() to creat a copy of data frame grouped by Species, then get summary 
# statistcs the same as above
summarise(Avg_Sepal.Length = mean(Sepal.Length),
         Avg_Sepal.Width = mean(Sepal.Width),
         SampleSize = n())
print(iris6)

#8. In these exercises, you have successively modified different versions of the data frame iris1 iris2 iris3 iris4 iris5 iris6. 
# At each stage, the output data frame from one operation serves as the input fro the next. 

# A more efficient way to do this is to use the pipe operator %>% from the tidyr package. 
# See if you can rework all of your previous statements (except for iris5) into 
# an extended piping operation that uses iris as the input and generates irisFinal as the output.

data("iris").

iris1 <-iris %>%
  filter(Species == "virginica" | Species == "versicolor",
        "Sepal.Length" > 6, 
        "Sepal.Width" > 2.5)  

iris2 <-iris1 %>%
  select(Species, Sepal.Length, Sepal.Width)  

iris3 <- iris2 %>% 
  arrange(desc(Sepal.Length))   

iris4 <- iris3 %>% 
  mutate(Sepal.Area = Sepal.Length * Sepal.Width)  

iris6 <- iris4 %>% 
  group_by(Species) %>%
  summarise(Avg_Sepal.Length = mean(Sepal.Length),
            Avg_Sepal.Width = mean(Sepal.Width),
            SampleSize = n())  

irisFinal <- iris6  
  
print(irisFinal)

# Or all at once
data("iris")
# Not able to automate the first step, but here are the rest of the operators all at once

irisFinal <-iris %>%
  filter(Species == "virginica" | Species == "versicolor",
         "Sepal.Length" > 6, 
         "Sepal.Width" > 2.5)  %>%
  select(Species, Sepal.Length, Sepal.Width)  %>%
  arrange(desc(Sepal.Length)) %>%
  mutate(Sepal.Area = Sepal.Length * Sepal.Width)  %>%
  group_by(Species) %>%
  summarise(Avg_Sepal.Length = mean(Sepal.Length),
            Avg_Sepal.Width = mean(Sepal.Width),
            SampleSize = n()) 

print(irisFinal)


#9. Create a ‘longer’ data frame using the original iris data set with three columns named “Species”, “Measure”, “Value”. 
# The column “Species” will retain the species names of the data set. 
# The column “Measure” will include whether the value corresponds to Sepal.Length, Sepal.Width, Petal.Length, or Petal.Width 
# and the column “Value” will include the numerical values of those measurements.

#I am not sure if we should be including all species from the data set, or just
# the two from the filtering in question #1. Below shown both ways.

#Pivot_longer lengthens the data, decreasing the number of columns, and increases the number of rows

#using pivot_longer() with all species
ris_long <- pivot_longer(iris, cols=c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width), 
                        names_to="Measure", 
                        values_to = "Value")

head(iris_long)
tail(iris_long)


#using pivot_longer() with just "virginica" and "versicolor"
iris1<-filter(iris, Species == "virginica" | Species == "versicolor")

iris_long <- pivot_longer(iris1, cols=c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width), 
                          names_to="Measure", 
                          values_to = "Value")
head(iris_long)
print(iris_long)
