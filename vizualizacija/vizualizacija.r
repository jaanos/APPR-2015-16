# 3. faza: Izdelava zemljevida


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


pretvori.zemljevid <- function(zemljevid) {
  fo <- fortify(zemljevid)
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))
}

ob <- pretvori.zemljevid(obcine)
zem <- ggplot() + geom_polygon(data = muzeji %>% filter(Leto == 2014) %>%
                                 right_join(ob, by = c("Obcina" = "OB_UIME")),
                               aes(x=long, y=lat, group=group, fill=Stevilo),
                               color= "red") +
  scale_fill_gradient(low="#3F7F3F", high="#00FF00") +
  guides(fill=guide_colorbar(title = "Muzeji 2014"))

print(zem)


