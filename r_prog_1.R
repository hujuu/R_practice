die <- 1:6
die
dice <- sample(x = die, size = 2, replace = TRUE)
sum(dice)

roll <- function(){
  die <- 1:6
  dice <- sample(x = die, size = 2, replace = TRUE)
  sum(dice)
}
roll()