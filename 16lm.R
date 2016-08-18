# install.packages("UsingR")
require(UsingR)
require(ggplot2)
head(father.son)
ggplot(father.son, aes(x = fheight, y = sheight)) + geom_point() +
  geom_smooth(method = "lm") + labs(x = "Fathers", y = "sons")

heightLM <- lm(sheight ~ fheight, data = father.son)
heightLM

summary(heightLM)
