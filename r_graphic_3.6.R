library(gcookbook)

ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat = "identity")

ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_bar(stat = "identity", width = 0.5)

ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_bar(stat = "identity", width = 1)

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat = "identity", width = 0.5, position = "dodge")

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat = "identity", width = 0.5, position = position_dodge(0.7))
