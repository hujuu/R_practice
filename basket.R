#必要なパッケージをインストール
# install.packages("arules")
# install.packages("arulesViz")

#ライブラリの読み込み
library(arules)
library(arulesViz)

data(Groceries)
Groceries

rules <- apriori(Groceries, parameter=list(support=0.005, confidence=0.5))
rules
plot(rules)

plot(
  rules, 
  method="graph", 
  measure="support",
  shading="lift"
)

subrules <- subset(rules, lift>2.5)
subrules

plot(
  subrules, 
  method="graph", 
  measure="support",
  shading="lift"
)
