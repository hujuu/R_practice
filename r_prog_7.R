get_symbols <- function(){
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

get_symbols()

x <- -1
if(3 == 3){
  x <- 2
}
x

x <- 1
if(TRUE){
  x <- 2
}
x

x <- 1
if(x == 1){
  x <- 2
  if(x == 1){
    x <- 3
  }
}
x

a <- 3.14
dec <- a - trunc(a)
dec

if(dec >= 0.5){
  a <- trunc(a) + 1
}else{
  a <- trunc(a)
}
a

a <- 1
b <- 1

if(a > b){
  print("A win")
} else if( a < b ){
  print("B win")
} else {
  print("Tie")
}

get_symbols <- function(){
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

symbols <- get_symbols()
symbols

if(symbols[1] == symbols[2]){
  if(symbols[2] == symbols[3]){
    print("OK")
  }else{
    print("NG")
  }
}

score <- function (symbols) {
  #場合の確定
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  bars <- symbols %in% c("B","BB","BBB")
  
  if(same){
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])#賞金をルックアップ
  } else if(all(bars)) {
    prize <- 5 # 5ドル割り当て
  }else {
    cherries <- sum(symbols == "C")
    prize <- c(0,2,5)[cherries + 1]
    }
  
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}
score(symbols)

play <- function(){
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}

play()

symbols <- c("C","C","C")
one <- symbols[1] == "C"
two <- symbols[2] == "C"
three <- symbols[3] == "C"

one + two + three

symbols <- c("B","BB","BBB")

symbols[1] == "B"
symbols[2] == "B"
symbols
