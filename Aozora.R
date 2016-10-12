# for Mac / Linux

# USAGE:
# source ("Aozora.R")
# `Aozora ("http://www.aozora.gr.jp/cards/000129/files/42375_ruby_18247.zip", "output.txt") ` 


 Aozora <- function(url = NULL, txtname  = NULL){
  if (is.null(url)) stop ("specify URL")
  tmp <- unlist (strsplit (url, "/"))
  tmp <- tmp [length (tmp)]
 
  curDir <- getwd()
  tmp <- paste(curDir, tmp, sep = "/")
  download.file (url, tmp)

  textF <- unzip (tmp)
  unlink (tmp)
  
  if(!file.exists (textF)) stop ("something wrong!")
  if (is.null(txtname)) txtname <- paste(unlist(strsplit(basename (textF), ".txt$")))
   if (txtname != "NORUBY")  {

    newDir <- paste(dirname (textF), "NORUBY", sep = "/")

    if (! file.exists (newDir)) dir.create (newDir)

    newFile <- paste (newDir,  "/", txtname, "2.txt", sep = "")

    con <- file(textF, 'r', encoding = "CP932" )
    outfile <- file(newFile, 'w', encoding = "utf8")
    flag <- 0;
    while (length(input <- readLines(con, n=1, encoding = "CP932")) > 0){
      if (grepl("^底本", input)) break ;
      if (grepl("【入力者注】", input)) break;
      if (grepl("^------", input)) {
        flag <- !flag
      next;
      }
      if (!flag){
        input <- gsub ("［＃[^］]*］", "", input, perl = TRUE)
        input <- gsub ("《[^》]*》", "", input, perl = TRUE)
        input <- gsub ("｜", "", input, perl = TRUE)
        writeLines(input, con=outfile)
      }
    }
    close(con); close(outfile)
    return (newDir);
  }
}

