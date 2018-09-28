library(tidyverse)
library(lattice)
library(rvest)

jhk <- read_csv("Personnel_evaluation_result.csv", locale = locale(encoding = "CP932"))
head(jhk)
jhk <- read.csv("Personnel_evaluation_result.csv", encoding = "CP932")
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

jhk2 <- jhk[,varname]

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

scores_messy <- data.frame(名前 = c("生徒A", "生徒B"),
                             算数 = c(   100,    100),
                             国語 = c( 80, 100),
                             理科 = c( 60, 100),
                             社会 = c( 40, 20),
                             stringsAsFactors = FALSE   # 文字列が因子型に変換されないようにする 
                            )

scores_tidy <- gather(scores_messy,key = "教科", value = "点数",
                      # 新しくできる列の名前を指定 
                      算数, 国語, 理科, 社会)   # 変形する対象の列を指定 

# spread()で横長に戻す
spread(scores_tidy, key = 教科, value = 点数)

mpg %>%  
  # 列の絞り込み
  select(model, displ, year, cyl)

mpg %>%  # 列の絞り込み  
  select(manufacturer, model, displ, year, cyl) %>%  # 行の絞り込み  
  filter(manufacturer == "audi") %>%  # 新しい列を作成  
  mutate(century = ceiling(year / 100))
  
mpg %>%  arrange(cty) 

mpg %>%  arrange(cty, hwy) 
mpg %>%  arrange(desc(cty), desc(hwy))
mpg %>%  arrange(desc(cty, desc))
mpg %>%  rename(MODEL = model, TRANS = trans) 
mpg %>%  select(starts_with("c"))
mpg %>%  # cylそれぞれの値が6以上なら"6以上"、それ以外なら"6未満"、という列cty_6を追加  
  mutate(cty_6 = if_else(cyl >= 6, "6以上", "6未満")) 
mpg %>%  mutate(cty = if_else(cyl >= 6, "6以上", "6未満"))
mpg %>%  transmute(cty_6 = if_else(cyl >= 6, "6以上", "6未満"), year)
mpg %>%  mutate(century = ceiling(year/100),    # ceiling()は値を切り上げる関数 
                century_int = as.integer(century)   # ceiling()はの結果は数値型なので、整数型に変換  
                )
mpg %>%  summarise(displ_max = max(displ))

mpg_grouped <- mpg %>%  group_by(manufacturer, year)

mpg_grouped %>%  transmute(displ_rank = rank(displ, ties.method = "max")) 
mpg_grouped %>%  filter(n() >= 20) 
mpg_grouped %>%  summarise(displ_max = max(displ)) 

## runif()の結果を再現性あるものにするため、乱数のシードを固定 
set.seed(1) 
## runif()で0～100の範囲の乱数を10個ずつ生成 
d <- tibble(  id   = 1:10,  test1 = runif(10, max = 100),  test2 = runif(10, max = 100),  test3 = runif(10, max = 100),  test4 = runif(10, max = 100) ) 

d_tidy <- d %>%  # gather()でもselectのセマンティクス（コラム参照）が使える  
  gather(key = "test", value = "value", test1:test4)  
d_tidy 

d_tidy %>%  mutate(value = round(value))
d_tidy %>%  group_by(test) %>%  summarise(value_avg = mean(value))
d_tidy %>%  mutate(value = round(value)) %>%  spread(key = test, value = value) 

d %>%  mutate_all(round) 
mpg %>%  mutate_if(is.numeric, round)
d %>%  mutate_at(vars(-id), round)

# tibble()はtibbleを作成するための関数、data.frame()と違ってstringsAsFactors = FALSEは必要ない 
uriage <- tibble(day   = c(   1,   1,   2,   2,   3,   3,   4,   4),  # 日付  
                 store = c( "a", "b", "a", "b", "a", "b", "a", "b"),  # 店舗ID
                 sales = c( 100, 500, 200, 500, 400, 500, 800, 500)   # 売上額 
                 ) 
uriage
tenko <- tibble(day    = c(     1,     2,    3,     4),  
                rained = c( FALSE, FALSE, TRUE, FALSE) ) 
tenko
uriage %>%  inner_join(tenko, by = "day")
tenko2 <- tibble(DAY    = c(     1,     2,    3,     4),  
                 rained = c( FALSE, FALSE, TRUE, FALSE) ) 
uriage %>%  inner_join(tenko2, by = c("day" = "DAY"))
tenko3 <- tibble(DAY    = c(     1,     1,    2,    2,     3),
                 store  = c(    "a",  "b",  "a",  "b",   "b"),
                 rained = c( FALSE, FALSE, TRUE, FALSE, TRUE) ) 
uriage %>%  inner_join(tenko3, by = c("day" = "DAY", "store"))
uriage %>%  left_join(tenko3, by = c("day" = "DAY", "store"))

res <- uriage %>%  left_join(tenko3, by = c("day" = "DAY", "store")) # ベクトルなら、第2引数にはNAの代わりに入れる値を直接指定する 
res %>%  mutate(rained = replace_na(rained, FALSE)) 
# データフレームなら、第2引数には「列名 = NAの代わりの値」という形式のリストを指定する 
res %>%  replace_na(list(rained = FALSE)) 
res %>%  group_by(store) %>%  arrange(day) %>%  fill(rained) %>%  ungroup()
res %>%  group_by(store) %>%  arrange(day) %>%  fill(rained)
tenko4 <- tibble(day    = c(    2,    3,    3), 
                 store  = c(  "a",  "a",  "b"),  
                 rained = c( TRUE, TRUE, TRUE) ) 

combinations <- tenko4 %>%  # 絞り込みに使う列のみを選択
  select(day, store) %>%  # 各行を1つのリストに変換 
  transpose() 
uriage %>%  # 各行を1つのリストに変換  
  mutate(x = map2(day, store, ~ list(day = .x, store = .y))) %>%  # 一致する組み合わせがあるもののみに絞り込み 
  filter(x %in% !! combinations)

uriage %>%  semi_join(tenko4, by = c("day", "store"))
uriage %>%  inner_join(tenko4, by = c("day", "store"))

# インストールされていない場合
library(RColorBrewer) 
display.brewer.all()

# 左図 
ggplot(data = mpg, mapping = aes(x = drv, y = cty, fill = drv)) + geom_boxplot() +  scale_fill_brewer(palette = "Greys") 
# 右図 
ggplot(data = mpg, mapping = aes(x = drv, y = cty, fill = drv)) + geom_boxplot() +  scale_fill_brewer(palette = "Paired")
library(ggthemes) 
ggthemes_data$colorblind 
ggplot(data = mpg, mapping = aes(x = class, y = cty, fill = class)) +  geom_boxplot(show.legend = FALSE) +  scale_fill_colorblind()

by(jhk2, jhk$性別, apply, 2, mean)
by(jhk2, jhk$性別, apply, 2, mean)

zscore <- scale(jhk2)
head(zscore, 2)

tscore <- zscore*10 + 50
head(tscore, 2)

xyplot(知識~技能|年代+部署, data = jhk)
