roll <- function(){
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

roll2 <- function(bones = 1:6){
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

例題NA1 <- read.csv("read.csv")
例題NA1
is.na(例題NA1)
summary(例題NA1)
table(例題NA1$local)
mean(例題NA1$tv)
mean(例題NA1$tv, na.rm = TRUE)
例題NA2 <- na.omit(例題NA1)
例題NA2
mean(例題NA2$tv)

例題NA3 <- read.csv("read.csv", na.strings = "")
例題NA3

cor(例題NA1$social, 例題NA1$tv)
cor(例題NA1$social, 例題NA1$tv, use = "complete.obs")

library("ggplot2")
qplot
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
x
y <- x^3
y
qplot(x,y)

x <- c(1, 2,2,2,3,3)
qplot(x, binwidth = 1)
x2 <- c(1,1,1,1,1,2,2,2,2,3,3,4)
qplot(x2, binwidth = 1)
x3 <- c(0,1,1,2,2,2,2,3,3,4)
qplot(x3, binwidth = 1)

replicate(3, 1+1)
replicate(10, roll())
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

roll <- function(){
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE,
                 prob = c(1/8,1/8,1/8,1/8,1/8,3/8))
  sum(dice)
}
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

card <- list("ace", "hearts", 1)
card

df <- data.frame(face = c("ace","two","six"),
                 suit = c("clubs", "clubs", "clubs"),
                 value = c(1,2,3))
df
typeof(df)
class(df)
str(df)

write.csv(deck, file = "cards.csv", row.names = FALSE)
deck[1,1]
deck[1,1:3]
deck[1, ]

deal <- function(cards){
  deck[cards, ]
}
deal <- function(cards){
  cards[1, ]
}
deck2 <- deck[1:52, ]
head(deck2)
deck3 <- deck[c(2,1,3:52), ]
head(deck3)
ramdom <- sample(1:52, size = 52)
ramdom
deck4 <- deck[ramdom, ]
head(deck4)

deck2 <- deck
vec <- c(0,0,0,0,0,0)
vec[1] <- 1000
vec[1]
vec[c(1,3,5)] <- c(1,1,1)
vec[7] <- 0
vec

deck2$new <- 1:52
deck2$new <- NULL
deck2[c(13,26,39,52), ]
deck2[c(13,26,39,52), 3]
deck2$value[c(13,26,39,52)]
deck2$value[c(13,26,39,52)] <- 14
head(deck2,13)

deck2$face[1:52]
"ace" %in% deck2$face[1:52]
deck2$face
deck2$face == "ace"
sum(deck2$face == "ace")
deck3$face == "ace"
deck3$value[deck3$face == "ace"]
deck3$value[deck3$face == "ace"] <- 14
head(deck3,13)

deck4 <- deck
deck4$value <- 0
head(deck4,52)
deck4$value[deck4$suit == "hearts"] <- 1
deck4$value[deck4$suit == "hearts"]

ignis <- readHTMLTable('http://1923.co.jp/recruit/application-requirements')
typeof(ignis)
class(ignis)
url <- "http://1923.co.jp/recruit/application-requirements"
tableList <- readHTMLTable(url)
tableElement <- tableList[[1]][1,1] #要素へのアクセス
tableElement <- c(tableList[[1]][1,1],tableList[[1]][1,2])
tableElement

as.environment("package:stats")
globalenv()
baseenv()
emptyenv()
parent.env(globalenv())
ls(globalenv())
head(globalenv()$deck, 3)
assign("new", "Hello", envir = globalenv())
globalenv()$new
environment()

show_env <- function(){
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}
show_env()
environment(show_env)
environment(parenvs)

deal <- function(){
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv())
  card
}
deal()

shuffle <- function(cards){
  random <- sample(1:52, size = 52)
  cards[random, ]
}
shuffle(deck)

DECK <- deck

shuffle <- function(cards){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = globalenv())
}

setup <- function(deck){
  DECK <- deck
  
  DEAL <- function(){
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    card
  }
  
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment()))
  }
  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

rm(deck)
shuffle()
deal()