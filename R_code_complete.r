# R code complete - Telerilevamento Geo-Ecologico

#------------------------------------------------

# Sommario:

# 1. Remote sensing first code
# 2. R code time series 
# 3. R code Copernicus data
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover
# 10. R code variability
# 11. R code spectral signatures


#------------------------------------------------

# 1. Remote sensing first code

# My first code in R for remote sensing!!!
# Il mio primo codice in R per il telerilevamento!

# install.packages("raster")#Installa pachetti, bisogna sempre inserire le virgolette perchè si esce dal server
library(raster)

# collegamento tra cartella lab ed R
setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

# mi permette di importare un immagine satellitare contenuta nella cartella lab.
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# informazioni sull'immagine caricata 
p224r63_2011
# plot mi permette di visualizzare l'immagine appena caricata.
plot(p224r63_2011)

# cambio colore
cl <- colorRampPalette(c("black","grey","light grey")) (100) 
plot(p224r63_2011, col=cl)

#### DAY 2

# colour change -> new
cl <- colorRampPalette(c("blue","green","grey","red","magenta","yellow")) (100) 
plot(p224r63_2011, col=cl)

cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011, col=cls)                       

#### DAY 3
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# dev.off ripulisce la finestra grafica
dev.off()
# se volessi vedere solo la banda del blu: 
plot(p224r63_2011$B1_sre)
# plotto con il cambio colori a mio piacimento
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cls)

dev.off()

# plot singole bande con la funzione par =settaggio parametri grafici di un certo grafico che vogliamo creare
# row=1,2 una riga e due colonne:
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 row, 1 columns
par(mfrow=c(2,1)) # se uno le colonne prima: par(mfcol....)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# plot le prime 4 bande di Landsat (4 righe e 1 colonna)
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)


# plot le prime 4 bande di Landsat (2 righe e 2 colonne)
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# plot con cambio colore ad ogni banda
par(mfrow=c(2,2))
# blu
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)
# verde
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)
# rosso
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)
# infrarosso
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

### Day 4
# Visualizing data by RGB plotting


# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio
# plotRGB per montare 3 bande alla volta e associare una banda a una componente di RGB + stretch="lin" per permettere di visualizzare tutte le sfumature di colori presenti nelle bande
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
# abbiamo creato un immagine a colori naturali

# Exercise: mount a 2x2 multiframe
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# pdf della nostra immagine
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

# Multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988


plot(p224r63_1988)
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# creo pdf
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()
# stretch hist/ stretch lin 
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")


# par natural colours, flase colours, and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# Installiamo un nuovo pacchetto per poter fare una PCA sui nostri dati
# install.packages("RStoolbox")
# library(RStoolbox)

### Day 5

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
# Multitemporal set, carichiamo una nuova immagine dalla cartella lab
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988
# Facciamo un plot di questa nuova immagine andando a vedere tutte le bande
plot(p224r63_1988)
# Plottiamola ora con RGB
plotRGB(p224r63_1988,r=3,g=2,b=1, stretch="Lin")
# Usiamo sempre lo schema RGB ma inseriamo la banda dell'infrarosso
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Lin")
# Confrontiamo ora l'immagine del 1988 e quella 2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
# Confrontiamo ora l'immagine del 1988 e quella del 2011 prima riga stretch lineare, seconda riga hystogram stretch e facciamone un pdf
pdf("il_mio_secondo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Hist")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Hist")
dev.off()
#------------------------------------------------

# 2. R code time series

# time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

#problema con rgdal
install.packages("rgdal")
# install packages raster
# install packages rasterVis
install.packages(rasterVis)
library(raster)
library(rasterVis)

setwd("C:/lab/greenland")

# raster = funzione per caricaricare singoli dati  
# carichiamo tutti le immagini lst della groenlandia del 2000, 2005, 2010, 2015

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

# par 2x2
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# lapply importa tutte le immagini insieme
# lista dei nostri file per poter usare questa funzione
# con il pattern identifichiamo la scritta in comune a tutti i file quindi nel nostro caso lst

#list f files
list.files()
rlist <- list.files(pattern="lst")
import <- lapply(rlist,raster)

# stack function impacchetta i file
TGr <- stack(import)
# ora posso plottare direttamente il pacchetto
plot(TGr)

# le plottiamo tutte insieme con RGB
#1=mappa 2000, 2=mappa 2005, 3=mappa 2010, 4=mappa 2015
# Mappa blu del 2010 (perchè B=3) 
plotRGB(TGr, 1, 2, 3, stretch="Lin")
# Mappa blu del 2015(perchè B=4)
plotRGB(TGr, 2, 3, 4, stretch="Lin")
# invertiamo i valori ma la mappa non cambia di molto
plotRGB(TGr, 4, 3, 2, stretch="Lin")

