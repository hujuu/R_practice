library(gcookbook)
cabbage_exp

# 書籍にはstat = "identity"が抜けているので入れる
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill = Cultivar)) +
  geom_bar(stat = "identity",position = "dodge")


#x軸に日付と品種、y軸に重さを指定する
cabbageMap <- ggplot(cabbage_exp,
                     aes(x=interaction(Date,Cultivar),y=Weight))
#幾何オブジェクトに、棒グラフを指定する
chartType <- geom_bar(stat="identity")

#色が白で、位置が1.5
chartLabel <- geom_text(aes(label = Weight), vjust=1.5,colour = "white")

cabbageMap + chartType + chartLabel

#マッピングと幾何オブジェクトを指定する
cabbageGroupedBarChart <-
  ggplot(cabbage_exp, aes(x = Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat = "identity", position = "dodge")
#グラフを描画する
cabbageGroupedBarChart
