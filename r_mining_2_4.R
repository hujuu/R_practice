#データの読み込み
spambase <- read.csv("../../spambase/spambase.data", header = F)

#変数名の追加
colnames(spambase) <- read.table("../../spambase/spambase.names",
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
