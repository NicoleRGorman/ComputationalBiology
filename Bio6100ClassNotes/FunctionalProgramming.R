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

# split/apply/combine for groups in a data frame


# missed more here
# really having a hard time staying with the game rn

print(out_g)

# tapply solution

z <-tapply(X=df2$x,
           INDEX=df2$treatment,
           FUN=function(x) sd(x)/mean(x))
print(z)


# April 23, 2024 class notes


#Needs functtion information Here
################################################

# Fourth Task: replicate a stochastic process

pop_gen <- function(z=sample.int(n=10,size=1)) {
  n <- runif(z)

  return(n) # notes returns a numeric vector of stochastic length

} # end of pop_gen
#________________________________________________________________

pop_gen()

# for loop solution
# has to be a list bc different number of items every time it is run
n_reps <- 20
list_out <- vector("list",n_reps)
for(i in seq_len(n_reps)){
  list_out[[i]] <- pop_gen()
}
head(list_out)
}


# using replicate do the same thing
# replicate(n,expr)
# n is the number of times te operation is to be repeated
# expr is a function (base, or user-defines), or an expression
################ needs mores here

z_out <- replicate(n=5,
                   expr=pop_gen())
print(z_out)

# Fifth task: Sweep function with all parameter combinations
# ADD COMMENTS HERE

a_pars <- 1:10
c_pars <- c(100,150,125)
z_pars <- c(0.10,0.16,1.26,0.30)
df <- expand.grid(a=a_pars,c=c_pars,z=z_pars)
head(df)
df_out <-cbind(df,s=NA)

head(df_out)

for(i in seq_len(nrow(df))) {
  df_out$s[i] <- df$c[i]*(df$a[i]^df$z[i])
}
head(df_out)


# mapply function
# needs notes here
df_out$s <- mapply(FUN=function(a,c,z) c*(a^c), df$a,df$c,df$z)

head(df_out)

mapply(FUN=function(a,c,z) c*(a^c), df$a,df$c,df$z)

# would not use the last two
# "correct" solution

df_out$c*(df_out$a^df_out$z)

# creating functions that call functions

my_sum <- function(a,b) a+b
my_dif <- function(a,b) a-b
my_mult <- function(a,b) a*b

# we already know...
funct_1 <-function(a=3,b=2) sum(a,b)
funct_1()

funct_2 <-function(a=3,b=2) my_sum(a,b)
funct_2()

funct_3 <-function(a=3,b=2) my_mult(a,b)
funct_3()


algebra <- function(x=my_sum,a=3,b=2) x(a,b)

algebra(x=my_sum)
algebra(x=my_dif)
algebra(x=my_mult)

#####clumsy_function(func_name="my_sum") {
####  if
####}

algebra(x=sum)

# but this will not work?
algebra(x=mean)

# thi sneeds more...see class code



