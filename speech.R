library(RMeCab)
library(ggplot2)

# 解析対象となるデータの読み込み
res <- RMeCabFreq("steve-jobs-speech.txt")

# 名詞だけを取り出してデータフレームres_nounへ
res_noun <- res[res[,2]=="名詞",]

# 2回以上登場する名詞の数。res[,4]で"Freq"列を参照
nrow(res_noun <- res[res[,2]=="名詞" & res[,4] > 1,])

# res_nounをFreqで降順ソート
res_noun[rev(order(res_noun$Freq)),]

res_noun2 <- data.frame(word=as.character(res_noun[,1]),
                        freq=res_noun[,4])

# 上位25位に絞り込む
res_noun2 <- subset(res_noun2, rank(-freq)<25)

ggplot(res_noun2, aes(x=reorder(word,freq), y=freq)) +
  geom_bar(stat = "identity", fill="grey") +
  theme_bw(base_size = 10, base_family = "HiraKakuProN-W3") +
  coord_flip()
