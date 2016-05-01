#一要因分散分析（対応あり）
task1 <- read.csv("R_practice/anova2a.csv")
head(task1)

tapply(task1$grade, task1$condition, mean)
tapply(task1$grade, task1$condition, sd)

class(task1$number)
task1$number2 <- factor(task1$number)
task1$number2
class(task1$number2)

summary(aov(task1$grade~task1$condition + task1$number2))

TukeyHSD(aov(task1$grade~task1$condition + task1$number2))
