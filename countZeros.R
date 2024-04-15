
z <- rbinom(n=5, size=1, 0.5)

counter <- 0


count_zeros <- function(vec) {
  for (i in seq_along(z)) {
    if(z[i]==0) {
      counter <- i + 1
    }
    return(counter)
  }
}

count_zeros(z)
