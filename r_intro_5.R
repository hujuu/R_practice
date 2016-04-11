test_data <- read.csv("read.csv")
test_data

cor.test(test_data$social,test_data$tv)

var.test(test_data$tv~test_data$sex)

t.test(test_data$tv~test_data$sex,var.equal = TRUE)

t.test(test_data$before, test_data$after,paired = TRUE)

table(test_data$local,test_data$in_out)

chisq.test(test_data$local,test_data$in_out)
