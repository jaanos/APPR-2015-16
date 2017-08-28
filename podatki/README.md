# Podatki

Tukaj bomo zbirali vse podatke (datoteke v obliki CSV, XML, ...), ki jih bo naš
program uvozil.

Število muzejev in razstavišč na 10.000 prebivalcev po statističnih regijah Slovenije:
stevilo <- read.csv2("stmuzejevnapreb.csv")

Procent občasnih razstav od celotnih razstav na leto v Sloveniji:
obcasne <- read.csv2("obcasnerazsprocent.csv")

Povprečno število obiskovalcev:
obisk <- read.csv2("stobiskovalcev.csv")

Število muzejev in razstavišč po občinah
leta <- c("Obcina","2007", "2008", "2009","2010","2011","2012","2013","2014")
muzejiinrazstavisca <- read.csv("muzejiinrazstavisca.csv", dec = ".", na.strings ="-", header = FALSE, row.names=1, col.names = leta)

egm <- read.csv("egm.csv")


