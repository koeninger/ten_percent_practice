# 5.3.1 The Validation Set Approach
library(ISLR)
set.seed(1)
train = sample(392, 196)
lm.fit = lm(mpg~horsepower, data=Auto, subset=train)

attach(Auto)
mean((mpg - predict(lm.fit, Auto))[-train]^2)
lm.fit2 = lm(mpg~poly(horsepower, 2), data=Auto, subset=train)
mean((mpg - predict(lm.fit2, Auto))[-train]^2)
lm.fit3 = lm(mpg~poly(horsepower, 3), data=Auto, subset=train)
mean((mpg - predict(lm.fit3, Auto))[-train]^2)

set.seed(2)
train = sample(392, 196)
lm.fit = lm(mpg~horsepower, subset=train)
mean((mpg - predict(lm.fit, Auto))[-train]^2)
lm.fit2 = lm(mpg~poly(horsepower, 2), data=Auto, subset=train)
mean((mpg - predict(lm.fit2, Auto))[-train]^2)
lm.fit3 = lm(mpg~poly(horsepower, 3), data=Auto, subset=train)
mean((mpg - predict(lm.fit3, Auto))[-train]^2)

# Leave-One-Out Cross-Validation
glm.fit = glm(mpg~horsepower, data=Auto)
coef(glm.fit)
lm.fit = lm(mpg~horsepower, data=Auto)
coef(lm.fit)

library(boot)
glm.fit = glm(mpg~horsepower, data=Auto)
cv.err = cv.glm(Auto, glm.fit)
cv.err$delta
cv.error = rep(0, 5)
for(i in 1:5){
	glm.fit = glm(mpg~poly(horsepower, i), data=Auto)
	cv.error[i] = cv.glm(Auto, glm.fit)$delta[1]
}
cv.error
