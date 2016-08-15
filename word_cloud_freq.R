library(twitteR)
library(ROAuth)
library(dplyr)
library(ggplot2)
library(lubridate)
library(RMeCab)
library(wordcloud)
library(RColorBrewer)

APIkey <- "F0pJ7zJ3bHvH9MXDLmMKGxSyw"
APISecret <- "iZc1dYtqYmXQUgKua6QxrLbBYZxBDDxqyX8pfKF5FVZeMCDmHE"
accessToken <- "44802149-6YGOp5tcuk9F8G4sWO34ADC4jYvgzfaignzsJSi7p"
accessSecret <- "CjMLAd9M2wuhBQGchLvxQDMM84FqCPoj4LXFMnv6cDFty"

setup_twitter_oauth(APIkey, APISecret, accessToken, accessSecret)

searchword <- "スマホ ガラケー"
searchquery <- paste0(searchword, "AND -filter:links AND -RT")
tw.df <- twListToDF(searchTwitter(searchquery,
                                  since = as.character(Sys.Date()-8),
                                  until = as.character(Sys.Date()),
                                  n = 5000))

names(tw.df)


tw.txt <- unique(tw.df$text)
tw.txt <- gsub("[[:print:]]", "", tw.txt, perl = TRUE)
tw.txt <- tw.txt[-grep("^RT", tw.txt)]

# 一時ファイル名を取得
filename <- tempfile("CustomerVoice")
# ファイルに書き出し
write.table(tw.txt,
            file=filename,
            row.names=F,
            col.names=F,
            quote=F)
# 品詞分解と単語の出現頻度をカウント
freq <- RMeCabFreq(filename)

# 名詞のみを抽出
freq <- freq[freq$Info1=="名詞",]

# 抽出結果の先頭 12 行を表示
head(freq[order(freq$Freq, decreasing=T),], n=12)

# 数名詞、非自立名詞、接尾名詞を除去
freq <- freq[!freq$Info2 %in% c("数","非自立","接尾"),]

# 検索語の削除
freq <- freq[!freq$Term %in% c("ガラケー","スマホ"),]

# 2 文字以上の単語のみを抽出
freq <- freq[nchar(freq$Term)>2,]
# 異なる品詞、同じ単語を整理
freq.term<-unique(freq$Term)
freq.sum <- lapply(freq.term,function(x){sum(freq[freq$Term==x,]$Freq)})
# データフレームに格納
freq <- data.frame(Term=freq.term,Freq=unlist(freq.sum))

# 頻度の高い順に並び替え
freq <- freq[order(freq$Freq, decreasing=T),]
# 頻度の上位 100 件を抽出
freq.head<-head(freq, n=100)
# カラースケールを Dark2 に設定
pal <- brewer.pal(8, "Dark2")
# wordcount 関数でプロット
par(family = "HiraKakuProN-W3")
wordcloud(freq.head$Term, freq.head$Freq, random.color=T,
          colors=pal)
