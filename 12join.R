# download.file(url = "http://jaredlander.com/data/US_Foreign_Aid.zip", destfile = "data/ForeignAid.zip")

#ファイルの解凍
# unzip("data/US_Foreign_Aid.zip", exdir = "data")

require(stringr)

#ファイル一覧の取得
theFiles <- dir("data/", pattern = "nn.csv")

for (a in theFiles) {
  nameToUse <- str_sub(string = a, start = 12, end = 18)
  temp <- read.table(file = file.path("data", a),
                     header = TRUE, sep = ",", stringsAsFactors = FALSE)
  assign(x=nameToUse, value = temp)
}

Aid90s00s <- merge(x = Aid_90s, y = Aid_00s,
                   by.x = c("Country.Name", "Program.Name"),
                   by.y = c("Country.Name", "Program.Name"))
head(Aid90s00s)

paste("Hello", "max", "and others")
paste("Hello", "max", "and others", sep = "/")
paste(c("Hello", "max", "and others"), c("Jared", "Bov","david"))
paste("Hello",c("Hello", "max", "and others"), c("Jared", "Bov","david"))

vectorOfText <- c("Hello", "max", "and others", ".")
paste(vectorOfText, collapse = " ")
paste(vectorOfText, collapse = "*")

