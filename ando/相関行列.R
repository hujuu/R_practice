# RCurlのインストール
install.packages("RCurl", dep=TRUE)

#ファイルの読み込み
dat <- read.table("clipboard",header=TRUE)

# 相関係数行列
round(cor(dat), 2)

#　散布図行列を表示
pairs(dat)

#　psychのインストール
install.packages("psych",　dep=TRUE)
library(psych)

#散布図行列を表示
pairs.panels(dat, smooth=FALSE, density=FALSE, ellipses=FALSE, scale=FALSE)