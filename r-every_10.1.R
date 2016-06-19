#フルーツの名前を持っているベクトルを作成
fruit <- c("apple", "banana", "pomegranate")

#フルーツベクトルの長さの分だけ、初期値としてNAをもつ変数を作る
fruitLength <- rep(NA, length(fruit))

#結果を表示する。全てNAとなる
fruitLength

#名前を与える
names(fruitLength) <- fruit

fruitLength

for(a in fruit){
  fruitLength[a] <- nchar(a)
}

fruitLength2 <- nchar(fruit)
names(fruitLength2) <- fruit
fruitLength2

identical(fruitLength, fruitLength2)

x <- 1
while(x <= 5){
  print(x)
  x <- x + 1
}

for(i in 1:10){
  if(i == 3){
    next
  }
  print(i)
}

for(i in 1:10){
  if(i == 4){
    break
  }
  print(i)
}
