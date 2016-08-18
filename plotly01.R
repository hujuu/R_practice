# install.packages("plotly")
library(plotly)
set.seed(100)
d <- diamonds[sample(nrow(diamonds), 1000), ]
plot_ly(d, x = carat, y = price, text = paste("Clarity: ", clarity),
        mode = "markers", color = carat, size = carat)

# ggplot
p <- ggplot(data = d, aes(x = carat, y = price)) +
  geom_point(aes(text = paste("Clarity:", clarity)), size = 4) +
  geom_smooth(aes(colour = cut, fill = cut)) + facet_wrap(~ cut)

(gg <- ggplotly(p))

str(p <- plot_ly(economics, x = date, y = uempmed))

p %>%
  add_trace(y = fitted(loess(uempmed ~ as.numeric(date))), x = date) %>%
  layout(title = "Median duration of unemployment (in weeks)",
         showlegend = FALSE) %>%
  dplyr::filter(uempmed == max(uempmed)) %>%
  layout(annotations = list(x = date, y = uempmed, text = "Peak", showarrow = T))

plot_ly(z = volcano, type = "surface")


library(plotly)
p <- plot_ly(midwest, x = percollege, color = state, type = "box")
# plotly_POST publishes the figure to your plotly account on the web
plotly_POST(p, filename = "r-docs/midwest-boxplots", sharing='public')

# Simple example
p <- plot_ly(midwest, x = percollege, color = state, type = "box")
p

f <- function(x,y) x+y
f(1,2)

#階乗の関数
fact <- function(n){
  if(n==1) 1
  else n * fact(n-1)
}
fact(1)
fact(3)

library(plotly)
#plotlyへのアクセス設定.plotlyのサイトで取得したusernameとkeyを入力してください。
py <- plot_ly(username = "hujuu", key = "u27ycqll3h")
ggiris <- qplot(Petal.Width, Sepal.Length, data = iris, color = Species) #ggplotデータの作成
#plotlyへデータを送信
r <- py$plotly(ggiris)
#プロットをブラウザで表示
browseURL(r$url)

a = 1.5
a
as.integer(a)
typeof(a)
typeof(as.integer(a))
b = 1
typeof(b)
a1 = as.integer(a)
typeof(a1)
as.double(a1)
typeof(as.double(a1))
