
library(dplyr)
library(gsubfn)
library(ggplot2)

#Vektor, ki predstavlja imena stolpcev:
nova.kolona<-c("kraj", "leto","zivorojeni moski","zivorojene zenske","umrli moski","umrle zenske","naravni prirast moski","naravni prirast zenske")
#Funkcija, ki uvozi podatke iz datoteke podatki.csv

uvozi<-function(){
    return(read.csv2(file="podatki/prirastek.csv",
                    col.names=nova.kolona,
                    header=FALSE,
                    na.strings = "-",
                    fileEncoding = "UTF-8",
                    as.is = FALSE))
                }
#Zapisemo podatke v razpredelnivo tabela
cat("Uvazam podatke o naravnem prirastku...\n")
tabela<-uvozi()

#funkcija za zapis vrstic
uredi <- function(tabela, x, y, z, max = nrow(tabela)) {
  s <- seq(x, max, z+1)
  tabela[t(matrix(x:max, ncol=length(s))), y] <- tabela[s, y]
  tabela <-tabela[-s,]
  return(tabela)
}

tabela <- uredi(tabela, 1, 1, 5)

#Naredimo tabelo v kateri so vse občine
obcine <- tabela[seq(1, nrow(tabela), 5), 1]
#Naredimo tabelo kjer so podatki za vsako leto posebaj
podatki <- list()
for (i in 1:5) {
  podatki[[paste(tabela[i, "leto"])]] <- data.frame(tabela[seq(i, nrow(tabela), 5), c(-2)], row.names = NULL, stringsAsFactors = FALSE)
}

#nariše za kraj
tabela[tabela[["kraj"]] == "Beltinci",]

#poskrbimo, da so stevilske spremenljivke res stevilske
cat("Pretvorba stolpcev v stevilske spremenljivke...\n")
tabela$zivorojeni.moski <- as.numeric(tabela$zivorojeni.moski)
tabela$zivorojene.zenske <- as.numeric(tabela$zivorojene.zenske)
tabela$umrle.zenske <- as.numeric(tabela$umrle.zenske)
tabela$umrli.moski <- as.numeric(tabela$umrli.moski)
tabela$naravni.prirast.zenske <- as.numeric(tabela$naravni.prirast.zenske)
tabela$naravni.prirast.moski <- as.numeric(tabela$naravni.prirast.moski)


#seštevanje dveh stolpcev in ustvarjanje novega
tabela["skupni.prirast"]<-tabela$naravni.prirast.moski+ tabela$naravni.prirast.zenske
tabela$skupni.prirast <- as.numeric(tabela$skupni.prirast)

#naredimo nov stolpec v katerem skupni naravni prirastek kategoriziramo
attach(tabela)
kategorije<-c('pozitiven','negativen','ni prirastka')
velikost<-"skupni.prirast"
velikost[skupni.prirast==0]<-'ni prirastka'
velikost[skupni.prirast < 0]<-'negativen'
velikost[skupni.prirast>0]<-'pozitiven'
velikost<-factor(velikost,levels=kategorije,ordered=TRUE)
detach(tabela)
dodatenstolpec<-data.frame(velikost)
tabela<-data.frame(tabela,velikost)

#Naredimo tabelo, kjer so podatki za vsaki leto posebaj:

tabela2010<- tabela[tabela[["leto"]] == "2010",]
tabela2011<- tabela[tabela[["leto"]] == "2011",]
tabela2012<- tabela[tabela[["leto"]] == "2012",]
tabela2013<- tabela[tabela[["leto"]] == "2013",]
tabela2014<- tabela[tabela[["leto"]] == "2014",]


#tabela2010<-tabela["2010"]


#Okenca, za katere ni podatka in so oznacena z "-", zamenjamo z "NA":
tabela[tabela == "-"] <- NA


#Uvozimo podatke iz datoteke evropa.html

html <- file("podatki/evropa.html") %>% readLines()
podatkiHTML <- grep("var dataValues", html, value = TRUE) %>%
  strapplyc('var dataValues="([^"]+)"') %>% .[[1]] %>%
  strsplit("|", fixed=TRUE) %>% unlist() %>%
  matrix(ncol=10, byrow=TRUE)

#Znake "-","(b):" zamenjamo z NA:
podatkiHTML[podatkiHTML == ":"] <- NA
podatkiHTML[podatkiHTML == "(b):"] <- NA

#izbrišemo del črk,ki se držijo številskih podatkov:
podatkiHTML <- gsub("[(b)]", " ", podatkiHTML)
podatkiHTML <- gsub("[(ep)]", " ", podatkiHTML)
podatkiHTML <- apply(podatkiHTML, 2, as.numeric)




#Filtriramo podatke za leta
podatkiLETA<- grep("var xValues", html, value=TRUE) %>%
  strapplyc('var xValues="([^"]+)"') %>% .[[1]] %>%
  strsplit("|", fixed=TRUE) %>% unlist() %>%
  matrix(nrow=1)

#vektor vseh let:
novipodatkiLETA<-podatkiLETA[seq(7,91,9)]

#Filtriramo podatke za države (če vnesem vrednost "colnames" vrne vse države)
podatkiDRZAVE <- grep("yValues", html, value = TRUE) %>%
  strapplyc('yValues="([^"]+)"') %>% .[[1]] %>%
  strsplit("|", fixed=TRUE) %>% unlist() %>%
  matrix(ncol=1)

