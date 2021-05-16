install.packages("RStoolbox")

library(raster)
library(RStoolbox)
setwd("C:/lab/")  

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#visualize RGB levels
plotRGB (so, 1, 2, 3, stretch="lin")
# unsupervised classification
soc <- unsuperClass (so, nClasses=3)
plot(soc$map)

# unsupervised classification with 20 classes
soc20 <- unsuperClass (so, nClasses=20)
plot(soc20$map)

#download an image from the site
sun <-brick("sun.jpg")
sunc <- unsuperClass (sun, nClasses=3)
plot(sunc$map)

#download Solar Orbiter data and proceed further
#Grand Canyon (dolansprings_oli_2013088_canyon_lrg)

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)


gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

