rolls <- expand.grid(die, die)
rolls$value <- rolls$Var1 + rolls$Var2
prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)
rolls$Var1
prob[rolls$Var1]
rolls$prob1 <- prob[rolls$Var1]
rolls$prob2 <- prob[rolls$Var2]

rolls$prob <- rolls$prob1 * rolls$prob2

sum(rolls$value * rolls$prob)

rolls

wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
wheels <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)

get_symbols <- function(){
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03,0.03,0.06,0.1,0.25,0.01,0.52))
}
get_symbols()

combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
prob <- c("DD" = 0.03,"7" = 0.03, "BBB" = 0.06, "BB" = 0.1,
          "B" = 0.25, "C" = 0.01, "0" = 0.52)
combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]

combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
sum(combos$prob)

combos$prize <- NA

for(i in 1:nrow(combos)){
  symbols <- c(combos[i,1],combos[i,2],combos[i,3])
  combos$prize[i] <- score(symbols)
}

sum(combos$prize * combos$prob)

score <- function (symbols) {
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  
  #ケースの確定
  #ダイヤはワイルドカードなので、同じシンボルが3つ揃っているか、
  #3つもバーになっているかはダイヤ以外で考える
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")
  
  #賞金の計算
  if (diamonds == 3){
    prize <- 100
  }else if(same){
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[slots[1]])#賞金をルックアップ
  } else if(all(bars)) {
    prize <- 5 # 5ドル割り当て
  }else if(cherries > 0){
    #本物のチェリーがあるときに限り
    #ダイヤをチェリーとしてカウント
    #cherries <- sum(symbols == "C")
    prize <- c(0,2,5)[cherries + diamonds + 1]
  }else { 
    prize <- 0
    }
  
  #diamonds <- sum(symbols == "DD")
  #ダイヤによる賞金の加算（1個ごとに2倍）
  prize * 2 ^ diamonds
}
symbols
score(symbols)