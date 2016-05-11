library(reshape)

beer2 <- read.csv("R_practice/anova4b.csv")
beer2$number2 <- factor(beer2$number)
beer2$number2
beer3 <- beer2[,c("number2","beerAin", "beerAout",
                  "beerBin", "beerBout", "beerCin", "beerCout")]
beer3

beer4 <- melt(beer3, id="number2")
beer4
names(beer4) <- c("number2","condition","taste")
head(beer4)
beer4$place <- ifelse((beer4$condition=="beerAin"
                       |beer4$condition=="beerBin"
                       |beer4$condition=="beerCin"),"in","out")
head(beer4)

qbeer4$drink <- ifelse((beer4$condition=="beerAin"
                       | beer4$condition=="beerAout"),"beerA",
                      ifelse((beer4$condition=="beerBin"
                              |beer4$condition=="beerBout"),"beerB","beerC"))
class(beer4$drink)
class(beer4$place)

beer4$drink2 <- factor(beer4$drink)
beer4$drink2

beer4$place2 <- factor(beer4$place)
beer4$place2

beer5 <- beer4[,c("number2","drink2","place2","taste")]
head(beer5)

summary(aov(beer5$taste
            ~beer5$drink2*beer5$place2
            +Error(beer5$number2
                   +beer5$number2:beer5$drink2
                   +beer5$number2:beer5$place2
                   +beer5$number2:beer5$drink2,beer5$place2)))
