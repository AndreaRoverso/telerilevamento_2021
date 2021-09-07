# R_code_exam_project.r

# Shinking Aral Sea from 2000 to 2018 
# Images from: https://earthobservatory.nasa.gov/world-of-change/AralSea

# Library
library(raster)
library(rasterVis)
library(RStoolbox)
library(ggplot2) 
library(gridExtra)
library(rgdal) 

setwd("C:/lab/exam") 

# Funzione brick per le 4 immagini in tre bande
arals2000 <- brick("aralsea2000.jpg")
arals2006 <- brick("aralsea2006.jpg")
arals2012 <- brick("aralsea2012.jpg")
arals2018 <- brick("aralsea2018.jpg")

# Funzione plotRGB per plottare con i colori originali
par(mfrow=c(2,2))
plotRGB(arals2000, r=1, g=2, b=3, stretch="lin") 
plotRGB(arals2006, r=1, g=2, b=3, stretch="lin")
plotRGB(arals2012, r=1, g=2, b=3, stretch="lin") 
plotRGB(arals2018, r=1, g=2, b=3, stretch="lin") 

# Funzione raster per importare le immagini con una sola banda
aral2000r <- raster("aralsea2000.jpg")
aral2006r <- raster("aralsea2006.jpg")
aral2012r <- raster("aralsea2012.jpg")
aral2018r <- raster("aralsea2018.jpg") 

# Scelgo i colori
col <- colorRampPalette(c("green","yellow","pink","blue"))(100)

# Creo uno stack 
aralsea <- stack(aral2000r,aral2006r,aral2012r,aral2018r) 

# Plot con levelPlot che disegna più grafici di colore "falso" con una singola legenda
# Con names.attr=c do uno titolo diverso alle quattro immagini
levelplot(aralsea,col.regions=col, main="LAGO D'ARAL", names.attr=c("Situazione nel 2000","Situazione nel 2006","Situazione nel 2012","Situazione nel 2018"))


##########################################################

# Plot di tutte le correlazioni tra bande di un dataset 
# Il grafico riporta in diagonale le bande (sono le variabili), l'indice di correlazione varia da 0( correlazione minima) a 1 (correlazione massima)
pairs(aralsea, main="Comparazione con la funzione pairs")
# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri


##########################################################

