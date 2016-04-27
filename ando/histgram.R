#ファイルの読み込み
dat <- read.csv("eiga.csv",header=TRUE)
plot(dat)
hist(dat)
dat$screen
plot(dat$year,dat$screen)

summary(dat$screen)

#グラフ描写のセット
par(mfrow=c(2,4))

#ヒストグラムの作成
hist(dat[,2], breaks = "Scott", xlab="", main="screen")
abline(v=dat[10,2],lty=1,col=2,lwd=3)
abline(v=dat[11,2],lty=1,col=4,lwd=3)

hist(dat[,3], breaks = "Scott", xlab="", main="持ち家比率 %")
abline(v=dat[10,3],lty=1,col=2,lwd=3)
abline(v=dat[11,3],lty=1,col=4,lwd=3)

hist(dat[,5], breaks = "Scott", xlab="", main="建設業者1万社あたりKDP店舗数")
abline(v=dat[10,5],lty=1,col=2,lwd=3)
abline(v=dat[11,5],lty=1,col=4,lwd=3)

hist(dat[,6], breaks = "Scott",  xlab="", main="建設業者1万社あたり競合店数")
abline(v=dat[10,6],lty=1,col=2,lwd=3)
abline(v=dat[11,6],lty=1,col=4,lwd=3)

hist(dat[,7], breaks = "Scott", xlab="", main="道路付け")
abline(v=dat[10,7],lty=1,col=2,lwd=3)
abline(v=dat[11,7],lty=1,col=4,lwd=3)

hist(dat[,11], breaks = "Scott", xlab="", main="店舗売場面積")
abline(v=dat[10,11],lty=1,col=2,lwd=3)
abline(v=dat[11,11],lty=1,col=4,lwd=3)

hist(dat[,12], breaks = "Scott", xlab="", main="店舗経過年数")
abline(v=dat[10,12],lty=1,col=2,lwd=3)
abline(v=dat[11,12],lty=1,col=4,lwd=3)
