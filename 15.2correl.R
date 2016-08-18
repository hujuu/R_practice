require(ggplot2)
require(reshape2)
require(scales)

#相関マトリックスを作成
econCor <- cor(economics[,c(2,4:6)])

#ロングフォーマットへ加工
econMelt <- melt(econCor, varnames = c("x", "y"),
                 value.name = "Correlation")

#相関係数順にソート
econMelt <- econMelt[order(econMelt$Correlation), ]

##ggplotで作画
# x,yをx軸、y軸へ設定
ggplot(econMelt, aes(x = x, y = y)) +
  geom_tile(aes(fill = Correlation)) +
  scale_fill_gradient2(low = muted("red"), mid = "white", high = "steelblue",
                       guide = guide_colourbar(ticks = FALSE, barheight = 10),
                       limits = c(-1,1)) + theme_minimal() + labs(x = NULL, y = NULL)