# PCA (principal component analysis)
# PCA 2000
aralsea2000pca <- rasterPCA(arals2000)
summary(aralsea2000pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     72.5528188 11.63800097 10.04845015
# Proportion of Variance  0.9570181  0.02462455  0.01835734
# Cumulative Proportion   0.9570181  0.98164266  1.00000000

plotRGB(aralsea2000pca$map,r=1,g=3,b=2, stretch="hist")

# Per vedere il grafico
plot(aralsea2000pca$model) 

# PCA 2006
aralsea2006pca <- rasterPCA(arals2006)
summary(aralsea2006pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     57.0906093 12.92855516 5.791989062
# Proportion of Variance  0.9419963  0.04830809 0.009695614
# Cumulative Proportion   0.9419963  0.99030439 1.000000000

plotRGB(aralsea2006pca$map,r=1,g=3,b=2, stretch="hist")

# Per vedere il grafico
plot(aralsea2006pca$model) 

# PCA 2012
aralsea2012pca <- rasterPCA(arals2012)
summary(aralsea2012pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     57.0970523 12.76733824 5.059113981
# Proportion of Variance  0.9453124  0.04726599 0.007421589
# Cumulative Proportion   0.9453124  0.99257841 1.000000000

plotRGB(aralsea2012pca$map,r=1,g=3,b=2, stretch="hist")

# Per vedere il grafico
plot(aralsea2012pca$model) 

# PCA 2018
aralsea2018pca <- rasterPCA(arals2018)
summary(aralsea2018pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2     Comp.3
# Standard deviation     42.2375132 10.54507844 4.38071048
# Proportion of Variance  0.9318901  0.05808549 0.01002437
# Cumulative Proportion   0.9318901  0.98997563 1.00000000

plotRGB(aralsea2018pca$map,r=1,g=3,b=2, stretch="hist")

# Per vedere il grafico
plot(aralsea2018pca$model) 

# Comparazione tra le varie PCA
par(mfrow=c(2,2))
plotRGB(aralsea2000pca$map,r=1,g=3,b=2, stretch="Hist")
plotRGB(aralsea2006pca$map,r=1,g=3,b=2, stretch="Hist")
plotRGB(aralsea2012pca$map,r=1,g=3,b=2, stretch="Hist")
plotRGB(aralsea2018pca$map,r=1,g=3,b=2, stretch="Hist")

# Multiframe con ggplot2
as2000 <- ggRGB(aralsea2000pca$map,r=1,g=3,b=2, stretch="Hist")
as2006 <- ggRGB(aralsea2006pca$map,r=1,g=3,b=2, stretch="Hist")
as2012 <- ggRGB(aralsea2012pca$map,r=1,g=3,b=2, stretch="Hist")
as2018 <- ggRGB(aralsea2018pca$map,r=1,g=3,b=2, stretch="Hist")
grid.arrange(as2000, as2006,as2012,as2018, nrow=2)

C <- grid.arrange(as2000, as2006, as2012, as2018, nrow=2)
ggsave("grid.arrange.jpg",C) 
# Bisogna specificare cosa salvare esplicitamente, altrimenti salva solo l'ultimo grafico non l'intero grid.arrange



##########################################################

# Spectral Indices

# La funzione spectralIndices permette di calcolare tutti gli indici
# b1=NIR, b2=rosso, b3=verde
# Immagine del Lago Aral nel 2000 
spAs2000 <- spectralIndices(arals2000, green = 3, red = 2, nir = 1) 
# Cambio i colori con colorRampPalette
cl <- colorRampPalette(c('pink','light blue','red','yellow'))(100)
# Nuovo plot col cambio di colori
plot(spAs2000, col=cl)

# Immagine del Lago Aral nel 2006
spAs2006 <- spectralIndices(arals2006, green = 3, red = 2, nir = 1) 
plot(spAs2006, col=cl)

# Immagine del Lago Aral nel 2012
spAs2012 <- spectralIndices(arals2012, green = 3, red = 2, nir = 1) 
plot(spAs2012, col=cl)

# Immagine del Lago Aral nel 2018
spAs2018 <- spectralIndices(arals2018, green = 3, red = 2, nir = 1) 
plot(spAs2018, col=cl)


#################################################################################

# Firme spettrali

# Immagine del 2000
plotRGB(arals2000, r=1, g=2, b=3, stretch="lin") 
# Bisogna avere la mappa con plotRGB aperta
# Funzione: click, usa immagine plotRGB per creare le firme spettrali 
click(arals2000, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# Risultati:
#      x     y  cell aralsea2000.1 aralsea2000.2 aralsea2000.3
# 1 451.5 600.5 86132             2            19            11
#      x     y   cell aralsea2000.1 aralsea2000.2 aralsea2000.3
# 1 154.5 235.5 348635             5            58            32
#      x     y   cell aralsea2000.1 aralsea2000.2 aralsea2000.3
# 1 391.5 273.5 321512           101           127            56

# Immagine del 2018
plotRGB(arals2018, r=1, g=2, b=3, stretch="lin") 
click(arals2018, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# Risultati:
#      x     y  cell aralsea2018.1 aralsea2018.2 aralsea2018.3
# 1 460.5 591.5 92621            55           107            85
#      x     y   cell aralsea2018.1 aralsea2018.2 aralsea2018.3
# 1 421.5 235.5 348902           162           149           130
#      x     y   cell aralsea2018.1 aralsea2018.2 aralsea2018.3
# 1 157.5 223.5 357278           169           160           145

# Creo un dataset con i risultati
band <- c(1,2,3)
aral2000p1 <- c(2,19,11)
aral2000p2 <- c(5,58,32)
aral2000p3 <- c(101,127,56)
aral2018p1 <- c(55,107,85)
aral2018p2 <- c(162,149,130)
aral2018p3 <- c(169,160,145)

spectralss <- data.frame(band,aral2000p1,aral2000p2,aral2000p3,aral2018p1,aral2018p2,aral2018p3)

spectralss
#  band   aral2000p1  aral2000p2  aral2000p3  aral2018p1  aral2018p2  aral2018p3
#  1      2           5           101         55          162         169
#  2      19          58          127         107         149         160
#  3      11          32          56          85          130         145


# Plotto con ggplot con un colore differente per ogni risultato
ggplot(spectralss, aes(x=band)) +
geom_line(aes(y = aral2000p1 ), linetype="dotdash", color="red", size=2) +
geom_line(aes(y = aral2000p2), linetype="dotdash", color="green", size=2) +
geom_line(aes(y = aral2000p3), linetype="dotdash", color="purple", size=2) +
geom_line(aes(y = aral2018p1), color="black") +
geom_line(aes(y = aral2018p2), color="blue") +
geom_line(aes(y = aral2018p3), color="pink") +

labs(x="band", y="reflectance")
