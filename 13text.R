require(XML)
load("data/presidents.rdata")
#URLが間違っているので先に行けない
theURL <- "http://www.loc.gov/rr/print/list/057_chron.thml"
presidents <- readHTMLTable(theURL, which = 3, as.data.frame = TRUE,
                            skip.rows = 1, header = TURE,
                            stringAsFactors = FALSE)

rnorm(n = 10)

rnorm(n = 10, mean = 100, sd = 20)

randNorm10 <- rnorm(10)
randNorm10
dnorm(randNorm10)

dnorm(c(-1, 0, 1))

#正規分布からデータを生成
randNorm <- rnorm(30000)
randDensity <- dnorm(randNorm)
require(ggplot2)
ggplot(data.frame(x = randNorm, y = randDensity)) +
  aes(x = x, y = y) + geom_point() + labs(x = "Random Normal Variables", y = "Density")

pnorm(randNorm10)
pnorm(c(-3,0,3))
pnorm(-1)
pnorm(1) - pnorm(0)
pnorm(1) - pnorm(-1)
