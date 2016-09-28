library(gcookbook)
library(plyr)

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat = "identity") +
  guides(fill=guide_legend(reverse = TRUE))

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar, order=desc(Cultivar))) +
  geom_bar(stat = "identity")

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat = "identity", colour = "black") +
  guides(fill=guide_legend(reverse = TRUE)) +
  scale_fill_brewer(palette = "Pastel1")
