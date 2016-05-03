#データの読み込み
sleep2 <- read.csv("R_practice/anova3a.csv")
head(sleep2)

#平均値の算出
tapply(sleep2$time, list(sleep2$club,sleep2$sex), mean)

tapply(sleep2$time, list(sleep2$club,sleep2$sex), sd)

interaction.plot(sleep2$club, sleep2$sex, sleep2$time)

dev.off()

interaction.plot(sleep2$sex, sleep2$club, sleep2$time)

summary(aov(sleep2$time~sleep2$club*sleep2$sex))

summary(aov(sleep2$time~sleep2$club,subset=(sleep2$sex=='f')))

summary(aov(sleep2$time~sleep2$club,subset=(sleep2$sex=="m")))

TukeyHSD(aov(sleep2$time~sleep2$club,subset=(sleep2$sex=="m")))
