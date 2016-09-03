# 箱ひげ図
plot(ToothGrowth$supp, ToothGrowth$len)


# 定型構文
boxplot(len ~ supp, data = ToothGrowth)

# x軸の2つの変数の相互関係を図示する
boxplot(len ~ supp + dose, data = ToothGrowth)

library(ggplot2)
qplot(ToothGrowth$supp, ToothGrowth$len, geom = "boxplot")
qplot(supp, len, data = ToothGrowth, geom = "boxplot")

# 以下の記述と同等
ggplot(ToothGrowth, aes(x = supp, y = len)) + geom_boxplot()

# 3つの独立したベクトルを使う
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom = "boxplot")
# データフレームから列を取得する方法も可能
qplot(interaction(supp, dose), len, data = ToothGrowth, geom = "boxplot")
# これは以下の記述と同等
ggplot(ToothGrowth, aes(x = interaction(supp, dose), y = len)) + geom_boxplot()
