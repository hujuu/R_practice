head(BOD)
barplot(BOD$demand, names.arg = BOD$Time)
c <- table(mtcars$cyl)

# 個数のテーブルからグラフを作成する
barplot(c)

library(ggplot2)
# 以下は本の通りだが古い記述なのでエラーになる
qplot(BOD$Time, BOD$demand, geom = "bar", stat = "identity")

ggplot(BOD, aes(x = Time, y = demand)) + geom_bar(width = 0.9,stat = "identity")

# ここではcylは連続値（書籍のままだとエラーが出るが一応書ける）
qplot(mtcars$cyl)

# binwidthを指定しろと言われるので、入れる
qplot(mtcars$cyl, binwidth = 0.8)

# cylを離散値として扱う
qplot(factor(mtcars$cyl))

# 値を示す棒グラフ。同じ意味だが最初のは現行バージョンでは動かない
## qplot(Time, demand, data = BOD, geom = "bar", stat = "identity")
ggplot(BOD, aes(x = Time, y = demand)) + geom_bar(stat = "identity")

# 個数を示す棒グラフ
qplot(factor(cyl), data = mtcars)
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar()
