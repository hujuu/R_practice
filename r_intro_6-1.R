sleep1 <- read.csv("R_practice/anoval.csv")
tapply(sleep1$time, sleep1$club, mean)
