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


# Graphics
x = rnorm(100)
y = rnorm(100)
plot(x,y)
plot(x, y, xlab="x-axis", ylab="y-axis", main="Plot of X vs Y")
pdf("first_plot.pdf")
plot(x, y, col="green")
dev.off()

# sequence
x = seq(1, 10)
print(x)
x = 1:10
print(x)
x = seq(-pi, pi, length=50)
print(x)

# Indexing
A = matrix(1:16, 4, 4)
print( A[2,3] )
print( A[ c(1, 4), c(1, 4)] )
print( A[ 1:3, 2:4] )
print( A[ 1:2,] )
print( A[-c(1, 3) ,] )
print( dim(A) )

# Loading
Auto = read.table("Auto.data", header=T, na.strings="?")
# fix(Auto)
dim(Auto)

Auto = read.csv("Auto.csv", header=TRUE, na.strings="?")
dim(Auto)
print( Auto[1:4] )
Auto = na.omit(Auto)
dim(Auto)
names(Auto)

summary(Auto)
plot(Auto$cylinders, Auto$mpg)
attach(Auto)
plot(cylinders, mpg)
plot(cylinders, mpg, col = "red", xlab = " cylinders", ylab = "MPG")
hist(mpg, col = 2, breaks = 15)
pairs(Auto)
