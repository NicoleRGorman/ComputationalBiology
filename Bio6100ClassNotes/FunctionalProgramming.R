# user defined functions

my_fun()

# Anaonymous functions
#unnaned, used for simple calculations, usually with asingle input, by convetion ca;led x

function(x) x + 3 # anonymous function
function(x) x + 3 (10) # try to provide input

(function(x) x + 3) (10) # need to wrap into parantheses


m <- matrix(1:20,nrow=5,byrow=TRUE)
print (m)

#create a vector of lists to hold output
# always need to set up the structure to hold the data before starting a for loop
output <- vector("list", nrow(m))
str(output)
print(output)

# run the function in a for loop for each
# row of the matrix


for(i in seq_len(nrow(m))) {
  output[i] <- my_fun(m[i,])
}

print (output)


# using the apply function to do the same thing
# apply(X,MARGIN,FUN,...)
# X= vector or an array (= matrix)
# MARGIN 1=row, 2=column, c(1,2)=roes and columns
#...optional arguments to FUN

# apply function my_fun to each row of m
row-out <- apply(X=m,
                 MARGIN=1,
                 FUN=my_fun)
print(row_out)

# apply function my_fun to each column of m
apply(m,2,my_fun)

# apply function my_fun to each column of m
apply(m,c(1,2),my_fun)

# apply
apply(m,1,function(x) max(sin(x) + x))

apply(m,2,function(x) max(sin(x) + x))

apply(m,c(1,2),function(x) max(sin(x) + x))

# first, modification of code to simply reshuffle the order of elements
apply(m,1,sample)

# caution! array output is each vector is in a column! To preserve original matrix dimensions, we need to transpose
t(apply(m,1,sample))

#function to choose a random number of elements
# from each ro and pick them in random order
# double brackets tell you the output is coming out of as a list
apply(m,1,function(x) x[sample(seq_along(x),size=sample
(seq_along(x),size=1))])

#Second Task
df <- data.frame(x=runif(20),y=runif(20),z=runif(20))

output <- vector("list", ncol(df))
print(output)

for (i in seq_len(ncol(df))) {
  output[i] <- sd(df[,i])/mean(df(df[,i]))


# use lapply to do the same thing
# always puts output into a list
summary_out <- lapply(X=df,
                      FUN=function(x) sd(x)/mean(x))
print(summary_out)


# what if all the columns are not the same type
treatment <- rep(c("Control","Treatment"), each=(nrow(df)/2))
print(treatment)
df2 <-cbind(treatment,df)
head(df2)

######
# missed a bunch here

