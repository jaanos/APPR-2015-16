# 4. faza: Analiza podatkov


obiskovalci.tidy <- data.frame(leto = rownames(OK.obiskovalci),
                               OK.obiskovalci) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf <- ggplot(obiskovalci.tidy, aes(x = leto, y = stevilo,
                             group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Obiskovalci") +
  xlab("Leta") + ylab("Skupaj")

#plot(graf)

istoleto <- c("Slovenija", "Italija", "Norveška", "Madžarska")
stevilo2013 <- matrix(c(3558551, 38190401, 10944898, 9133600),ncol=1,byrow=TRUE)
tabelca2 <- data.frame(stevilo2013, row.names = istoleto)
graf3 <- ggplot(tabelca2, aes(x = istoleto, y = stevilo2013)) + geom_point() +ggtitle("Obiskovalci v letu 2013")
#plot(graf3)

obcasne.tidy <- data.frame(leto = rownames(OK.obcasne),
                               OK.obcasne) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf2 <- ggplot(obcasne.tidy, aes(x = leto, y = stevilo,
                                     group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Občasne razstave") +
  xlab("Leta") + ylab("Skupaj")

#plot(graf2)



df <- data.frame(skupaj$Leto, skupaj$Regija, skupaj$Stevilo.muzejev, skupaj$Obisk.muzejev)
#vzamemo samo podatke za Osrednjeslovensko regijo za leta 2007 do 2014
delnidf <- df[57:64, 3:4]
#plot(delnidf)

library(ggpubr)
#ali so podatki normalno porazdeljeni
s1 <-shapiro.test(delnidf$skupaj.Stevilo.muzejev)
s2 <-shapiro.test(delnidf$skupaj.Obisk.muzejev)

#kakšna korelacija?
#pearson
pearson <-cor.test(delnidf$skupaj.Obisk.muzejev, delnidf$skupaj.Stevilo.muzejev, method = "pearson")

korelacijski <- cor(delnidf$skupaj.Stevilo.muzejev, delnidf$skupaj.Obisk.muzejev)
#plot(delnidf$skupaj.Stevilo.muzejev, delnidf$skupaj.Obisk.muzejev)
#abline(lm(delnidf$skupaj.Obisk.muzejev ~ delnidf$skupaj.Stevilo.muzejev))

#še z QQ-plot preverimo kako izgledajo podatki in ali so podobni normalni porazdelitvi
#qsm <-qqnorm(skupaj$Stevilo.muzejev[skupaj$Regija == "Osrednjeslovenska"], main = "Število muzejev v Osrednjeslovenski regiji")
#qqline(skupaj$Stevilo.muzejev[skupaj$Regija == "Osrednjeslovenska"])
#qom <-qqnorm(skupaj$Obisk.muzejev[skupaj$Regija == "Osrednjeslovenska"], main ="Obisk muzejev v osrednjeslovenski regiji")
#qqline(skupaj$Obisk.muzejev[skupaj$Regija == "Osrednjeslovenska"])
#qsk <-qqplot(skupaj$Obisk.muzejev[skupaj$Regija == "Osrednjeslovenska"], skupaj$Stevilo.muzejev[skupaj$Regija == "Osrednjeslovenska"],
       #xlab = "Obisk muzejev", ylab = "Število muzejev", main = "Število muzejev in število obiskovalcev v Osrednjeslovenski regiji")

