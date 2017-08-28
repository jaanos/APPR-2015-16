library(knitr)
library(XML)
library(httr)
library(dplyr)
library(sp)
library(maptools)
library(extrafont)
library(reshape2)
library(ggplot2)
library(gsubfn)
library(tidyr)


# Uvozimo funkcije za delo z datotekami XML.
source("lib/xml.r", encoding = "UTF-8")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")