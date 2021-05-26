# R_code_land_cover.r

library(raster)
library(RStoolbox) # classification
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra)
setwd("C:/lab/") 

# NIR 1, RED 2, GREEN 3

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")


defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1,p2, nrow=2)

#unsupervised classification
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
#class 1: forest
#class 2: agriculture

#set.seed() would allow you to attain the same results...

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
#class 1: agriculture
#class 2: forest

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)
