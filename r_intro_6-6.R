#2要因分散分析（2要因とも対応あり）

#データの読み込み
beer1 <- read.csv("R_practice/anova4a.csv")
head(beer1)

#平均
tapply(beer1$taste, list(beer1$drink,beer1$place), mean)

#標準偏差
tapply(beer1$taste, list(beer1$drink,beer1$place), sd)

beer1$number2 <- factor(beer1$number)

class(beer1$number)

class(beer1$number2)
