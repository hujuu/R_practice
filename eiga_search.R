eiga <- read.csv("../../eiga.csv")

library(ggplot2)
qplot(screen, user, data = eiga)
qplot(screen, user, data = eiga) + geom_smooth(method = "lm")
eiga.lm <- lm(user~screen, data = eiga)

#回帰直線の切片と傾き
eiga.lm
summary(eiga.lm)

eiga.res <- residuals(eiga.lm)
eiga.pred <- predict(eiga.lm)
qplot(eiga.res, color = I("black"), fill = I("grey"))
qplot(eiga.pred, eiga$user) + geom_smooth(method = "lm")

#　関数 pairs(行列) で各列同士の組合せ全てについて散布図を描く
pairs(eiga)

#　重回帰モデルを作成
(eiga.lm <- lm(screen~.,data = eiga))

#　重回帰モデルの結果を確認する
summary(eiga.lm)

#　重回帰分析に入れるべき変数の選択をし、再度重回帰モデルを作成
eiga.lm.stepped<-step(eiga.lm)

#　再度重回帰モデルを確認する
summary(eiga.lm.stepped)

#重回帰で出した観測地と予測値
qplot(predict(eiga.lm.stepped), eiga$user) + geom_smooth(method = "lm")
