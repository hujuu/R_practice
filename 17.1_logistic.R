require(ggplot2)
# install.packages("useful")
require(useful)
# install.packages("coefplot")
require(coefplot)

acs <- read.table("http://jaredlander.com/data/acs_ny.csv", sep = ",",
                  header = TRUE, stringsAsFactors = FALSE)

acs$income <- with(acs, FamilyIncome >= 150000)

ggplot(acs, aes(x = FamilyIncome)) +
  geom_density(fill = "grey", color = "grey") +
  geom_vline(xintercept = 150000) +
  scale_x_continuous(label = multiple.dollar, limits = c(0,1000000))

head(acs)

income1 <- glm(income ~ HouseCosts + NumWorkers + OwnRent +
                 NumBedrooms + FamilyType, data = acs, family = binomial(link = "logit"))

summary(income1)

coefplot(income1)

invlogit <- function(x){
  1/(1+exp(-x))
}
invlogit(income1$coefficients)
