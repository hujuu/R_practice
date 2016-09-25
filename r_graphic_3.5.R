library(ggplot2)
library(gcookbook)

csub <- subset(climate, Source == "Berkeley" & Year >= 1900)
csub$pos <- csub$Anomaly10y >= 0

csub

ggplot(csub, aes(x = Year, y = Anomaly10y, fill=pos)) +
  geom_bar(stat = "identity", position = "identity") +
  scale_fill_manual(values = c("#CCEEFF", "#FFDDDD"), guide = FALSE)
