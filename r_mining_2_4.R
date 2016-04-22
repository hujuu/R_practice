#データの読み込み
#spambase <- read.csv("../../spambase/spambase.data", header = F)
spambase <- read.csv("spambase/spambase.data", header = F)

#変数名の追加
#colnames(spambase) <- read.table("../../spambase/spambase.names",
#                                 skip = 33, sep = ":", comment.char = "")[,1]
colnames(spambase) <- read.table("spambase/spambase.names",
                                 skip = 33, sep = ":", comment.char = "")[,1]
colnames(spambase)[ncol(spambase)] <- "spam"

library(ggplot2)
qplot(word_freq_your, spam, data = spambase, alpha=I(0.03))

library(dplyr)
spambase %>%
  group_by(spam) %>%
    summarise(count = n(),
              med = median(word_freq_your),
              mean = mean(word_freq_your),
              sd = sd(word_freq_your))

spam.your.lm <- lm(spam ~ word_freq_your, data = spambase)
summary(spam.your.lm)

qplot(word_freq_your, spam,
                   data = spambase, alpha=I(0.03)) + geom_smooth(method = "lm")

spam.your.lst <- glm(spam ~ word_freq_your,
                     data = spambase, family = "binomial")
spam.your.lst

a <- coef(spam.your.lst)[2]
b <- coef(spam.your.lst)[1]
lst.fun <- function(x){
  1/(1+exp(-(a*x+b)))
}
qplot(word_freq_your, spam,
      data = spambase, alpha=I(0.03), xlim = c(-5,15)) + 
  stat_function(fun = lst.fun, geom = "line")

spam.your.pred <- predict(spam.your.lst, type = "resp")
(tb <- table(spam = spambase$spam, pred = round(spam.your.pred)))
1-sum(diag(tb))/sum(tb)

spam.glm <- glm(spam~., data = spambase, family = "binomial")
summary(spam.glm)

#変数選択をおこなって、予測に最適なモデルを求めます
library(MASS)
(spam.glm.best <- stepAIC(spam.glm))
summary(spam.glm.best)

spam.best.pred <- predict(spam.glm.best, type = "resp")
(tb.best <- table(spam = spambase$spam, pred = round(spam.best.pred)))
1-sum(diag(tb.best))/sum(tb.best)
