# R_code_exam_project.r

# Shinking Aral Sea from 2000 to 2018 
# Images from: https://earthobservatory.nasa.gov/world-of-change/AralSea

# library
library(raster)
library(rasterVis)
library(RStoolbox)
library(ggplot2) 
library(gridExtra)
library(rgdal) 

setwd("C:/lab/exam") 

arals_2000 <- brick("aralsea_2000.jpg")

arals_2006 <- brick("aralsea_2006.jpg")

arals_2012 <- brick("aralsea_2012.jpg")

arals_2018 <- brick("aralsea_2018.jpg")

# Funzione plotRGB
par(mfrow=c(2,2))
plotRGB(arals_2000, r=1, g=2, b=3, stretch="lin") 
plotRGB(arals_2006, r=1, g=2, b=3, stretch="lin")
plotRGB(arals_2012, r=1, g=2, b=3, stretch="lin") 
plotRGB(arals_2018, r=1, g=2, b=3, stretch="lin") 


# importo i file 
# creo una lista di file con list.files per la funzione lapply 
arallist <- list.files(pattern="aralsea") 
arallist
plot(arallist)
# applico con lapply una funzione raster alla lista dei file
import <- lapply(arallist,raster)
import
# uso stack che mi raggruppa i singoli files in uno unico
TGr <- stack(import)
plot(TGr)
# plotto con immagini sovrapposte
plotRGB(TGr, r=1, g=2, b=3, stretch="lin")
# plotto in scale di grigio diverse, coordinate x e y e qualità immagine superiore
ggRGB(TGr, r=1, g=2, b=3, stretch="lin")

# Funzione levelplot: disegna più grafici di colore falso con una singola legenda
levelplot(TGr)
# colorRampPalette (NON SI USA SU RGB)
col<-colorRampPalette(c("white","dark green","yellow","red","black"))(100)

# Nuovo levelplot col cambio di colori, nome e titolo
levelplot(TGr,col.regions=col, main="Shinking Aral Sea", names.attr=c("2000","2006", "2012", "2018"))

##########################################################

# Plot di tutte le correlazioni tra bande di un dataset (matrice di scatterplot di dati, non immagini)
# La tabella riporta in diagonale le bande (sono le variabili), l'indice di correlazione varia da 0(negativo) a 1 (positivo)
pairs(TGr)
# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri


##########################################################

# Importazione delle singole immagini per effettuare comparazioni
# Funzione: brick, importa i singoli file
# Funzione brick per importare i dati/immagine

arals_2000 <- brick("aralsea_2000.jpg")
arals_2018 <- brick("aralsea_2018.jpg")

# Funzione plotRGB

plotRGB(arals_2000, r=1, g=2, b=3, stretch="lin") 

# Bisogna avere la mappa fatta con plotRGB aperta sotto
# Funzione: click, usa immagine plotRGB per creare le firme spettrali 
click(arals_2000, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# x     y   cell aralsea_2000.1 aralsea_2000.2 aralsea_2000.3
# 1 347.5 470.5 179628            170            151            111
#      x     y   cell aralsea_2000.1 aralsea_2000.2 aralsea_2000.3
# 1 421.5 265.5 327302            176            163            131
#      x     y   cell aralsea_2000.1 aralsea_2000.2 aralsea_2000.3
# 1 214.5 200.5 373895            178            167            139


plotRGB(arals_2018, r=1, g=2, b=3, stretch="lin") 
click(arals_2018, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#      x     y   cell aralsea_2018.1 aralsea_2018.2 aralsea_2018.3
# 1 349.5 427.5 210590            153            145            126
#      x     y   cell aralsea_2018.1 aralsea_2018.2 aralsea_2018.3
# 1 196.5 256.5 333557            168            159            142
#      x     y   cell aralsea_2018.1 aralsea_2018.2 aralsea_2018.3
# 1 334.5 253.5 335855            163            155            142
#      x     y   cell aralsea_2018.1 aralsea_2018.2 aralsea_2018.3


# Definire le colonne del dataset
band <- c(1,2,3)
aral_2000_p1 <- c(170,151,111)
aral_2000_p2 <- c(176,163,131)
aral_2000_p3 <- c(178,167,139)
aral_2018_p1 <- c(153,145,126)
aral_2018_p2 <- c(168,159,142)
aral_2018_p3 <- c(163,155,142)
