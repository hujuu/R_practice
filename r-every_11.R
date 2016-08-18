#行列を作成する
theMatrix <- matrix(1:9, nrow = 3)
#行に関しての和を計算する
apply(theMatrix, 1, sum)
#列の和を計算する
apply(theMatrix, 2, sum)

theMatrix[2, 1] <- NA
apply(theMatrix, 1, sum)
apply(theMatrix, 1, sum, na.rm = TRUE)

rowSums(theMatrix)

rowSums(theMatrix, na.rm = TRUE)

theMatrix

theList <- list(A = matrix(1:9, 3), B = 1:5, C = matrix(1:4, 2), D = 2)
lapply(theList, sum)

sapply(theList, sum)

theNames <- c("Jared", "Deb", "Paul")
lapply(theNames, nchar)

##2つのリストを作成
firstList <- list(A = matrix(1:16, 4), B = matrix(1:16, 2), C = 1:5)
secondList <- list(A = matrix(1:16,4), B = matrix(1:16, 8), C = 15:1)
#要素ごとに一致するかを確認する
mapply(identical, firstList, secondList)
##引数それぞれの行数または長さを加算する関数を作成する
simpleFunc <- function(x, y){
  NROW(x) + NROW(y)
}

#2つのリストに対して、作成した関数を適用する
mapply(simpleFunc, firstList, secondList)

# install.packages("ggplot2")
require(ggplot2)
data("diamonds")
head(diamonds)
aggregate(price ~ cut, diamonds, mean)
aggregate(price ~ cut + color, diamonds, mean)
aggregate(cbind(price, carat) ~ cut, diamonds, mean)
aggregate(cbind(price, carat) ~ cut + color, diamonds, mean)


require(plyr)
head(baseball)
#[を使って代入するほうが、ifelseを使うよりも早い
baseball$sf[baseball$year < 1954] <- 0
#NAのデータがあるかを確認
any(is.na(baseball$sf))
#NAとなっているHBPを0と設定する
baseball$hbp[is.na(baseball$hbp)] <- 0
#NAのデータがあるかを確認
any(is.na(baseball$hbp))
#あるシーズンにおいて少なくとも50打数以上ある選手のみを抽出
baseball <- baseball[baseball$ab >= 50, ]

#出塁率を計算する
baseball$OBP <- with(baseball, (h + bb + hbp) / (ab + bb + hbp + sf))
tail(baseball)

obp <- function(data){
  c(OBP = with(data, sum(h + bb + hbp) / sum(ab + bb + hbp + sf)))
}
#それぞれの選手に対して、生涯出塁率を計算するためにddplyを用いる
carrerOBP <- ddply(baseball, .variables = "id", .fun = obp)
#出塁率で結果を並び替える
carrerOBP <- carrerOBP[order(carrerOBP$OBP, decreasing = TRUE), ]
#結果を表示させる
head(carrerOBP, 10)

theList <- list(A = matrix(1:9, 3), B = 1:5, C = matrix(1:4, 2), D = 2)
lapply(theList, sum)
llply(theList, sum)
identical(lapply(theList, sum), llply(theList, sum))
sapply(theList, sum)
laply(theList, sum)

aggregate(price ~ cut, diamonds, each(mean, median))
system.time(dlply(baseball, "id", nrow))
iBaseball <- idata.frame(baseball)
system.time(dlply(iBaseball, "id", nrow))

# install.packages("data.table")
require(data.table)
theDF <- data.frame(A = 1:10,
                    B = letters[1:10],
                    C = LETTERS[11:20],
                    D = rep(c("one", "two", "three"), length.out = 10))
class(theDF$B)

theDT <- data.table(A = 1:10,
                    B = letters[1:10],
                    C = LETTERS[11:20],
                    D = rep(c("one", "two", "three"), length.out = 10))
theDT
class(theDT$B)

diamondsDT <- data.table(diamonds)
diamondsDT

theDT[1:2, ]
theDT[theDT$A >= 7, ]
theDT[ , list(A, C)]
#1列のみを表示
theDT[, B]
# data.tableのデータ構造を保ちつつ、1列選択
theDT[, list(B)]
theDT[, "B", with = FALSE]
theDT[, c("A", "C"), with = FALSE]
# テーブルを表示する
tables()
# キーを設定する
setkey(theDT, D)
# data.tableを再度表示する
theDT
key(theDT)
tables()
theDT["one", ]
theDT[c("one", "two"), ]

# キー設定をする
setkey(diamondsDT, cut, color)
# J関数を用いて、複数の列をキーにいくつかの行を選択する
diamondsDT[J("Ideal", "E"), ]
diamondsDT[J("Ideal", c("E", "D")), ]

aggregate(price ~ cut, diamonds, mean)
diamondsDT[, mean(price), by = cut]
diamondsDT[, list(price = mean(price)), by = cut]
diamondsDT[, mean(price), by = list(cut, color)]
diamondsDT[, list(price = mean(price), carat = mean(carat)), by = cut]
diamondsDT[, list(price = mean(price), carat = mean(carat)
                  ,caratSum = sum(carat)), by = cut]
diamondsDT[, list(price = mean(price), carat = mean(carat)), by = list(cut, color)]
