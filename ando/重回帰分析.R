#  ファイルの読み込み
dat <- read.table("clipboard",header=TRUE)

#  読み込みの確認
dat

#　関数 pairs(行列) で各列同士の組合せ全てについて散布図を描く
pairs(dat)

#　重回帰モデルを作成
(dat.lm<-lm(Rev~.,data=dat))

#　重回帰モデルの結果を確認する
summary(dat.lm)

#　重回帰分析に入れるべき変数の選択をし、再度重回帰モデルを作成
dat.lm.stepped<-step(dat.lm)

#　再度重回帰モデルを確認する
summary(dat.lm.stepped)
