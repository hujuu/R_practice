library(dplyr)

bike <- read.csv("../../Bike-Sharing-Dataset/day.csv")

bike.cat <- bike %>%
  select(season:weathersit) %>%
  mutate_each(funs(factor))

install.packages("caret")
install.packages("pbkrtest")
library(caret)
tmp <- dummyVars(~., data = bike.cat)
bike.dum <- predict(tmp, bike.cat)

bike01 <- cbind(select(bike, temp:windspeed,cnt), bike.dum)
bike.lm.0 <- lm(cnt~., data = bike01)
summary(bike.lm.0)

library(MASS)
bike.lm.1 <- stepAIC(bike.lm.0)
bike.lm.1
summary(bike.lm.1)

qplot(residuals(bike.lm.1), binwidth = 500,
      color = I("black"), fill = I("grey"))
qplot(predict(bike.lm.1), bike$cnt) + geom_smooth(method = "lm")
