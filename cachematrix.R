## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

## NEW Initialize matrix and assigns the NULL value to the variable m
makeCacheMatrix <- function(x = matrix()) {
      m <- NULL
      set <- function(y) {
            x <<- y
            m <<- NULL
      }
      get <- function() x
      setmean <- function(solve) m <<- solve()
      getmean <- function() m
      list(set = set, get = get,
           setmean = setmean,
           getmean = getmean)
}


## Write a short comment describing this function

##computes the inverse of a matrix provided that the 
##variable m (stored in the cache) is empty, otherwise shows the inverse matrix in m

cacheSolve <- function(x, ...) {
      
      m <- getmean()
      if(!is.null(m)) {
            message("getting cached data")
            return(m)
      }
      
      data <- get()
      m <- solve(data, ...)
      #setmean(m)
      m
}
