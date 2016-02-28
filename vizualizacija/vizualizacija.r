# 3. faza: Izdelava zemljevida

# Uvozimo zemljevid.
obcine <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip", "OB/OB", encoding = "Windows-1250")

uvozi.muzeje <- function(){
  return(read.csv("podatki/muzejiinrazstavisca.csv", dec = ".", na.strings ="-",
                  header = FALSE, col.names = leta, fileEncoding = "Windows-1250"))
}

muzeji <- uvozi.muzeje() %>% melt(variable.name = "Leto", value.name = "Stevilo")
levels(muzeji$Obcina) <- levels(muzeji$Obcina) %>% {gsub(" - ", "-", .)} %>%
  strapplyc("^([^/]+)") %>% unlist()
muzeji$Leto <- muzeji$Leto %>% as.character() %>% strapplyc("([0-9]+)") %>%
  unlist() %>% as.numeric()

ob <- pretvori.zemljevid(obcine)
zem <- ggplot() + geom_polygon(data = muzeji %>% filter(Leto == 2014) %>%
                                 right_join(ob, by = c("Obcina" = "OB_UIME")),
                               aes(x=long, y=lat, group=group, fill=Stevilo),
                               color= "red") +
  scale_fill_gradient(low="#3F7F3F", high="#00FF00") +
  guides(fill=guide_colorbar(title = "Muzeji 2014"))
print(zem)
# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
#druzine <- preuredi(druzine, zemljevid, "OB_UIME", c("Ankaran", "Mirna"))

# Izračunamo povprečno velikost družine.
#druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
#min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
#max.povprecje <- max(druzine$povprecje, na.rm=TRUE)
pretvori.zemljevid <- function(zemljevid) {
  fo <- fortify(zemljevid)
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))
}
