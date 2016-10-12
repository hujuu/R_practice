koe <- read.csv("H18koe.csv")

koe[42,]

koe2 <- RMeCabDF(koe, "opinion")
koe2 <- docMatrixDF(koe$opinion)
koe2[300:303, 1:6]
koe3 <- docDF(koe, column = "opinion", type = 1)
koe3[300:303, 1:6]
