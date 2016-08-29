require(ggplot2)
require(useful)
require(coefplot)

ggplot(acs, aes(x = NumChildren)) + geom_histogram(binwidth = 1)

children1 <- glm(NumChildren ~ FamilyIncome + FamilyType + OwnRent,
                 data = acs, family = poisson(lin = "log"))
summary(children1)
coefplot(children1)

#残差を標準化
z <- (acs$NumChildren - children1$fitted.values) / sqrt(children1$fitted.values)

#過分散ファクター
sum(z^2) / children1$df.residual

#過分散p値
pchisq(sum(z^2), children1$df.residual)

children2 <- glm(NumChildren ~ FamilyIncome + FamilyType + OwnRent,
                 data = acs, family = quasipoisson(lin = "log"))
multiplot(children1, children2)
