attributes(DECK)
row.names(DECK)
row.names(DECK) <- 101:152
levels(DECK) <- c("level 1", "level 2", "level 3")

play()
one_play <- play()
one_play
attributes(one_play)
attr(one_play, "symbols") <- c("B", "0", "B")
attr(one_play, "symbols")

play <- function(){
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}

two_play <- play()
two_play

play <- function(){
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
three_play <- play()
three_play

slot_display <- function(prize){
  #シンボルの抽出
  symbols <- attr(prize, "symbols")
  
  #symbolsを１つの文字列に変換
  symbols <- paste(symbols, collapse = " ")
  
  #シンボルと賞金額を正規表現として結合
  # ¥nは改行（つまりReturn）の正規表現
  string <- paste(symbols, prize, sep = "\n$")
  
  #クオートなしでコンソールに正規表現を表示
  cat(string)
}

slot_display(one_play)

symbols <- attr(one_play, "symbols")
symbols
symbols <- paste(symbols, collapse = " ")
prize <- one_play
string <- paste(symbols, prize, sep = "\n$")
string
cat(string)

slot_display(play())

print.slots <- function(x, ...){
  slot_display(x)
}
class(one_play) <- "slots"
one_play

play <- function(){
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}
class(play())
play()

methods(class = "factor")
play1 <- play()
play1[1]
