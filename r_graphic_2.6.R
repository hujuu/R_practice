# ユーザ定義の関数をプロットする
myfun <- function(xvar){
  1/(1 + exp(-xvar + 10))
}
curve(myfun(x), from = 0, to = 20)
# 曲線を追加する
curve(1-myfun(x), add = TRUE, col = "red")
## add = TRUE を指定すると、既に描画されたプロットに関数曲線が追加される

library(ggplot2)
# xの範囲を0~20に設定する
## qplot(c(0,20), fun = myfun, stat = "function", geom = "line") #現在はstatでエラーが出る
# 以下の記述と同等
ggplot(data.frame(x = c(0, 20)), aes(x = x)) + stat_function(fun = myfun, geom = "line")

data <- read.csv(file("R_practice/biz_count26.csv",encoding='Shift_JIS'))
data

library(MASS)
ggplot(birthwt, aes(x = bwt)) + geom_histogram(fill = "white", color = "black") +
  facet_grid(smoke ~ .)

data2 <- data.frame(data$revenue, data$division)
data2

ggplot(data, aes(x = office)) +
  geom_histogram(binwidth = 500, fill = "white", color = "black") +
  facet_grid(division ~ .)

# divisionをファクタに変換する
data$division <- factor(data$division)
levels(data$division)

library(plyr) # revalue()関数の読み込み
data$division <- revalue(data$division, c("0"="Wholesale", "1"="retail"))

ggplot(data, aes(x = office)) +
  geom_histogram(binwidth = 500, fill = "white", color = "black") +
  facet_grid(division ~ .)

ggplot(data, aes(x = office, fill = division)) +
  geom_histogram(position = "identity", alpha = 0.4)
