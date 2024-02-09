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

m <- matrix(data=my_vec,nrow=4,byrow=TRUE) # we can fill across rather than by coliumns, columns is default
print(m)

my_m_data <- c(1,2,3,
               4,5,6,
               7,8,9)
my_new_matrix <- matrix(data=my_m_data,nrow=3,byrow=TRUE)
print(my_new_matrix)

#LISTS

# lists are atomic vectors but each element  
# can hold things that are different tyes and different sizes

myList <-list(1:10, matrix(1:8,nrow=4,byrow=TRUE), letters[1:3],pi)
str(myList)
print(myList)



