# 4. faza: Analiza podatkov


obiskovalci.tidy <- data.frame(leto = rownames(OK.obiskovalci),
                               OK.obiskovalci) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf <- ggplot(obiskovalci.tidy, aes(x = leto, y = stevilo,
                             group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Obiskovalci") +
  xlab("Leta") + ylab("Skupaj")

#plot(graf)

obcasne.tidy <- data.frame(leto = rownames(OK.obcasne),
                               OK.obcasne) %>%
  melt(variable.name = "regija", value.name = "stevilo")

graf2 <- ggplot(obcasne.tidy, aes(x = leto, y = stevilo,
                                     group = regija, color = regija)) +
  geom_line() + geom_point() + ggtitle("Občasne razstave") +
  xlab("Leta") + ylab("Skupaj")

plot(graf2)

