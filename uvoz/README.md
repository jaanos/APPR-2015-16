# Obdelava, uvoz in čiščenje podatkov.

Tukaj bomo imeli program, ki bo obdelal, uvozil in očistil podatke (druga faza
projekta).

Vektor imen stolpcev:
regije <- c("Leto", "Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Spodnjeposavska", "Jugovzhodna", "Osrednjeslovenska", "Gorenjska", "Notranjsko-kraška", "Goriška", "Obalno-kraška")

library(reshape2)

stevilomuzejev <- read.csv2("podatki/stmuzejevnapreb.csv", dec =".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Stevilo.muzejev")

obcasnerazstave <- read.csv2("podatki/obcasnerazsprocent.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obcasne.razstave")

obiskmuzejev <- read.csv2("podatki/stobiskovalcev.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obisk.muzejev")


skupaj <- stevilomuzejev %>% full_join(obcasnerazstave) %>% full_join(obiskovalci)


#Uvoz tabele s številom muzejev:

#uvozi.stevilomuzejev <-function(){return(read.csv2("podatki/stmuzejevnapreb.csv", dec = ".", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
#}

#Uvoz procenta občasnih razstav:

#uvozi.obcasne <- function(){return(read.csv2("podatki/obcasnerazsprocent.csv", dec= ".", header = FALSE, na.strings ="...", row.names = 1), col.names = regije)}

#Uvoz povprečnega števila obiskovalcev:

#uvozi.obiskovalce <- function(){return(read.csv2("podatki/stobiskovalcev.csv", dec = ".", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
#}
