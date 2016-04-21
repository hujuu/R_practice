# RCurlのインストール
install.packages("RCurl", dep=TRUE)
#ファイルの読み込み
dat <- read.csv("../../eiga.csv")
# 相関係数行列を表示
round(cor(dat), 2)　
#round( データ, 小数点以下表示桁数 ) データを指定された桁に丸める
#　散布図行列を表示
pairs(dat)
#　psychのインストール
install.packages("psych",　dep=TRUE)
library(psych)
#散布図行列を表示
pairs.panels(dat, smooth=FALSE, density=FALSE, ellipses=FALSE)
#smooth: 平滑線の描画の有無（今回は表示しない）
#density: ヒストグラムにカーネルを重ねるかの有無（今回は重ねない）
#ellipses: 散布図に相関を円で表したものを表示するか否か（今回は表示しない）