# levelplot permette di plottare la nosta immagine meglio graficamente con una solo scala e una sola legenda 
levelplot(TGr)

# legato ad una solo mappa con statistiche laterali 
levelplot(TGr$lst_2000)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)

#rinomino singoli attributi
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
# diamo anche un titolo con main
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#lista melt con pattern comune
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist, raster)
melt <- stack(melt_import)
melt


levelplot(melt)

# matrixalgebra cioè l'algebra associata alle matrici andiamo a vedere il valore di scioglimento nel tempo 
# sottrazione tra gli strati del 2007 e del 1979
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
clb <- colorRampPalette(c("blue", "white", "red")) (100)
plot(melt_amount, col=clb)
melt_amount
levelplot(melt_amount, col.regions=clb)

#------------------------------------------------

# 3. R code Copernicus data

# R_code_copernicus.r
# Visualizing Copernicus data

# install.packages("ncdf4")
library(raster)
library(ncdf4)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

# diamo un nome al nostro set
albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) # 
plot(albed0, col=cl)

# aggregate va ad aggregare vari pixel per alleggerire la mia immagine
# Uso il fact nella mia funzione es fact=100 ogni 100 pixel avrò 1 pixel (linearmente 100x100 pixel li trasformiamo in 1 pixel)
# Ricampionamento bilaterale (resampling)
albedores <- aggregate(albedo, fact=100)
plot(albedores, col=cl)


#------------------------------------------------

# 4. R code knitr


#R_code_knitr.r

# knitr può usare un codice esterno per creare un report
# prende il codice all'esterno e lo importa, e genererà un report è verrà salvato nella cartella in cui è salvato il codice

setwd("C:/lab/")  
library(knitr)
#genera il report con estensione .tex
stitch("R_code_time_series.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#------------------------------------------------

# 5. R code multivariate analysis

# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)
setwd("C:/lab/")  
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

# pixel della banda 1 contro quelli della banda 2
# col=cambio colore dei punti, pch=forma dei punti, cex=dimensione punti
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

#correlazione tra le variabili
pairs(p224r63_2011)

### Day 2

#aggregate cells
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

# confronto per vederne le differenze
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

# rasterPCA: prende il pacchetto di dati e li compatta in un numero minore di bande
p224r63_2011res_pca <-rasterPCA(p224r63_2011res)
# summary ci da un sommario del nostro modello, vediamo la varianza delle varie componenti delle bande
summary(p224r63_2011res_pca$model)

plot(p224r63_2011res_pca$map)
p224r63_2011res_pca

plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

plot(p224r63_2011res_pca$map$PC1, p224r63_2011res_pca$map$PC2)

# str ci da informazioni sulla struttura del file e informazioni aggiuntive
str(p224r63_2011res_pca)
#------------------------------------------------

# 6. R code classification

# R_code_classification.r

install.packages("RStoolbox")

library(raster)
library(RStoolbox)

### Day 1

setwd("C:/lab/")  

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so

#visualize RGB levels
plotRGB (so, 1, 2, 3, stretch="lin")

# unsupervised classification
soc <- unsuperClass (so, nClasses=3)
# plotto la nostra immagine (soc) classificata ma solo della mappa
plot(soc$map)

# unsupervised classification with 20 classes
soc20 <- unsuperClass (so, nClasses=20)
plot(soc20$map)

# download an image from the site
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <-brick("sun.jpg")
sunc <- unsuperClass (sun, nClasses=3)
plot(sunc$map)

### Day 2

#download Solar Orbiter data and proceed further
# download of: https://landsat.visibleearth.nasa.gov/view.php?id=80948
#Grand Canyon (dolansprings_oli_2013088_canyon_lrg)

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# unsupervised classification with 2 classes
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

# unsupervised classification with 4 classes
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#------------------------------------------------

# 7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#------------------------------------------------

# 8. R code vegetation indices

# R_code_vegetation_indices.r

library(raster) # require(raster)
library(RStoolbox) # for vegetation indices calculation 
# install.packages("rasterdiv")
library(rasterdiv) # for the worldwide NDVI
# install.packages("rasterVis")
library(rasterVis)


setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# carico le immagini
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

### Day 2

defor1
#NIR=defor1.1 , RED=defor1.2
# primo indice dvi1= (banda dell'infrarosso) - (banda del rosso)

# difference vegetation index

# time 1
dvi1 <- defor1$defor1.1 - defor1$defor1.2
# dev.off()
plot(dvi1)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1, col=cl, main="DVI at time 1")

