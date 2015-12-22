# 2. faza: Uvoz podatkov

#Vektor z imeni regij:
regije <- c("Leto", "Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Spodnjeposavska", "Jugovzhodna", "Osrednjeslovenska", "Gorenjska", "Notranjsko-kraška", "Goriška", "Obalno-kraška")

#Uvoz tabele s številom muzejev:
  
uvozi.stevilomuzejev <- function(){return(read.csv2("podatki/stmuzejevnapreb.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
  }

#Uvoz procenta občasnih razstav:
  
uvozi.obcasne <- function(){return(read.csv2("podatki/obcasnerazsprocent.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))}

#Uvoz povprečnega števila obiskovalcev:
  
uvozi.obiskovalce <- function(){return(read.csv2("podatki/stobiskovalcev.csv", header = FALSE, na.strings = "...", row.names = 1, col.names = regije))
  }

#Zapišemo v tabelco:
  

stevilomuzejev <- uvozi.stevilomuzejev()
obcasnerazstave <- uvozi.obcasne()
obiskovalci <- uvozi.obiskovalce()








# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#uvozi.druzine <- function() {
  #return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
                      #row.names = 1,
                      #col.names = c("obcina", "en", "dva", "tri", "stiri"),
                      #fileEncoding = "Windows-1250"))
#}

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine()

#obcine <- uvozi.obcine()

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.