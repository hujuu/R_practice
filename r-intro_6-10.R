#アンバランスデザインの分散分析

sleep3 <- read.csv("R_practice/anova3b.csv") # データの読み込み

tapply(sleep3$time, list(sleep3$club, sleep3$sex), mean)

tapply(sleep3$time, list(sleep3$club, sleep3$sex), sd)

summary(aov(sleep3$time~sleep3$club*sleep3$sex))

summary(aov(sleep3$time~sleep3$sex*sleep3$club))

install.packages("car")
install.packages("pbkrtest")

library(car)
