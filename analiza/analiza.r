# 4. faza: Analiza podatkov


obiskovalci.tidy <- data.frame(leto = rownames(OK.obiskovalci),
                               OK.obiskovalci) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf <- ggplot(obiskovalci.tidy, aes(x = leto, y = stevilo,
                             group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Obiskovalci") +
  xlab("Leta") + ylab("Skupaj")

plot(graf)

istoleto <- c("Slovenija", "Italija", "Norveška", "Madžarska")

stevilo2013 <- matrix(c(3558551, 38190401, 10944898, 9133600),ncol=1,byrow=TRUE)
tabelca2 <- data.frame(stevilo2013, row.names = istoleto)
graf3 <- ggplot(tabelca2, aes(x = istoleto, y = stevilo2013)) + geom_bar(tabelca2)
plot(graf3)
obcasne.tidy <- data.frame(leto = rownames(OK.obcasne),
                               OK.obcasne) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf2 <- ggplot(obcasne.tidy, aes(x = leto, y = stevilo,
                                     group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Občasne razstave") +
  xlab("Leta") + ylab("Skupaj")

#plot(graf2)

