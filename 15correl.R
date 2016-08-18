require(ggplot2)
head(economics)

cor(economics$pce, economics$psavert)

#それぞれのパートを計算
xPart <- economics$pce - mean(economics$pce)
yPart <- economics$psavert - mean(economics$psavert)
nMinusOne <- (nrow(economics)-1)
xSD <- sd(economics$pce)
ySD <- sd(economics$psavert)
#相関式を使う
sum(xPart * yPart) / (nMinusOne * xSD * ySD)

cor(economics[,c(2,4:6)])

# install.packages("GGally")
GGally::ggpairs(economics, economics[,c(2,4:6)], parm = list(labelSize = 8))
