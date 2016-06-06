#２要因分散分析（混合計画）
#データの読み込み
TV1 <- read.csv("R_practice/anova5a.csv")
head(TV1)

#日と性別を組み合わせたセル平均と標準偏差
tapply(TV1$time, list(TV1$day,TV1$sex), mean)
tapply(TV1$time, list(TV1$day,TV1$sex), sd)

TV1$number2 <- factor(TV1$number)
TV1$number2

summary(aov(TV1$time
            ~TV1$day*TV1$sex
            +Error(TV1$number2:TV1$sex
                   +TV1$number2:TV1$day:TV1$sex)))
