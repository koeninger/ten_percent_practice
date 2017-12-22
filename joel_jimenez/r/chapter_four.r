library(ISLR)

# Logistic Regression
names(Smarket)
dim(Smarket)
summary(Smarket)
cor(Smarket[,-9])
attach(Smarket)
plot(Volume)

glm.fits = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Smarket, family=binomial)
summary(glm.fits)
coef(glm.fits)
summary(glm.fits)$coef
summary(glm.fits)$coef[,4]

glm.probs = predict(glm.fits, type="response")
glm.probs[1:10]
contrasts(Direction)

glm.pred = rep("Down", 1250)
glm.pred[glm.probs > .5] = "Up"
table(glm.pred, Direction)
mean(glm.pred == Direction)

train = (Year < 2005)
Smarket.2005 = Smarket[!train,]
dim(Smarket.2005)
Direction.2005 = Direction[!train]

glm.fits = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Smarket, family=binomial, subset=train)
glm.probs = predict(glm.fits, Smarket.2005, type="response")
glm.pred = rep("Down", 252)
glm.pred[glm.probs > .5] = "Up"
table(glm.pred, Direction.2005)
mean(glm.pred == Direction.2005)
mean(glm.pred != Direction.2005)

glm.fits = glm(Direction~Lag1+Lag2, data=Smarket, family=binomial, subset=train)
glm.probs = predict(glm.fits, Smarket.2005, type="response")
glm.pred = rep("Down", 252)
glm.pred[glm.probs > .5] = "Up"
table(glm.pred, Direction.2005)
mean(glm.pred == Direction.2005)

predict(glm.fits, newdata=data.frame(Lag1 = c(1.2, 1.5), Lag2 = c(1.1, -0.8)), type="response")

# Linear Discriminant Analysis p161
library(MASS)

lda.fit = lda(Direction~Lag1+Lag2, data=Smarket, subset=train)
lda.fit
plot(lda.fit)

lda.pred = predict(lda.fit, Smarket.2005)
names(lda.pred)

lda.class = lda.pred$class
table(lda.class, Direction.2005)
mean(lda.class == Direction.2005)

sum(lda.pred$posterior[ ,1] >= .5)
sum(lda.pred$posterior[ ,1] < .5)
lda.pred$posterior [1:20, 1]
lda.class [1:20]
sum(lda.pred$posterior[,1] > .9)

# Quadratic Discriminant Analysis p163
qda.fit = qda(Direction~Lag1+Lag2, data=Smarket, subset=train)
qda.fit
qda.class = predict(qda.fit, Smarket.2005)$class
table(qda.class, Direction.2005)
mean(qda.class == Direction.2005)

# K-Nearest Neighbors p164
library(class)
train.X = cbind(Lag1, Lag2)[train,]
test.X = cbind(Lag1, Lag2)[!train,]
train.Direction = Direction[train]

set.seed(1)
knn.pred = knn(train.X, test.X, train.Direction, k=1)
table(knn.pred, Direction.2005)
mean(knn.pred == Direction.2005)
knn.pred = knn(train.X, test.X, train.Direction, k=3)
table(knn.pred, Direction.2005)
mean(knn.pred == Direction.2005)
