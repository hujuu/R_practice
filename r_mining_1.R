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
ws.customer$Channel <- factor(ws.customer$Channel,
                              labels = c("Horeca","Retail"))
qplot(Channel, data = ws.customer, fill=I("grey"), ylab="度数")

ws.customer$Region <- factor(ws.customer$Region,
                              labels = c("Lisbon","Oporto",
                                         "Other Region"))
#積み上げ縦棒グラフ
qplot(Channel, data = ws.customer, fill = Region, ylab="度数")
#帯グラフ
qplot(Channel, data = ws.customer, fill = Region, 
      ylab="比率",position = "fill")

###plotで文字化け防止#####
#初期設定では文字化け
?par
par(family = "HiraKakuProN-W3")

hist(ws.customer$Milk, breaks=20, xlim = c(0,80000), ylim = c(0,300),
     xlab = "Milk", ylab = "度数", main = "")
qplot(Milk, data = ws.customer, fill = I("grey"), color=I("black"),
      binwidth=4000)
boxplot(Milk~Channel, data = ws.customer, ylim=c(0,80000))
qplot(Channel, Milk, data = ws.customer, geom = "boxplot")
plot(ws.customer$Grocery, ws.customer$Detergents_Paper,
     xlab = "Grocery", ylab = "Detergents_Paper")
qplot(Grocery, Detergents_Paper, data = ws.customer)
qplot(Grocery, Detergents_Paper, color = Channel, size = Fresh,
      data = ws.customer)
qplot(Grocery, Detergents_Paper, color = Channel, size = Fresh,
      data = ws.customer, facets = ~Channel)
