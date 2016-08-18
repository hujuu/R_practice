#5つの異なるポアソン分布から1万個のランダムな数字を生成
pois1 <- rpois(n = 10000, lambda = 1)

pois2 <- rpois(n = 10000, lambda = 2)
pois5 <- rpois(n = 10000, lambda = 5)
pois10 <- rpois(n = 10000, lambda = 10)
pois20 <- rpois(n = 10000, lambda = 20)

pois <- data.frame(Lambda.1 = pois1, Lambda.2 = pois2, Lambda.5 = pois5,
                   Lambda.10 = pois10, Lambda.20 = pois20)
head(pois)

#グラフを作成しやすいように、reshape2パッケージをロード
require(reshape2)

#longフォーマットへデータを変更
pois <- melt(data = pois, variable.name = "Lambda", value.name = "x")

#新しい列名をきれいにするために、stringrパッケージをロード
require(stringr)

#λをきれいにして値だけ表示する
pois$Lambda <- as.factor(as.numeric(str_extract(string = pois$Lambda,
                                                pattern = "\\d+")))
head(pois)
tail(pois)

#ヒストグラムの作成
require(ggplot2)
ggplot(pois, aes(x = x)) + geom_histogram(binwidth = 1) +
  facet_wrap(~Lambda) + ggtitle("Probability Mass Fanction")

#各密度分布を重ねたタイプ
ggplot(pois, aes(x = x)) +
  geom_density(aes(group = Lambda, color = Lambda, fill = Lambda),
               adjust = 4, alpha = 1/2) +
  scale_color_discrete() + scale_fill_discrete() +
  ggtitle("Probability Mass Fanction")

