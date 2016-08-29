library(ggplot2)
qplot(mtcars$wt, mtcars$mpg)

plot(mtcars$wt, mtcars$mpg)

qplot(wt, mpg, data = mtcars)


plot(pressure$temperature, pressure$pressure, type = "l")
points(pressure$temperature, pressure$pressure)

lines(pressure$temperature, pressure$pressure/2, col = "red")
points(pressure$temperature, pressure$pressure/2, col = "red")

qplot(pressure$temperature, pressure$pressure, geom = "line")
qplot(temperature, pressure, data = pressure, geom = c("line","point"))
ggplot(pressure, aes(x = temperature, y = pressure)) + geom_line() + geom_point()
