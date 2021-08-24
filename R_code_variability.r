#R_code_variability.r

#librerie

library(raster)
library(RStoolbox) 
library(ggplot2)
#install.packages("viridis")
library(viridis)
library(gridExtra)

setwd("C:/lab/")

#importo immagine con la funzione brick
sent <- brick("sentinel.png")

# NIR 1, RED 2 , GREEN 3
# r=1, g=2, B=3
plotRGB(sent, stretch="lin") #composizone di default
# oppure: 
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

#associo 1° banda a oggetto (nir)
nir <- sent$sentinel.1
#associo 2° banda a oggetto (red)
red <- sent$sentinel.2

#calcolo NDVI e plot
ndvi <- (nir-red)/(nir+red)
plot(ndvi)
#cambio colori con la colorRampPalette
cl <- colorRampPalette(c("black","white","red","magenta","green"))(100)
plot(ndvi,col=cl)

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)

#PCA                
sentpca <- rasterPCA(sent)
plot(sentpca$map)

summary(sentpca$model)
#the first PC contains 67.36804% of the original information
