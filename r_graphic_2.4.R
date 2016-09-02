hist(mtcars$mpg)

# bin
hist(mtcars$mpg, breaks = 10)

qplot(mtcars$mpg)

library(ggplot2)
qplot(mpg, data = mtcars, binwidth = 4)
ggplot(mtcars, aes(x = mpg)) + geom_histogram(binwidth = 4)
