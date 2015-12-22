# Obdelava, uvoz in čiščenje podatkov.

Tukaj bomo imeli program, ki bo obdelal, uvozil in očistil podatke (druga faza
projekta).
Vektor imen stolpcev:

regije <- c("Leto", "Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Spodnjeposavska", "Jugovzhodna", "Osrednjeslovenska", "Gorenjska", "Notranjsko-kraška", "Goriška", "Obalno-kraška")

Uvoz tabele s številom muzejev:

uvozi.stevilomuzejev <-function(){return(read.csv2("podatki/stmuzejevnapreb.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
}

Uvoz procenta občasnih razstav:

uvozi.obcasne <- function(){return(read.csv2("podatki/obcasnerazsprocent.csv", header = FALSE, na.strings ="...", row.names = 1), col.names = regije)}

Uvoz povprečnega števila obiskovalcev:

uvozi.obiskovalce <- function(){return(read.csv2("podatki/stobiskovalcev.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
}
