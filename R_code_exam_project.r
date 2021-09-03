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

# Upload with function raster
aral_2000_r <- raster("aralsea_2000.jpg")
aral_2006_r <- raster("aralsea_2006.jpg")
aral_2012_r <- raster("aralsea_2012.jpg")
aral_2018_r <- raster("aralsea_2018.jpg") 

col <- colorRampPalette(c("green","yellow","red","blue"))(100)

aralsea <- stack(aral_2000_r,aral_2006_r,aral_2012_r,aral_2018_r) 

levelplot(aralsea,col.regions=col, main="ARAL SEA", names.attr=c("Situazione nel 2000","Situazione nel 2006","Situazione nel 2012","Situazione nel 2018"))


# importo i file 
# creo una lista di file con list.files per la funzione lapply 
# arallist <- list.files(pattern="aralsea") 
# arallist

# applico con lapply una funzione raster alla lista dei file
# import <- lapply(arallist,raster)
# import
# uso stack che mi raggruppa i singoli files in uno unico
# TGr <- stack(import)
# plot(TGr)
# plotto con immagini sovrapposte
# plotRGB(TGr, r=1, g=2, b=3, stretch="lin")
# plotto in scale di grigio diverse, coordinate x e y e qualità immagine superiore
# ggRGB(TGr, r=1, g=2, b=3, stretch="lin")

# Funzione levelplot: disegna più grafici di colore falso con una singola legenda
# levelplot(TGr)
# colorRampPalette (NON SI USA SU RGB)
col<-colorRampPalette(c("white","dark green","yellow","red","black"))(100)

# Nuovo levelplot col cambio di colori, nome e titolo
# levelplot(TGr,col.regions=col, main="Shinking Aral Sea", names.attr=c("2000","2006", "2012", "2018"))

##########################################################

# Plot di tutte le correlazioni tra bande di un dataset (matrice di scatterplot di dati, non immagini)
# La tabella riporta in diagonale le bande (sono le variabili), l'indice di correlazione varia da 0(minima) a 1 (massima)
pairs(aralsea, main="Comparazione con la funzione pairs")
# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri


##########################################################

# PCA (principal component analysis)
# PCA 2000
aralsea2000_pca <- rasterPCA(arals_2000)
summary(aralsea2000_pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     72.5528188 11.63800097 10.04845015
# Proportion of Variance  0.9570181  0.02462455  0.01835734
# Cumulative Proportion   0.9570181  0.98164266  1.00000000

plotRGB(aralsea2000_pca$map,r=1,g=3,b=2, stretch="hist")
# Per vedere il grafico
plot(aralsea2000_pca$model) 


# PCA 2006
aralsea2006_pca <- rasterPCA(arals_2006)
summary(aralsea2006_pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     57.0906093 12.92855516 5.791989062
# Proportion of Variance  0.9419963  0.04830809 0.009695614
# Cumulative Proportion   0.9419963  0.99030439 1.000000000

plotRGB(aralsea2006_pca$map,r=1,g=3,b=2, stretch="hist")
# Per vedere il grafico
plot(aralsea2006_pca$model) 


# PCA 2012
aralsea2012_pca <- rasterPCA(arals_2012)
summary(aralsea2012_pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     57.0970523 12.76733824 5.059113981
# Proportion of Variance  0.9453124  0.04726599 0.007421589
# Cumulative Proportion   0.9453124  0.99257841 1.000000000

plotRGB(aralsea2012_pca$map,r=1,g=3,b=2, stretch="hist")
# Per vedere il grafico
plot(aralsea2012_pca$model) 



# PCA 2018
aralsea2018_pca <- rasterPCA(arals_2018)
summary(aralsea2018_pca$model)

# Risultati 
# Importance of components:
#                           Comp.1      Comp.2     Comp.3
# Standard deviation     42.2375132 10.54507844 4.38071048
# Proportion of Variance  0.9318901  0.05808549 0.01002437
# Cumulative Proportion   0.9318901  0.98997563 1.00000000

plotRGB(aralsea2018_pca$map,r=1,g=3,b=2, stretch="hist")
# Per vedere il grafico
plot(aralsea2018_pca$model) 

# Comparazione tra le varie PCA
par(mfrow=c(2,2))
plotRGB(aralsea2000_pca$map,r=1,g=3,b=2, stretch="Hist")
plotRGB(aralsea2006_pca$map,r=1,g=3,b=2, stretch="Hist")
plotRGB(aralsea2012_pca$map,r=1,g=3,b=2, stretch="Hist")
plotRGB(aralsea2018_pca$map,r=1,g=3,b=2, stretch="Hist")

# Multiframe con ggplot2
as2000 <- ggRGB(aralsea2000_pca$map,r=1,g=3,b=2, stretch="Hist")
as2006 <- ggRGB(aralsea2006_pca$map,r=1,g=3,b=2, stretch="Hist")
as2012 <- ggRGB(aralsea2012_pca$map,r=1,g=3,b=2, stretch="Hist")
as2018 <- ggRGB(aralsea2018_pca$map,r=1,g=3,b=2, stretch="Hist")
grid.arrange(as2000, as2006,as2012,as2018, nrow=2)

##########################################################


# Firme spettrali

plotRGB(arals_2000, r=1, g=2, b=3, stretch="lin") 

# Bisogna avere la mappa fatta con plotRGB aperta sotto
# Funzione: click, usa immagine plotRGB per creare le firme spettrali 
click(arals_2000, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#      x     y   cell aralsea_2000.1 aralsea_2000.2 aralsea_2000.3
# 1 323.5 454.5 191124            162            146            110
#      x     y   cell aralsea_2000.1 aralsea_2000.2 aralsea_2000.3
# 1 300.5 157.5 404941            155            143            119
#      x     y   cell aralsea_2000.1 aralsea_2000.2 aralsea_2000.3
# 1 124.5 350.5 265805            157            131             98

plotRGB(arals_2018, r=1, g=2, b=3, stretch="lin") 
click(arals_2018, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#      x     y   cell aralsea_2018.1 aralsea_2018.2 aralsea_2018.3
# 1 318.5 441.5 200479            167            148            116
#      x     y   cell aralsea_2018.1 aralsea_2018.2 aralsea_2018.3
# 1 280.5 103.5 443801            117             82             62
#      x     y   cell aralsea_2018.1 aralsea_2018.2 aralsea_2018.3
# 1 104.5 311.5 293865            135            117             97

# Definire le colonne del dataset
band <- c(1,2,3)
aral_2000_p1 <- c(162,146,110)
aral_2000_p2 <- c(155,143,119)
aral_2000_p3 <- c(157,131,98)
aral_2018_p1 <- c(167,148,116)
aral_2018_p2 <- c(117,82,62)
aral_2018_p3 <- c(135,117,97)

spectralss <- data.frame(band,aral_2000_p1,aral_2000_p2,aral_2000_p3,aral_2018_p1,aral_2018_p2,aral_2018_p3)

# Plot
ggplot(spectralss, aes(x=band)) +
geom_line(aes(y = aral_2000_p1 ), color="red") +
geom_line(aes(y = aral_2000_p2), color="green") +
geom_line(aes(y = aral_2000_p3), color="yellow") +
geom_line(aes(y = aral_2018_p1), color="black") +
geom_line(aes(y = aral_2018_p2), color="blue") +
geom_line(aes(y = aral_2018_p3), color="pink") +

labs(x="band", y="reflectance")
