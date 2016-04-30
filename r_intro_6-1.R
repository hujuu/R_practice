#分散分析
#データの読み込み
sleep1 <- read.csv("R_practice/anoval.csv")

#平均値の算出
tapply(sleep1$time, sleep1$club, mean)

#標準偏差
tapply(sleep1$time, sleep1$club, sd)

aov(sleep1$time~sleep1$club)

summary(aov(sleep1$time~sleep1$club))
TukeyHSD(aov(sleep1$time~sleep1$club))
