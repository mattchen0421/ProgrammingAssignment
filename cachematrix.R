## Put comments here that give an overall description of what your
## functions do

# The first function can store and read matrix.
# The second one can inverse the matrix store in the first
# function or read it if it is already inversed.

## Write a short comment describing this function

# It creates a list of four functions which include
# set: store a new matrix
# get: get the value of matrix
# setsolve: store a new inversed matrix
# getsolve: get the value of inversed matrix
makeCacheMatrix <- function(x = matrix()) {
    s <- NULL
    
    set <- function(y) {
        x <<- y
        solved <<- NULL
    }
    get <- function() x
    setsolve <- function(solved) s <<- solved
    getsolve <- function() s
    list(set = set, get = get,
         setsolve = setsolve,
         getsolve = getsolve)
    
}
## Write a short comment describing this function

# It identify whether the matrix is inversed, if yes it 
# would return it, if not it would inverse it then return it.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    s <- x$getsolve()
    if(!is.null(s)) {
        message("getting cached data")
        return(s)
    }
    data <- x$get()
    s <- solve(data, ...)
    x$setsolve(s)
    s
}

