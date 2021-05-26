#R_code_variability.r

library(raster)
library(RStoolbox) 
library(ggplot2)
#install.packages("viridis")
library(viridis)
library(gridExtra)
setwd("C:/lab/") 

sent <- brick("sentinel.png")

# NIR 1, RED 2, GREEN 3
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

nir <- sent$sentinel.1
red <- sent$sentinel.2

ndvi <- (nir-red)/(nir+red)
plot(ndvi)
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
