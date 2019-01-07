###########################
#         Chapter 2       #
###########################

list_packages <- c("lobstr")
new_pkg <- list_packages[!(list_packages %in% installed.packages()[,"Package"])]
if(length(new_pkg)) install.packages(new_pkg)
sapply(list_packages, require, character.only = TRUE)


# 2.2.2 Exercises

# 1. 
a <- 1:10
b <- a
c <- b
d <- 1:10

lobstr::obj_addr(a)
lobstr::obj_addr(b)
lobstr::obj_addr(c)
lobstr::obj_addr(d)

# 2.
lobstr::obj_addr(mean)
lobstr::obj_addr(base::mean)
lobstr::obj_addr(get("mean"))
lobstr::obj_addr(evalq(mean))
lobstr::obj_addr(match.fun("mean"))

# 3. Duplicated names, for instance?
# check.names argument

# 4. All invalid characters are translated to ".". A missing value is translated to "NA". Names which match R keywords have a dot appended to them. Duplicated values are altered by make.unique.

# 5.
# .123e1 is not valid since it begins with a dot and a number


# 2.3.6 Exercises

# 1. Every time tracemem(1:10) is executed it creates a new object that has no name so this is not useful in order to trace it
# 2. 
x <- c(1L, 2L, 3L)
typeof(x)
tracemem(x)

x[[3]] <- 4
typeof(x)
untracemem(x)
# The first object is a vector of integers and when modifying x[[3]] to a double, because of rules of coertion in R, first a coertion to double is done and then the value is modified to 4

# 3. (extracted on https://advanced-r-solutions.rbind.io/names-and-values.html) A contains a reference to an address with the value 1:10. b contains a list of two references to the same address as a. c contains a list of b (containing two references to a), a (containing the same reference again) and a reference pointing to a different address containing the same value (1:10).
a <- 1:10
b <- list(a, a)
c <- list(b, a, 1:10)
ref(c)

# 4.
x <- list(1:10)
ref(x)
x[[2]] <- x
ref(x)


# 2.4.1 Exercises

# 1. 
y <- rep(list(runif(1e4)), 100)
object.size(y)
#> 8005648 bytes
obj_size(y)
#> 80,896 B
# (extracted on https://advanced-r-solutions.rbind.io/names-and-values.html) object.size() doesn’t account for shared elements within lists. Therefore, the results differ by a factor of ~ 100.

# 2.
funs <- list(mean, sd, var)
obj_size(funs)
#  It is somewhat misleading, because all three functions are built-in to R as part of the base and stats packages and hence always loaded.

# 3.
a <- runif(1e6)
sapply(0:32, function(x) obj_size(double(x))) - sapply(1:33, function(x) obj_size(double(x)))
obj_size(double(0)) + length(runif(1e6)) * 8
obj_size(a) #8,000,040 B

b <- list(a, a) 
obj_size(vector(mode = "list", length = 2)) # empty list
obj_size(a) + obj_size(vector(mode = "list", length = 2)) # 8,000,096 B
obj_size(b) # 8,000,096 B
obj_size(a, b)
identical(obj_size(b), obj_size(a, b)) # it contains references to the same memory address, so no additional memory is required for the second list element

b[[1]][[1]] <- 10
obj_size(b)
obj_size(a, b)


b[[2]][[1]] <- 10
obj_size(b)
obj_size(a, b)


x <- list()
tracemem(x)
lobstr::obj_addr(x)

x[[1]] <- x


lobstr::obj_addr(x[[1]])

lobstr::obj_addr(x)
ref(x)
