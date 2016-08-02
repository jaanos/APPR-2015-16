# 2. faza: Uvoz podatkov

#Vektor z imeni regij:
regije <- c("Leto", "Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Spodnjeposavska", "Jugovzhodna", "Osrednjeslovenska", "Gorenjska", "Notranjsko-kraška", "Goriška", "Obalno-kraška")

leta <- c("Obcina","2007", "2008", "2009","2010","2011","2012","2013","2014")

#Uvoz tabele s številom muzejev:
  
uvozi.stevilomuzejev <- function(){return(read.csv2("podatki/stmuzejevnapreb.csv", header = FALSE, echo = FALSE, na.strings = "...", row.names = 1, col.names = regije))
  }

#Uvoz procenta občasnih razstav:
  
uvozi.obcasne <- function(){return(read.csv2("podatki/obcasnerazsprocent.csv", header = FALSE, echo = FALSE, na.strings = "...", row.names = 1, col.names = regije))}

#Uvoz povprečnega števila obiskovalcev:
  
uvozi.obiskovalce <- function(){return(read.csv2("podatki/stobiskovalcev.csv", header = FALSE, echo = FALSE, na.strings = "...", row.names = 1, col.names = regije)) }
uvozi.muzeje <- function(){return(read.csv("podatki/muzejiinrazstavisca.csv", dec = ".", na.strings ="-", header = FALSE, echo = FALSE, row.names=1, col.names = leta))}
#Zapišemo v tabelco:
  
stevilomuzejev <- uvozi.stevilomuzejev()
OK.vrstice1 <- apply(stevilomuzejev, 1, function(x){!any(is.na(x))})
Ok.stevilomuzejev <- stevilomuzejev[OK.vrstice1, ]

obcasnerazstave <- uvozi.obcasne()
OK.vrstice2 <- apply(obcasnerazstave, 1, function(x){!any(is.na(x))})
OK.obcasne <- obcasnerazstave[OK.vrstice2, ]

obiskovalci <-uvozi.obiskovalce()
OK.vrstice3 <- apply(obiskovalci, 1, function(x){!any(is.na(x))})
OK.obiskovalci <- obiskovalci[OK.vrstice3, ]

muzeji1<-uvozi.muzeje()
OK.vrstice4 <- apply(muzeji1, 1, function(x){!any(is.na(x))})
ok.muzeji <- muzeji1[OK.vrstice4, ]



stevilomuzejev <- read.csv2("podatki/stmuzejevnapreb.csv", dec =".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Stevilo.muzejev")

#obcasnerazstave <- read.csv2("podatki/obcasnerazsprocent.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obcasne.razstave")

obiskmuzejev <- read.csv2("podatki/stobiskovalcev.csv", dec = ".", header = FALSE, na.strings = "...", col.names = regije)%>%melt(id.vars = "Leto", variable.name = "Regija", value.name = "Obisk.muzejev")


skupaj <- stevilomuzejev %>% full_join(obiskmuzejev) 




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
