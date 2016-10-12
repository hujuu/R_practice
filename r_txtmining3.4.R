library(RMeCab)

source("R_practice/Aozora.R")
Aozora("http://www.aozora.gr.jp/cards/001779/files/57343_ruby_59977.zip",
       "kagami.txt")
Aozora("http://www.aozora.gr.jp/cards/001779/files/56648_ruby_58198.zip",
       "isu.txt")

dm <- docMatrix("NORUBY")

head(dm)

dm <- dm[rownames(dm) != "[[LESS-THAN-1]]", ]
dm <- dm[rownames(dm) != "[[TOTAL-TOKENS]]", ]

# TF-IDF
dm2 <- docMatrix2("NORUBY", pos = c("名詞", "形容詞"), weight = "tf*idf")
head(dm2)

# 正規化
dm2 <- docMatrix2("NORUBY", pos = c("名詞", "形容詞"),
                  weight = "tf*idf*norm")
colSums(dm2^2)

bigram <- docNgram2("NORUBY") # n-gramの頻度行列
head(bigram)

bigram <- docDF("NORUBY", type = 1, N = 2)
head(bigram)

bigram <- docDF("NORUBY", type = 1, N = 2, nDF = TRUE)
