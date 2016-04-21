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
eiga.lm <- lm(screen~.,data = eiga)
#　重回帰モデルの結果を確認する
summary(eiga.lm)
#　重回帰分析に入れるべき変数の選択をし、再度重回帰モデルを作成
eiga.lm.stepped <- step(eiga.lm)
#　再度重回帰モデルを確認する
summary(eiga.lm.stepped)
#重回帰で出した観測地と予測値
qplot(predict(eiga.lm.stepped), eiga$user) + geom_smooth(method = "lm")
qplot(predict(eiga.lm.stepped), eiga$pay) + geom_smooth(method = "lm")
qplot(predict(eiga.lm.stepped), eiga$per_pay) + geom_smooth(method = "lm")
qplot(predict(eiga.lm.stepped), eiga$year) + geom_smooth(method = "lm")

#　重回帰モデルを作成
eiga_pay.lm <- lm(pay~.,data = eiga)
#　重回帰モデルの結果を確認する
summary(eiga_pay.lm)
#　重回帰分析に入れるべき変数の選択をし、再度重回帰モデルを作成
eiga_pay.lm.stepped <- step(eiga_pay.lm)
#　再度重回帰モデルを確認する
summary(eiga_pay.lm.stepped)
#重回帰で出した観測地と予測値
qplot(predict(eiga_pay.lm.stepped), eiga$user) + geom_smooth(method = "lm")

par(mfrow=c(1,2))
plot(eiga$year,eiga$user)
plot(eiga$year,eiga$pay)
qplot(user, pay, data = eiga) + geom_smooth(method = "lm")
eiga_single.lm <- lm(user~pay, data = eiga)
eiga_single.lm
summary(eiga_single.lm)
