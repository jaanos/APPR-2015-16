# Obdelava, uvoz in čiščenje podatkov.

Tukaj bomo imeli program, ki bo obdelal, uvozil in očistil podatke (druga faza
projekta).

Vektor imen stolpcev:
regije <- c("Leto", "Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Spodnjeposavska", "Jugovzhodna", "Osrednjeslovenska", "Gorenjska", "Notranjsko-kraška", "Goriška", "Obalno-kraška")

library(reshape2)

stevilomuzejev <- read.csv2("podatki/stmuzejevnapreb.csv", dec =".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Stevilo.muzejev")

obcasnerazstave <- read.csv2("podatki/obcasnerazsprocent.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obcasne.razstave")

obiskmuzejev <- read.csv2("podatki/stobiskovalcev.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obisk.muzejev")


skupaj <- stevilomuzejev %>% full_join(obcasnerazstave) %>% full_join(obiskmuzejev)

#Število muzejev na 10.000 prebivalcev
imena2 <- c("Država", "Leto", "Muzeji na 10.000 prebivalcev")
drzave <- c("Avstrija", "Belorusija", "Belgija", "Bulgarija", "Hrvaška", "Češka", "Danska", "Estonija", "Finska", "Francija", "Nemčija", "Grčija", "Madžarska", "Irska", "Italija", "Latvija", "Litva", "Luksemburg", "Makedonija", "Norveška", "Poljska", "Portugalska", "Romunija", "Slovaška", "Slovenija", "Španija", "Švedska", "Švica", "Nizozemska", "Združeno Kraljestvo")
egmnapreb <- read.csv2("podatki/egm-napreb.csv", dec = ",", header = FALSE, na.strings = "", colClasses = c("NULL", NA, NA), row.names = drzave, 
col.names = imena2, skip = 1)

#COLCLASSES da sem odstranila nepotreben stolpec

egmnapreb2 <- drop_na(egmnapreb) 
#odstranila NA vrstice

#Skupen obisk muzejev v Evropi
imena3 <- c("Država", "Leto", "Obisk.muzejev", "A", "B", "C", "D", "E")
egmskupaj <- read.csv2("podatki/egm-skupaj.csv", dec = ",", header = FALSE, na.strings = "", colClasses = c("NULL", NA, NA, "NULL", "NULL", "NULL", "NULL", "NULL"), row.names = drzave, col.names = imena3, skip = 1)


#Uvoz tabele s številom muzejev:

#uvozi.stevilomuzejev <-function(){return(read.csv2("podatki/stmuzejevnapreb.csv", dec = ".", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
#}

#Uvoz procenta občasnih razstav:

#uvozi.obcasne <- function(){return(read.csv2("podatki/obcasnerazsprocent.csv", dec= ".", header = FALSE, na.strings ="...", row.names = 1), col.names = regije)}

#Uvoz povprečnega števila obiskovalcev:

#uvozi.obiskovalce <- function(){return(read.csv2("podatki/stobiskovalcev.csv", dec = ".", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
#}
