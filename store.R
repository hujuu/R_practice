# install.packages("XML")
library(XML)

doc <- xmlParse("store_review.xml")
doc

items <- getNodeSet(doc, "./entry/content")
items
types <- sapply(items, function(x) xmlGetAttr(x, "type"))

value <- sapply(items, function(x) strtoi(xmlValue(x)))

df <- data.frame(types, value, stringsAsFactors = FALSE)
df
write.csv(df, file = "data.csv", row.names = FALSE)

selectAXlm <- paste(as.character(
  tkgetOpenFile(title = "xmlファイルを選択",filetypes = '{"xmlファイル" {".xml"}}',
                initialfile = "store_review.xml")), sep = "", collapse =" ")
MasterAnaData <- xmlInternalTreeParse(selectAXlm)

Title <- as.data.frame(xpathSApply(MasterAnaData, "//ArticleTitle", xmlValue)) #論文タイトルの抽出
Abstract <-as.data.frame(xpathSApply(MasterAnaData, "//AbstractText", xmlValue)) #アブストラクトの抽出
########