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