# time 2
defor2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")

# plot unito per vedere le differenze
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
# differenza tra i due dvi
difdvi <- dvi1 - dvi2

# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)


# ndvi
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)
# possiamo scrivere anche:
# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot(ndvi1, col=cl)


#ndvi2
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)
# possiamo scrivere anche:
# ndvi1 <- dvi2 / (defor2$defor2.1 + defor1$defor2.2)
# plot(ndvi2, col=cl)

# differenza NDVI
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)


# RStoolbox::spectralIndices per calcolare tutti gli indici
# b1=NIR, b2=red, b3=green
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)
# lo facciamo anche per la seconda immagine
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)


### Day 3

# worldwide NDVI
plot(copNDVI)

# Pixels with values 253, 254 and 255 (water) will be set as NA’s.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

# rasterVis package needed:
levelplot(copNDVI)

#------------------------------------------------

# 9. R code land cover

# R_code_land_cover.r

library(raster)
library(RStoolbox) # classification
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra)
setwd("C:/lab/") 



defor1 <- brick("defor1.jpg")
# NIR 1, RED 2, GREEN 3
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
# plot con ggplot per vedere anche le coordinate
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

# facciamo lo stesso con la seconda immagine
defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with plotRGB
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1,p2, nrow=2)

### Day 2

# dividiamo in 2 classi le nostre immagini 
# unsupervised classification
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
#class 1: forest
#class 2: agriculture
#set.seed() would allow you to attain the same results...

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
#class 1: agriculture
#class 2: forest

#facciamo di defor2 3 classi 
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#frequencies
freq(d1c$map)
# value  count
# [1,]     1 306651
# [2,]     2  34641

#sum
s1 <- 306651+34641

#proporzione
prop1 <- freq(d1c$map)/s1
#prop forest: 0.8985004
#prop agriculture: 0.1014996

#sum2
s2 <- 342726

#proporzione2
prop2 <- freq(d2c$map)/s2
#prop forest: 0.5198176
#prop agriculture: 0.4801824

#dataset 
#cover=Prima colonna fattori (valori categorie: foresta, agricoltura)
#percent_1992= seconda colonna(valori percetuale 1992)
#percent_2006= terza colonna(valori percentuale 2006)
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.85, 10.15)
percent_2006 <- c(51.98, 48.02)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#        cover percent_1992 percent_2006
# 1      Forest        89.25        51.97
# 2      Agriculture   10.75        48.03

#let's plot them!
#aes=estetica, geom_bar= grafico a barre
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

# uniamo i grafici
grid.arrange(p1, p2, nrow=1)

#------------------------------------------------

# 10. R code variability

# R_code_variability.r

library(raster)
library(RStoolbox)
# install.packages("RStoolbox")
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplots together
# install.packages("viridis")
library(viridis) # for ggplot colouring


setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

sent <- brick("sentinel.png")

# NIR 1, RED 2, GREEN 3
# Già di default la sequenza per questa funzione è r=1, g=2, b=3 quindi possiamo anche evitare di scrivere
# r=1, g=2, b=3
plotRGB(sent, stretch="lin") 
# è uguale a: plotRGB(sent, r=1, g=2, b=3, stretch="lin") 

plotRGB(sent, r=2, g=1, b=3, stretch="lin") 

# nell'immagine sent nominiamo le bande Nir=1, Red=2
nir <- sent$sentinel.1
red <- sent$sentinel.2

#calcolo ndvi
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)
# blu e verde= deviazione più bassa; rossa e gialla= deviazione più alta 
# blu=roccia omogenia, verde=zone confine roccia e vegetazione,
# grandi praterie la deviazione standard torna a diminuire perchè molto simili tra di loro come riflettanza

# media ndvi
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd3, col=clsd)
# Valori molto alti per i boschi e le praterie, valori più bassi per la roccia nuda

# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)

# changing window size
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd13, col=clsd)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)

# Cambiamo la grandezza della nostra moving windows (deve essere sempre dispari)
# Usiamo 13*13 pixel 
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
plot(ndvisd13, col=clsd)

# cambiano ancora la gradezza
# usiamo 5*5 pixel
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
plot(ndvisd5, col=clsd)


# PCA prima componente con  funzione rasterPCA
sentpca <- rasterPCA(sent) 
plot(sentpca$map)  
# PC1 è la migliore, man mano che passiamo alle altre le informazioni diminuisono drasticamente
sentpca
# Vediamo quanta proporzione di varianza viene spiegata in ogni componente
summary(sentpca$model)

