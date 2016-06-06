#2要因分散分析（混合計画）

TV2 <- read.csv("R_practice/anova5b.csv")

TV2$number
TV2$number2 <- factor(TV2$number)
TV2$number2

TV3 <- TV2[,c("number2", "sex", "weekday", "holiday")]
TV3

library(reshape)

TV4 <- melt(TV3, id = c("number2", "sex"))
TV4

names(TV4) <- c("number2", "sex", "day", "time")
TV4

summary(aov(TV4$time
            ~TV4$day*TV4$sex
            +Error(TV4$number2:TV4$sex
                  +TV4$number2:TV4$day:TV4$sex)))
