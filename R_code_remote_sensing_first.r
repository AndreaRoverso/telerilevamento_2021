# my first r code
setwd("C:/lab/")  
# install.packages ("raster")
library (raster)
 
p224r63_2011 <- brick("p224r63_2011_masked.grd")

p224r63_2011
class      : RasterBrick 
dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
resolution : 30, 30  (x, y)
extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
source     : C:/lab/p224r63_2011_masked.grd 
names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 

plot(p224r63_2011)
 
#color change
cl <- colorRampPalette (c("pink", "blue", "green"))(100)
plot(p224r63_2011, col=cl)

#B1 = blu
#B2 = verde
#B3 = rosso
#B4 = infrarosso vicino
#B5 = infrarosso medio
#B6 = infrarosso termico
#B7 = infrarosso medio

#dev.off () will clean the current graph
dev.off()

plot(p224r63_2011$B1_sre)
#plot band1 with a colour

#per mettere due plot uno affianco all'altro (row per mettere le righe, col per le colonne)
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot le prime quattro bande di Landsat

par(mfrow=c(2,2))

plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow=c(2,2))

clb <-  colorRampPalette (c("dark blue", "blue", "light blue"))(100)
plot(p224r63_2011$B1_sre, col=clb)

clg <-  colorRampPalette (c("dark green", "green", "light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)

clr <-  colorRampPalette (c("dark red", "red", "pink"))(100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <-  colorRampPalette (c("red", "orange", "yellow"))(100)
plot(p224r63_2011$B4_sre, col=clnir)

#Visualizing data by RGB plotting

par(mfrow=c(2,2))

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#Save PDF
pdf("il_mio_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

#colori più aggressivi
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")

#par natural colours, false colours and false colours with hist stretching

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")

#multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd")

plot(p224r63_1988)

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#hist
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Hist")

#hist PDF
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Hist")
dev.off()
