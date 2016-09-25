library(ggplot2)
ggplot(diamonds, aes(x=cut)) + geom_bar()
ggplot(diamonds, aes(x=carat)) + geom_bar()

library(gcookbook)
uspopchange
upc <- subset(uspopchange, rank(Change)>40)
upc

ggplot(upc, aes(x=Abb, y=Change, fill=Region)) +
  geom_bar(stat = "identity")

# reorder関数で並び替えをする
ggplot(upc, aes(x=reorder(Abb, Change), y=Change, fill=Region)) +
  geom_bar(stat = "identity", colour = "black") +
  scale_fill_manual(values = c("#669933", "#FFCC66")) +
  xlab("State")
