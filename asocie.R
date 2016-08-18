library(arules)
library(arulesViz)
data(Groceries)
Groceries
df2 <- read.csv("R_practice/test.csv",header=TRUE)
df2
typeof(df2)
class(df2[,1])
class(df2[,2])
df2[,2]

df2[,1]<-factor(df2[,1])
class(df2[,1])

df2[,2]<-factor(df2[,2])
class(df2[,2])
df2.tran<-as(df2, "transactions")
df2.tran

rules <- apriori(df2.tran,parameter = list(support =0.001,maxlen=6,confidence=0.1))
plot(rules)
