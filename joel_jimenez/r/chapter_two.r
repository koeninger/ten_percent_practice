# Vectors
x <- c(1,3,2,5)
print(x)
y = c(1,4,3, 10)
print(y)

# Function calls
length(x)
length(y)
print(x + y)

# List/remove objects
ls()
rm(x)
ls()
rm(list=ls())
ls()

# ?matrix
a = c(1,2,3,4)
# x = matrix(data = a, nrow=2, ncol=2, byrow=TRUE)
x = matrix(a, 2, 2, TRUE)
print(x)

sqrt(x)
x^2

x = rnorm(50)
x
y = x + rnorm(50, mean=50, sd=0.1)
y
cor(x, y)

set.seed(1003)
rnorm(50)

set.seed(3)
y = rnorm(100)
mean(y)
var(y)
sqrt( var(y) )
sd(y)
