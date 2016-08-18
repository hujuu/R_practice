#2つのベクトルを作成し、それをdata.frameの列として結合させる
sport <- c("Hockey", "Baseball", "Football")
league <- c("NHL", "MLB", "NFL")
trophy <- c("Stanley Cup", "Commissioners Trophy", "Vince Lombardi Trophy")
trophies1 <- cbind(sport, league, trophy)
trophies1

#data.frame関数を用い、別なdata.frameを作成する
trophies2 <- data.frame(sport = c("Basketball", "Golf"),
                        league = c("NBA", "PGA"),
                        trophy = c("Larry Trophy", "Wanamaker Trophy"),
                        stringsAsFactors = FALSE)
trophies2

#rbind関数を用いて1つのdata.frameへと結合させる
trophies <- rbind(trophies1, trophies2)
trophies

cbind(Sport = sport, Associate = league, Prize = trophy)
