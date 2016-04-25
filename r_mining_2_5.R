data(Titanic)
str(Titanic)
Titanic[,1,2,]

mosaicplot(Titanic[,1,2,], color = T)

install.packages("epitools")
library(epitools)
Titanic.df <- expand.table(Titanic)
library(rpart)
Titanic.tree <- rpart(Survived ~.,data = Titanic.df,method = "class")
summary(Titanic.tree)

install.packages("partykit")
library(partykit)
plot(as.party(Titanic.tree))

plotcp(Titanic.tree)

Titanic.tree2 <- rpart(Survived ~ ., data = Titanic.df,
                       method = "class", cp = 0.083)
summary(Titanic.tree2)
plot(as.party(Titanic.tree2))

library(ggplot2)
data(diamonds)
head(diamonds)
diamonds2 <- subset(diamonds, subset = carat >= 1.5 & carat < 2 &
                      clarity %in% c("I1","SI2"))
boxplot(diamonds2$price)
