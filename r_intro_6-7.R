library(reshape)

beer2 <- read.csv("R_practice/anova4b.csv")
beer2$number2 <- factor(beer2$number)
beer2$number2
beer3 <- beer2[,c("number2","beerAin", "beerAout",
                  "beerBin", "beerBout", "beerCin", "beerCout")]
beer3

beer4 <- melt(beer3, id="number2")
beer4
