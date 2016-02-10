# 3. faza: Izdelava zemljevida

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/rds/SVN_adm0.rds",
                             "zemljevid/SVN_adm0.rds", encoding = "Windows-1250")

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