#vekror vseh držav 
novipodatkiDRZAVE<-podatkiDRZAVE[seq(8,514,9)]

#podatke o letih, državah in prirastku združimo v tabelo
podatkiHTML <- data.frame(podatkiHTML, row.names = novipodatkiDRZAVE)
names(podatkiHTML) <- novipodatkiLETA

#izbriše prvih 7 stolpcev
podatkiHTML<-podatkiHTML[-(1:7),]

#izbrišemo nepotrebne vrstice
podatkiHTML<-podatkiHTML[,-(1:6)]
podatkiHTML<-podatkiHTML[-4,]
podatkiHTML<-podatkiHTML[-(29:31),]







##########################################################
#grafi za leto 2010 pri katerih je prikazan naravni prirast, ki je ločen glede na velikost

negativen.prirast2010<-ggplot(data=tabela2010 %>% filter(velikost=="negativen"), aes(x=kraj, y=skupni.prirast)) + geom_point()
pozitiven.prirast2011<-ggplot(data=tabela2010 %>% filter(velikost=="pozitiven"), aes(x=kraj, y=skupni.prirast)) + geom_point()
ni.prirasta2010<-ggplot(data=tabela2010 %>% filter(velikost=="ni prirastka"), aes(x=kraj, y=skupni.prirast)) + geom_point()

#tabela ki prikaže kraje s skupnim prirastkom več kot 100
ggplot(data=tabela %>% filter(skupni.prirast>100), aes(x=kraj, y=skupni.prirast,color=leto)) + geom_point()
ggplot(data=tabela %>% filter(skupni.prirast>100), aes(x=kraj, y=skupni.prirast,color=leto)) + geom_point()


#grafi
ptuj<-tabela[tabela[["kraj"]] == "Ptuj",]
ggplot(data=ptuj, aes(y=umrle.zenske,x=leto)) + geom_point() 


#graf prikazuje naravni prirastek po krajih, barve pik razlikujejo leta
p<-ggplot(tabela) + aes(x = kraj, y = naravni.prirast.moski) + geom_point()
p + aes(x = kraj, y = naravni.prirast.moski, color = leto) + geom_point()


ggplot(data=tabela2014,aes(y=umrli.moski,x =kraj),color="blue")+geom_point()+geom_point(aes(y=umrle.zenske,x=kraj),color="yellow")+geom_point()+geom_point(aes(y=skupni.prirast,x=kraj),color="orange")


                                                                                                      
#####################################################################
#ZEMLJEVIDI

#tabelam dodamo Ankaran ki je na novo nastala občina
rownames(tabela2010) <- tabela2010$kraj
tabela2010["Ankaran",] <- rep(NA, ncol(tabela2010))
tabela2010$kraj <- rownames(tabela2010)
tabela2010 <- tabela2011[order(tabela2010$kraj),]

rownames(tabela2011) <- tabela2011$kraj
tabela2011["Ankaran",] <- rep(NA, ncol(tabela2011))
tabela2011$kraj <- rownames(tabela2011)
tabela2011 <- tabela2011[order(tabela2011$kraj),]

rownames(tabela2012) <- tabela2012$kraj
tabela2012["Ankaran",] <- rep(NA, ncol(tabela2012))
tabela2012$kraj <- rownames(tabela2012)
tabela2012 <- tabela2012[order(tabela2012$kraj),]

rownames(tabela2013) <- tabela2013$kraj
tabela2013["Ankaran",] <- rep(NA, ncol(tabela2013))
tabela2013$kraj <- rownames(tabela2013)
tabela2013<-tabela2013[order(tabela2013$kraj),]

rownames(tabela2014) <- tabela2014$kraj
tabela2014["Ankaran",] <- rep(NA, ncol(tabela2014))
tabela2014$kraj <- rownames(tabela2014)
tabela2014<-tabela2013[order(tabela2014$kraj),]

source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
library(ggplot2)
library(dplyr)

pretvori.zemljevid <- function(zemljevid) {
  fo <- fortify(zemljevid)
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))
}
obc <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip",
                          "OB/OB", encoding = "Windows-1250")
obc <- obc[order(as.character(obc$OB_UIME)),]




obc$PRIRAST<-tabela2011$skupni.prirast
obc$RODNOST<-tabela2011$zivorojeni.moski + tabela2011$zivorojene.zenske
obc$UMRLIVOST<-tabela2011$umrli.moski + tabela2011$umrle.zenske
obc <- pretvori.zemljevid(obc)

ggplot() + geom_polygon(data = obc, aes(x = long, y = lat, group = group, fill = PRIRAST),color = "grey") +
  scale_fill_gradient(low="#d6b6ac", high="#090604") +
  guides(fill = guide_colorbar(title = "Naravni prirast 2011"))

ggplot() + geom_polygon(data = obc, aes(x = long, y = lat, group = group, fill = UMRLIVOST),color = "grey") +
  scale_fill_gradient(low="#fded75", high= "#100f00") +
  guides(fill = guide_colorbar(title = "Umrlivost 2011"))

ggplot() + geom_polygon(data = obc, aes(x = long, y = lat, group = group, fill = RODNOST),color = "grey") +
  scale_fill_gradient(low="#a65353", high= "#582b2b") +
  guides(fill = guide_colorbar(title = "Rodnost 2011"))



