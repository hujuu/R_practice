bike <- read.csv("Bike-Sharing-Dataset/day.csv")

library(ggplot2)
qplot(atemp, cnt, data = bike)
qplot(atemp, cnt, data = bike) + geom_smooth(method = "lm")
bike.lm <- lm(cnt~atemp, data = bike)
bike.lm
summary(bike.lm)
bike.res <- residuals(bike.lm)
bike.pred <- predict(bike.lm)
qplot(bike.res, binwidth = 500, color = I("black"), fill = I("grey"))
qplot(bike.pred, bike$cnt) + geom_smooth(method = "lm")
