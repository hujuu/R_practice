install.packages("twitteR")
install.packages("ROAuth")
install.packages("base64enc")

library(twitteR)
library(ROAuth)
library(base64enc)

APIkey <- "F0pJ7zJ3bHvH9MXDLmMKGxSyw"
APISecret <- "iZc1dYtqYmXQUgKua6QxrLbBYZxBDDxqyX8pfKF5FVZeMCDmHE"
accessToken <- "44802149-6YGOp5tcuk9F8G4sWO34ADC4jYvgzfaignzsJSi7p"
accessSecret <- "CjMLAd9M2wuhBQGchLvxQDMM84FqCPoj4LXFMnv6cDFty"

setup_twitter_oauth(APIkey, APISecret, accessToken, accessSecret)

searchword <- "ガラケー　スマホ"
searchquery <- paste0(searchword, " AND -filter:links AND -RT")
tw.df <- twListToDF(searchTwitter(searchquery,
                                  since = as.character(Sys.Date()-8),
                                  until = as.character(Sys.Date()),
                                  n = 10000))

names(tw.df)

library(dplyr)
library(ggplot2)

tw.daily <- tw.df %>%
  mutate(twdate = as.Date(created)) %>%
  group_by(twdate) %>% summarize(cnt = n())

tw.daily

# 日別の集計
qplot(as.Date(created), data=tw.df, geom="bar", xlab="twdate", ylab="cnt")
## http://prunus1350.hatenablog.com/entry/2015/12/30/222837
# 本に元々載っているコードは動かない
qplot(twdate, cnt, data = tw.daily, geom = "bar", stat = "identity")


# 時間別の集計
tw.hourly <- tw.df %>%
  mutate(twhour=as.POSIXct(format(created, "%Y-%m-%d %H:00:00"))) %>%
  group_by(twhour) %>% summarize(cnt = n())
tw.hourly
qplot(twhour, cnt, data=tw.hourly, geom="bar", stat="identity")

# 時間別の集計
install.packages("lubridate")
library(lubridate)
qplot(floor_date(created, "hour"),
      data=tw.df, geom="bar", xlab="twhour", ylab="cnt")
