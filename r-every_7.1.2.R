install.packages("ggplot2")
require(ggplot2)
data("diamonds")
head(diamonds)

plot(price ~ carat, data = diamonds)
plot(diamonds$carat, diamonds$price)

g <- ggplot(diamonds, aes(x = carat, y = price))
g + geom_point(aes(color = color))

#関数の定義
check.bool <- function(x){
  if(x == 1){
    print("hello")
  }else{
    print("goodbye")
  }
}
check.bool(1)
check.bool(2)

#関数の定義2
check.bool <- function(x){
  if(x == 1){
    print("hello")
  }else if(x == 0){
    print("goodbye")
  }else{
    print("confused")
  }
}
check.bool(1)
check.bool(2)
