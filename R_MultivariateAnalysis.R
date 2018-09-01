library(tidyverse)
library(lattice)
library(rvest)

jhk <- read_csv("Personnel_evaluation_result.csv", locale = locale(encoding = "CP932"))
head(jhk)

histogram(~ストレス, data = jhk, breaks = 20, type = "count")

mean(jhk$ストレス)

median(jhk$ストレス)

sort(table(jhk$年代))

sd(jhk$ストレス)

var(jhk$ストレス)

mean(abs(jhk$ストレス-median(jhk$ストレス)))

histogram(~協調性|年代+性別, data = jhk, breaks = 15)

tapply(jhk$協調性, jhk$性別, mean)

boxplot(jhk$技能, horizontal = TRUE)

boxplot(協調性~性別, data = jhk, horizontal = TRUE)

varname <- c("協調性", "自己主張", "技能", "知識")

jhk2 <- jhk

apply(jhk2, 2, mean)

# URLは変数にしておく 
kabu_url <- "https://kabutan.jp/stock/kabuka?code=0000"
# スクレイピングしたいURLを読み込む 
url_res <- read_html(kabu_url) 

# URL の読み込み結果から、title要素を抽出 
url_title <- html_nodes(url_res, xpath = "/html/head/title") 
url_title

# 抽出した要素を文字列に変換
title <- html_text(url_title)

title2 <- read_html(kabu_url) %>%  html_nodes(xpath = "/html/head/title") %>%  html_text() 

1:10 %>%  sum()

# パイプ演算子を使わない場合 
url_res <- read_html(kabu_url) 
url_title <- html_node(url_res, css = "title") 
title <- html_text(url_title)

# パイプ演算子を使う場合 
title2 <- read_html(kabu_url) %>%  html_node(css = "title") %>%  html_text()

kabuka <- read_html(kabu_url) %>%  html_node(xpath = "//*[@id='stock_kabuka_table']/table[2]") %>% # コピーした XPath を指定  
  html_table() 
# 先頭 10 行を表示 
head(kabuka, 10)

# for文の中で要素を付け加えておくオブジェクトは 
# for文の外にあらかじめ空のオブジェクトの用意が必要となる 
urls <- NULL 
kabukas <- list() 

# ページ番号抜きのURLを用意する 
base_url <- "https://kabutan.jp/stock/kabuka?code=0000&ashi=day&page=" 
# 1～5に対して同じ処理を繰り返す 
for (i in 1:5) { 
  # ページ番号付きのURLを作成 
  pgnum <- as.character(i)
  urls[i] <- paste0(base_url, pgnum) 
  # それぞれのURLにスクレイピングを実行
  kabukas[[i]] <- read_html(urls[i]) %>%  html_node(xpath = "//*[@id='stock_kabuka_table']/table[2]") %>% html_table() %>% dplyr::mutate_at("前日比", as.character) 
  # 前日比の列はいったん文字列で読んでおく 
  # 1ページ取得したら1秒停止 
  Sys.sleep(1)
}

# データフレームのリストを縦につなげて1つのデータフレームに
dat <- dplyr::bind_rows(kabukas) 

