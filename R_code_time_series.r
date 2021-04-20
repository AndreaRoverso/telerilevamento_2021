# time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

#problema con rgdal
install.packages("rgdal")
install.packages(rasterVis)
# install packages raster
#install packages rasterVis
library(raster)
library(rasterVis)

setwd("C:/lab/greenland")
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

#par
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#list f files
list.files()
rlist <- list.files(pattern="lst")
import <- lapply(rlist,raster)

# stack function
TGr <- stack(import)
plot(TGr)
plotRGB(TGr,1,2,3, stretch="Lin")
plotRGB(TGr,2,3,4, stretch="Lin")

levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)

#rinomino singoli attributi
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#lista melt con pattern comune
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist, raster)
melt <- stack(melt_import)
melt

levelplot(melt)

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
clb <- colorRampPalette(c("blue", "white", "red")(100)
plot(melt_amount, col=clb)
melt_amount
levelplot(melt_amount, col.regions=clb)
