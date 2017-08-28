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

library(rpart)
skupaj$FObisk.muzejev = factor(skupaj$Obisk.muzejev)
train_data = skupaj[skupaj$Leto < 2014,]
test_data = skupaj[skupaj$Leto == 2014,]
test_counts <- test_data$Stevilo.muzejev
plot(skupaj$Obisk.muzejev, skupaj$Stevilo.muzejev)
plot(factor(skupaj$Obisk.muzejev), skupaj$Stevilo.muzejev)
model = rpart(Stevilo.muzejev ~ FObisk.muzejev, train_data,)
p = predict(model, test_data)
plot(p-test_counts)


