x <- rnorm(100)
plot(x)

c("happy", "world", 2015)
#計算結果が文字型に変換される
c("sin(pi/6)=", sin(pi/6))

1:10
rep(10, 3)
seq(1,2,0.1)

x <- c(3,6,10)
x
y <- c(3,2,5)
x/y

x^2

#2次元配列（行列）
x <- 1:9
dim(x) <- c(3,3)

#3次元配列
x <- 1:27
dim(x) <- c(3,3,3)
x

matrix(1:15, ncol = 5, byrow = TRUE)
cbind(1:2,4:5,7:8)

ws.customer <- read.csv("Wholesale customers data.csv")
head(ws.customer)
cor(ws.customer[, 3:6])

install.packages("dplyr")
library(dplyr)
filter(ws.customer, Frozen>8000, Grocery>9000)
filter(ws.customer, Frozen>8000 | Grocery>9000)
select(ws.customer, Channel:Milk)

library(ggplot2)

channel.tab <- table(ws.customer$Channel)
channel.tab
barplot(channel.tab, ylim = c(0,300), ylab = "度数")

###plotで文字化け防止#####
#初期設定では文字化け
?par
par(family = "")
par(family = "HiraKakuProN-W3")