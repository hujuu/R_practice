x <- sample(x = 1:100, size = 100, replace = TRUE)
x
mean(x)

y <- x
y[sample(x = 1:100, size = 20, replace = FALSE)] <- NA
y
mean(y)
mean(y, na.rm = TRUE)

grades <- c(95, 72, 87, 66)
weights <- c(1/2, 1/4, 1/8, 1/8)
mean(grades)
weighted.mean(x = grades, w = weights)

var(x)
sum((x - mean(x))^2 / (length(x) - 1))

sqrt(var(x))
sd(x)
sd(y)
sd(y, na.rm = TRUE)
median(x)

summary(x)

#第一、第三分位点を計算する
quantile(x, probs = c(0.25, 0.75))
