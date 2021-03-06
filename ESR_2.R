#----------- ここからggplot
library(ggplot2)
library(grid)
library(tidyr)
library(dplyr)
library(extrafont)
library(Cairo)
library(rJava)
library(xlsx)
library(gridExtra)
loadfonts(quiet=TRUE)
windowsFonts(Times=windowsFont("TT Times New Roman"))

#------------- ワークディレクトリ作成とディレクトリ変更
wdname <- paste("ES research", as.character(Sys.Date()))	#ディレクトリ名のセット
dir.create(wdname) #ディレクトリ作成
wdpath.i <- getwd() #現状のパスの取得
wdpath <- paste(wdpath.i,"/",wdname,sep = "") #新規ディレクトリへのパス文字列生成


# 回答データ,confデータ取得
ESdata.raw <- read.csv("ESR_ans.csv",header=TRUE, row.name=1)
Orglist <- as.data.frame(table(ESdata.raw[,1]))
Lpmax <- nrow(Orglist)+1
confdata <- read.csv("ESR_conf.csv",header=TRUE) #　設定ファイルからのデータ取得
Qnum <- confdata
Qlbl <- as.vector(colnames(confdata))
Lpcnt <- 0

# 組織ループ処理
for(orgi in 1:Lpmax){
  Lpcnt <- Lpcnt + 1
  
  # 組織ループ　読み込みデータ、ファイル出力先初期設定
  if (Lpcnt == 1){
    setwd(wdpath) #新規ディレクトリへのパス変更
    ESdata.org <- ESdata.raw
    ESdata <- ESdata.org[,-1]
  } else {
    # 該当組織のデータのみ切り出し
    ESdatore <- ESdata.org[,-1]
    ESdata.org <-  subset(ESdata.raw, ESdata.raw[,1] == Orglist[Lpcnt-1,1])
    ESdata <- ESdata.org[,-1]
    
    # データ出力先設定
    setwd(wdpath) #新規ディレクトリへのパス変更
    wdname <- as.vector(Orglist[Lpcnt-1,1])	#組織ディレクトリ名のセット
    Dirname <- paste(wdname,Lpcnt,sep="")
    dir.create(Dirname) #ディレクトリ作成
    wdpath.org <- paste(wdpath,"/",Dirname,sep = "") #新規ディレクトリへのパス文字列生成
    setwd(wdpath.org) #新規ディレクトリへのパス変更
  }
  
  #質問カテゴリループ処理 前準備
  Catnum <- length(Qnum)
  Catstnum <- 1
  Catednum <- 0
  
  for (i in 1:Catnum){  #質問カテゴリループ処理
    Catednum <- as.integer(Catednum + Qnum[i])
    Catans <- ESdata[,c(Catstnum:Catednum)]
    
    #----------- 次に折れ線グラフ
    
    #質問データ短縮処理
    Qnm <- colnames(Catans) #質問データ取り出し
    Q.n.max <- ncol(Catans) #ループ回数設定
    Qnm.n <- matrix(0, nrow = 1, ncol = Q.n.max) #データ受け取りの箱の用意
    
    for(i3 in 1:Q.n.max){ 
      Qnm.n[,i3] <- paste(substr(Qnm[i3], 1, 15),"...",sep = "")
    }
    colnames(Catans) <- Qnm.n
    
    #データの加工
    if(Lpcnt == 1){
      
      Ansname <- colnames(Catans)
      Catmean <- colMeans(Catans)
      Dum <- rep("全社平均", Qnum[1,i]) ######## ループ処理
      SE <- rep(0, Qnum[1,i])
      Oresen <- data.frame(Type = Dum, Qname=Ansname, Ave=Catmean, Se=SE, ID=c(1:Q.n.max))
      Oresen$Ave <- round(Oresen$Ave,2)
      
    }else{
      
      Ansname <- colnames(Catans)
      Catmean <- colMeans(Catans)
      Dum <- rep("部門平均", Qnum[1,i]) ######## ループ処理
      variance <- function(x) var(x)*(length(x)-1)/length(x)
      Catvar <- apply(Catans,2,variance)
      CatSd <- sqrt(Catvar)
      SE <- CatSd/sqrt(nrow(Catans))
      Oresen <- data.frame(Type = Dum, Qname=Ansname, Ave=Catmean, Se=SE, ID=c(1:Q.n.max))
      
      Oreall <- ESdatore[,c(Catstnum:Catednum)]
      colnames(Oreall) <- Qnm.n
      OreCatmean <- colMeans(Oreall)
      OreAnsname <- colnames(Oreall)
      OreDum <- rep("全社平均", Qnum[1,i])
      OreSE <- rep(0, Qnum[1,i])
      Oresenall <- data.frame(Type = OreDum, Qname=OreAnsname, Ave=OreCatmean,Se=OreSE, ID=c(1:Q.n.max))
      
      Oresen <- rbind(Oresen,Oresenall)
      Oresen$Ave <- round(Oresen$Ave,2)
    }
    
    #折れ線表示
    f1 = ggplot(Oresen, aes(x = reorder(Qname, ID), y = Ave, group = Type, shape = Type, colour = Type)) + 
      geom_line(size=2) + 
      geom_point(size=4) +
      geom_text(aes(label=Ave), size=3, vjust=-2) + #数値ラベル挿入
      geom_errorbar(aes(ymin = Ave - 2*Se,ymax = Ave + 2*Se,width = 0.1)) +
      scale_y_continuous("Score", limits = c(1, 5), breaks=seq(1, 5, by = 1)) + # rescale Y axis slightly
      #scale_shape_manual(values=c(24,21)) + # explicitly have sham=fillable triangle, ACCX=fillable circle
      #scale_fill_manual(values=c("white","black")) + # explicitly have sham=white, ACCX=black
      stat_abline(intercept=3, slope=0, linetype="dotted", size=0.5) + # add a reference line
      annotate("text", x=0.6, y=2.85, size=3,label= "Neutral=3.0",hjust = 0) + # and a manual label or annotation
      theme_bw() + # make the theme black-and-white rather than grey (do this before font changes, or it overrides them)
      theme_classic() +
      labs(title = paste(Qlbl[i],"カテゴリ　各質問の平均得点",sep=""), x="") + #### ループ処理
      #その他書式指定
      theme(plot.title = element_text(face="plain", size=10), # use theme_get() to see available options
            axis.text.x = element_text(face="plain", size=8, angle=90),
            axis.title.x = element_text(face="plain", size=10),
            axis.title.y = element_text(face="plain", size=10, angle=90),
            panel.grid.major = element_blank(), # switch off major gridlines
            panel.grid.minor = element_blank(), # switch off minor gridlines
            legend.position = c(0.5,0.1), # manually position the legend (numbers being from 0,0 at bottom left of whole plot to 1,1 at top right)
            legend.direction　= "horizontal",
            legend.title = element_blank(),
            #legend.key.size = element_blank(), # switch off the legend title
            legend.text = element_text(size=8)
            #legend.key = element_blank() # switch off the rectangle around symbols in the legend
      )
    
    #----------- ヒストグラム表示
    Catans[,1] <- as.factor(Catans[,1]) ######## ループ処理
    nm <- colnames(Catans) #表タイトル取得
    
    Chrt1 <- ggplot(Catans, aes(x=Catans[,1])) + geom_histogram(alpha=0.5) +  ######## ループ処理
      theme_bw() + # make the theme black-and-white rather than grey (do this before font changes, or it overrides them)
      theme_classic() +
      geom_text(stat='bin',aes(label=..count..),size=3, vjust=-0.2) + #数値ラベル挿入
      xlim("1","2","3","4","5") +
      labs(title = paste("Key Question : ",　nm[1], sep=" "), x="Low     <<----     Neutral     ---->>     High") #### ループ処理
    Chrt1 <- Chrt1 + theme(
      plot.title=element_text(face="plain", size=10)
      , legend.position = "none" # manually position the legend (numbers being from 0,0 at bottom left of whole plot to 1,1 at top right)
      , legend.title = element_blank()
      , legend.key.size = element_blank() # switch off the legend title
      , legend.text = element_blank()
      , legend.key = element_blank() # switch off the rectangle around symbols in the legend
      , axis.text.x = element_text(face="plain", size=10, colour = "black")
      , axis.title.x = element_text(face="plain", size=10, colour = "black")
      , axis.text.y = element_text(face="plain", size=10, colour = "black")
      , axis.title.y = element_text(face="plain", size=10, colour = "black")
      , panel.grid.major = element_blank() # switch off major gridlines
      , panel.grid.minor = element_blank() # switch off minor gridlines
    )
    grob <- grobTree(textGrob(paste("N=",nrow(Catans),sep=""), x=0.1,  y=0.95, hjust=0,gp=gpar(col="red", fontsize=10, fontface="italic")))
    Chrt1 <- Chrt1 + annotation_custom(grob)
    
    
    #最後に残りのグラフを一括生成
    Catans.gp <- Catans[-1]
    Gpchrt <- Catans.gp %>%　
      gather(variable, value)　
    
    Gpchrt[,2] <- as.factor(Gpchrt[,2])　#ヒストグラム用にfactor要素に変換
    
    GChrt <- ggplot(Gpchrt, aes(x=value)) + geom_histogram(alpha=0.5) + facet_wrap(~variable) +
      theme_linedraw() + # make the theme black-and-white rather than grey (do this before font changes, or it overrides them)
      #theme_minimal() +
      xlim("1","2","3","4","5") +
      geom_text(stat='bin',aes(label=..count..),size=3,vjust=-0.2) + #数値ラベル挿入
      labs(title = "Sub Questions", x="Low     <<----     Neutral     ---->>     High") 
    GChrt <- GChrt + theme(
      plot.title=element_text(face="plain", size=10)
      , legend.position = "none" # manually position the legend (numbers being from 0,0 at bottom left of whole plot to 1,1 at top right)
      , legend.title = element_blank()
      , legend.key.size = element_blank() # switch off the legend title
      , legend.text = element_blank()
      , legend.key = element_blank() # switch off the rectangle around symbols in the legend
      , axis.text.x = element_text(face="plain", size=10, colour = "black")
      , axis.title.x = element_text(face="plain", size=10, colour = "black")
      , axis.text.y = element_text(face="plain", size=10, colour = "black")
      , axis.title.y = element_text(face="plain", size=10, colour = "black")
      , panel.grid.major = element_blank() # switch off major gridlines
      , panel.grid.minor = element_blank() # switch off minor gridlines
      , strip.text = element_text(face="plain", size=9, colour = "white")
    )
    
    
    #1枚のシートに合成し、フォルダ作成 & ファイル出力
    if(i == 1){
      filename <- "ES Research Summary.pdf"
      pdf(filename, family="Japan1GothicBBB", paper="a4", width=9.5, height=13, pointsize=7)
    }
    
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(13, 12)))
    grid.text(paste("ES Research Report (",i,"/",length(Qnum),")    '",Qlbl[i],"' の評価",sep=""), gp=gpar(fontsize=18), vp = viewport(layout.pos.row = 1, layout.pos.col = 1:12))
    print(Chrt1, vp = viewport(layout.pos.row = 2:6, layout.pos.col = 1:6)) #上段左
    print(f1, vp = viewport(layout.pos.row = 2:6, layout.pos.col = 7:12))	#上段右	
    print(GChrt, vp = viewport(layout.pos.row = 7:13, layout.pos.col = 1:12))	#下段
    popViewport() 
    
    Catstnum <- Catednum + 1
  } ## 質問カテゴリ　ループ処理終了
  dev.off()
  
  if(Lpcnt == 1){ #全社のみ以下の処理
    
    #-------------- 相関係数と各質問の評価平均のプロット
    ESplot.dat <- ESdata.raw[,-1]
    ESplot.mean <- as.numeric(colMeans(ESplot.dat))
    ESplot.cor <- cor(ESplot.dat, method="p")
    ESplot.cor <- as.numeric(ESplot.cor[,1])
    ESplot.cat <- rep(0, length(ESplot.cor))
    ESplot <- data.frame(ESplot.cor, ESplot.mean, ESplot.cat)
    ESplot <- ESplot[-1,]
    
    for (i5 in 1: nrow(ESplot)){
      
      if (ESplot[i5,1] >= 0.4 & ESplot[i5,2] >= 3){
        ESplot[i5,3] <- "Keep"
      } else if(ESplot[i5,1] >= 0.4 & ESplot[i5,2] < 3){
        ESplot[i5,3] <- "Important"
      }else if(ESplot[i5,1] < 0.4 & ESplot[i5,2] >= 3){
        ESplot[i5,3] <- "Enough?"
      }else{
        ESplot[i5,3] <- "Ignore"
      }
      
    }
    
    ESP <- ggplot(ESplot, aes(x=ESplot.cor, y=ESplot.mean, label=rownames(ESplot),colour = ESplot.cat))+
      geom_point(size=4)+
      geom_text(aes(colour=factor(ESplot.cat)),size=3,hjust=-2, vjust=0)+
      labs(title = "課題考察　：　影響度（課題の重要度）×充足度（Average Score）", x="低　　＜- - - - - -　課題の重要度　（会社満足度との相関係数） - - - - - -　＞　　高"
           ,y= "Average Score") +
      annotate("text", x=0.1, y=2.5, size=3,label= "※各点横の数値は、アンケートの質問番号を指す",hjust = 0)+# and a manual label or annotation
      geom_hline(yintercept = 3, size=1,linetype="dotted",colour = "gray") +
      geom_vline(xintercept = 0.4, size=1,linetype="dotted",colour = "gray") +
      theme_bw() +
      theme(
        plot.title = element_text(face="bold", size=15), # use theme_get() to see available options
        axis.text.x = element_text(face="plain", size=10),
        axis.title.x = element_text(face="plain", size=10),
        axis.title.y = element_text(face="plain", size=10, angle=90),
        panel.grid.major = element_blank(), # switch off major gridlines
        panel.grid.minor = element_blank(), # switch off minor gridlines
        legend.position = "right", # manually position the legend (numbers being from 0,0 at bottom left of whole plot to 1,1 at top right)
        legend.direction　= "vertical",
        legend.title = element_blank(),
        #legend.key.size = element_blank(), # switch off the legend title
        legend.text = element_text(size=8),
        legend.key = element_blank() # switch off the rectangle around symbols in the legend
      )
    
    filename <- "影響度×充足度分析.pdf"
    
    pdf(filename, family="Japan1GothicBBB", paper="a4r",width=11.69,height=8.27, pointsize=7)
    print(ESP)
    dev.off()
  }
  
  
  #-------- 平均スコア３未満ユーザリスト出力
  ESdata.raw2　<- ESdata.org[,-1]
  AverageScore <- rowSums(ESdata.raw2)/ncol(ESdata.raw2)
  ESdata.list <- data.frame(ESdata.org, AverageScore)
  
  Lessave.list <- subset(ESdata.list, ESdata.list$AverageScore < 3, c(1,41))
  
  if (nrow(Lessave.list) > 0){
    sortlist <- order(Lessave.list$組織, Lessave.list$AverageScore)
    Lessave.list2 <- Lessave.list[sortlist,]
    write.xlsx(Lessave.list2, "低満足度従業員リスト.xlsx",sheetName="Sheet1")
    
  }　## 不満メンバーリスト出力　条件分岐　処理終了
  
}　## 組織　ループ処理終了

setwd(wdpath.i)
