# 8.3 Decision Trees
library(tree)

# 8.3.1 Fitting Classification Trees p323
library(ISLR)
attach(Carseats)

High = ifelse(Sales <= 8, "No", "Yes")
Carseats = data.frame(Carseats, High)
tree.carseats = tree(High~.-Sales, Carseats)
summary(tree.carseats)

plot(tree.carseats)
text(tree.carseats, pretty=0)
tree.carseats

set.seed(2)
train = sample(1:nrow(Carseats), 200)
Carseats.test = Carseats[-train,]
High.test = High[-train]
tree.carseats = tree(High~.-Sales, Carseats, subset=train)
tree.pred = predict(tree.carseats, Carseats.test, type="class")
table(tree.pred, High.test)
(86 + 57) / 200