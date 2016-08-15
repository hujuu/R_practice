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
tw.txt <- tw.txt[-grep("\n", tw.txt)] #改行文字の削除

tw.dmat <- docMatrixDF(tw.txt, pos = c("名詞"))
dim(tw.dmat)

tw.wcnt <- as.data.frame(apply(tw.dmat, 1, sum))
tw.wcnt <- tw.wcnt[
  !(row.names(tw.wcnt) %in% unlist(strsplit(searchword, " "))),
  1, drop = FALSE
  ]
tw.wcnt2 <- data.frame(word = as.character(row.names(tw.wcnt)),
                       freq = tw.wcnt[,1])
tw.wcnt2 <- subset(tw.wcnt2, rank(-freq)<25)
ggplot(tw.wcnt2, aes(x = reorder(word, freq), y = freq)) +
  geom_bar(stat = "identity", fill = "grey", color = "black") +
  theme_bw(base_size = 10, base_family = "HiraKakuProN-W3") +
  coord_flip() + xlab("word")

tw.wcnt <- subset(tw.wcnt, tw.wcnt[, 1] >= 50)
pal <- brewer.pal(8, "Dark2")
par(family = "HiraKakuProN-W3")
wordcloud(row.names(tw.wcnt),tw.wcnt[, 1], scale = c(4, .2),
          random.order = T, rot.per = .15, colors = pal)
