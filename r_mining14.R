library(XML)
library(RFinanceYJ)

quote.url <-
  "http://info.finance.yahoo.co.jp/history/?code=998407&sy=2016&sm=8&sd=1&ey=2016&em=8&ed=31&tm=d"
t <-readHTMLTable(quote.url)
nikkei <- t[[2]]
head(nikkei)

nikkei.date <- as.character(nikkei[,1])
nikkei.date <- as.Date(nikkei.date, format="%Y年%m月%d日")
owarine <- as.numeric(sub(",","", nikkei[,5]))
plot(nikkei.date, owarine, type = "l")
