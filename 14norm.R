#最初のコードで何を行っているか説明する
p <- ggplot(data.frame(x = randNorm, y = randDensity)) + aes(x = x, y = y) +
  geom_line() + labs(x = "x", y = "Density")

#pはきれいな分布をえがく

neg1Seq <- seq(from = min(randNorm), to = -1, by = .1)

lessThanNeg1 <- data.frame(x = neg1Seq, y = dnorm(neg1Seq))

head(lessThanNeg1)

lessThanNeg1 <- rbind(c(min(randNorm), 0),
                      lessThanNeg1,
                      c(max(lessThanNeg1$x), 0))
#ポリゴンで影を作成する
p + geom_polygon(data = lessThanNeg1, aes(x=x,y=y))

# -1から1までの似た連続値を作成
neg1Pos1Seq <- seq(from = -1, to = 1, by = .1)

# x軸の連続値をdata.frameで作成
neg1To1 <- data.frame(x = neg1Pos1Seq, y = dnorm(neg1Pos1Seq))

head(neg1To1)

# 高さ0の1番左と1番右のエンドポイントを連結
neg1To1 <- rbind(c(min(neg1To1$x), 0),
                 neg1To1,
                 c(max(neg1To1$x), 0))
#ポリゴンで影を作成する
p + geom_polygon(data = neg1To1, aes(x=x,y=y))

randProb <- pnorm(randNorm)
ggplot(data.frame(x = randNorm, y = randProb)) + aes(x=x, y=y) +
  geom_point() + labs(x = "Random Normal Variables", y = "Probability")

randNorm10
qnorm(pnorm(randNorm10))

all.equal(randNorm10, qnorm(pnorm(randNorm10)))

#成功確率0.4を10回行う行為を一度実行
rbinom(n = 1, size = 10, prob = 0.4)
rbinom(n = 5, size = 10, prob = 0.4)
rbinom(n = 10, size = 10, prob = 0.4)

#ベルヌーイ試行
rbinom(n = 1, size = 1, prob = 0.4)
rbinom(n = 5, size = 1, prob = 0.4)
rbinom(n = 10, size = 1, prob = 0.4)

binomData <- data.frame(Success = rbinom(n = 10000, size = 10, prob = 0.3))
ggplot(binomData, aes(x = Success)) + geom_histogram(binwidth = 1)

binom5 <- data.frame(Successes = rbinom(n = 10000, size = 5, prob = 0.3), Size = 5)
dim(binom5)
head(binom5)

binom10 <- data.frame(Successes = rbinom(n = 10000, size = 10, prob = .3), Size = 10)
dim(binom10)
head(binom10)

binom100 <- data.frame(Successes = rbinom(n = 10000, size = 100, prob = .3), Size = 100)
binom1000 <- data.frame(Successes = rbinom(n = 10000, size = 1000, prob = .3), Size = 1000)

#全てのデータを1つのデータフレームに統合
binomAll <- rbind(binom5, binom10, binom100, binom1000)
dim(binomAll)
head(binomAll, 10)
tail(binomAll, 10)

#プロットの作成
ggplot(binomAll, aes(x = Successes)) + geom_histogram() +
  facet_wrap(~ Size, scales = "free")