# the first PC contains 67.36804% of the original information

### Day 2

pc1 <- sentpca$map$PC1

# funzione focal con la PC1, facciamo la sd di una sola banda
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(pc1sd5, col=clsd)

# pc1 <- sentpca$map$PC1
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)

# With the source function you can upload code from outside!
source("source_test_lezione.r")
source("source_ggplot.r")

# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.

# Fare una nuova finestra con ggplot vuota
ggplot()
# Aggiungiamo un blocco a ggplot
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer))
# Aggungiamo la funzione per le legende di viridis
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()
# Aggiungiamo un titolo alla nostra mappa
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by viridis colour scale"
        
        
# magma
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")

# inferno
p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

# turbo        
p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "turbo")  +
ggtitle("Standard deviation of PC1 by turbo colour scale")

# Possiamo mettere tutte queste legende tutte in una volta (1magma=p1, 1inferno=p2, 1turbo=p3) con la funzione grid.arrage
grid.arrange(p1, p2, p3, nrow = 1)

#------------------------------------------------

# 11. R code spectral signatures

# R_code_spectral_signatures.r

library(raster)
library(rgdal)
library(ggplot2)

setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

        
# Carichiamo il dataset con tutte le bande
defor2 <- brick("defor2.jpg")
# defor2.1, defor2.2, defor2.3 
# NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

        
# Creamo delle firme spettrali con la funzione "click"
#T=true, type=point, pch= è la forma del point        
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
# cliccando su un pixel di vegetazione abbiamo: B1=valore molto alto, B2=valore molto basso, B3=valore medio basso 
# cliccando su un pixel d'acqua abbiamo: B1=valore basso, B2=valore alta, B3= valore più alto
# results:
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 178.5 435.5 30293      206        6       19
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 571.5 245.5 166916       40       99      139

# define the columns of the dataset:
band <- c(1,2,3)
forest <- c(206,6,19)
water <- c(40,99,139)
# create the dataframe
spectrals <- data.frame(band, forest, water)

# plot the sepctral signatures
#definiamo subito l'asse x, nella x mettiamo le bande, nella y mettiamo la riflettanza foresta e acqua
#geom_line inserisce le geometrie nel mio plot aperto in precedenza dalla funzione ggplot        
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") +
 labs(x="band",y="reflectance")

############### Multitemporal
# multitemporal analysis with defor1 and defor2
defor1 <- brick("defor1.jpg")

plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

# spectral signatures defor1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results time 1:
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 89.5 339.5 98622      223       11       33
#     x     y   cell defor1.1 defor1.2 defor1.3
# 1 42.5 336.5 100717      218       16       38
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 64.5 341.5 97169      213       36       46
#      x     y   cell defor1.1 defor1.2 defor1.3
# 1 80.5 326.5 107895      208        2       22
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 76.5 374.5 73619      224       21       41

# time t2
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results time 2:
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 86.5 339.5 99033      197      163      151
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 104.5 338.5 99768      149      157      133
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 110.5 354.5 88302      197      132      128
#     x     y   cell defor2.1 defor2.2 defor2.3
# 1 90.5 320.5 112660      169      166      149
#    x     y   cell defor2.1 defor2.2 defor2.3
# 1 97.5 309.5 120554      150      137      129

# define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149,157,133)
spectralst <- data.frame(band, time1, time2, time1p2, time2p2)


# plot the sepctral signatures
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red", linetype="dotted") +
 geom_line(aes(y=time1p2), color="red", linetype="dotted") +
 geom_line(aes(y=time2), linetype="dotted") +
 geom_line(aes(y=time2p2), linetype="dotted") +
 labs(x="band",y="reflectance")

# image from Earth Observatory

eo <- brick("june_puzzler.jpg")
plotRGB(eo, 1,2,3, stretch="hist")
# Spectral signature         
click(eo, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
        
# results:
#     x     y  cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 1 93.5 373.5 76414            187            163             11
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 1 219.5 285.5 139900             11            140              0
#     x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 1 184.5 315.5 118265             41             40             20


# define the columns of the dataset:
band <- c(1,2,3)
stratum1 <- c(187,163,11)
stratum2 <- c(11,140,0)
stratum3 <- c(41,40,20)

spectralsg <- data.frame(band, stratum1, stratum2, stratum3)

# plot the sepctral signatures
ggplot(spectralsg, aes(x=band)) +
 geom_line(aes(y=stratum1), color="yellow") +
 geom_line(aes(y=stratum2), color="green") +
 geom_line(aes(y=stratum3), color="blue") +
 labs(x="band",y="reflectance")

#----------------------------------------------------------------------






