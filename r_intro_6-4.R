install.packages("reshape")
library(reshape)

#データの読み込み
task2 <- read.csv("R_practice/anova2b.csv")

task2$number2 <- factor(task2$number)
head(task2)

task3 <- task2[,c("number2","music","fragrance","no")]
head(task3)

task4 <- melt(task3,id="number2")
names(task4) <- c("number2", "condition", "grade")
head(task4)

summary(aov(task4$grade~task4$condition + task4$number2))

TukeyHSD(aov(task4$grade~task4$condition + task4$number2))

names(task4) <- c("number2", "variable", "value")
task4
task5 <- cast(task4)
task5
