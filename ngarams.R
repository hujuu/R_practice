# 形態素解析の結果をデータフレームresへ
res <- RMeCabFreq("reviews_cf20160706.csv")

# 例として最初の10データを表示。Info1/2は品詞情報、Freqは登場頻度
res[1:10,]

unique(res$Info1)

# resの2列目が"記号"であるデータを抽出。res[,2]で"Info1"列を参照
res[res[,2]=="記号",]

# 名詞だけを取り出してデータフレームres_nounへ
res_noun <- res[res[,2]=="名詞",]
nrow(res_noun)
res_noun[1:10,]

nrow(res_noun <- res[res[,2]=="名詞" & res[,4] > 1,])

# データフレームtextgramへ格納
textgram <- Ngram("reviews_cf20160706.csv", N = 2, type = 1, pos = c("名詞", "動詞"))

# Freq降順（多い順）でソート、データフレームtextgram_orderへ格納
textgram_order <- textgram[rev(order(textgram$Freq)),]

# 先頭15個を表示
head(textgram_order,15)
