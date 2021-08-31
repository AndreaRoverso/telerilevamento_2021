# R_code_spactral_signatures.r

library(raster)
library(rgdal)
library(ggplot2)

setwd("C:/lab/")  

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")
 
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# define the columns of the dataset:
band <- c(1,2,3)
forest <- c(206, 6, 19)
water <- c(40, 99, 139)

# create the dataframe
spectrals <- data.frame(band, forest, water)

# plot the spectral signatures
ggplot (spectrals, aes(x=band)) + 
  geom_line(aes(y=forest), color="green") +
  geom_line(aes(y=water), color="blue") +
  labs(x="band", y="reflectance")


##################### Multitemporal

defor1 <- brick("defor1.jpg")

plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

#spectral signatures defor1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# Output
# 1 132.5 226.5 179347       86       35       32
#      x     y   cell defor1.1 defor1.2 defor1.3
# 1 344.5 162.5 225255      197        7       19
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 503.5 344.5 95466      193       37       51
#      x    y   cell defor1.1 defor1.2 defor1.3
# 1 587.5 42.5 311178      209      151      149
#     x    y   cell defor1.1 defor1.2 defor1.3

# time 2
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

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
band <- c(197,163,151)
time1 <- c(149,157,133)
time1p2 <- c(197,132,128)
time2 <- c(169,166,149)
time2p2 <- c(150,137,129)

spectralst <- data.frame(band, time1, time2, time1p2, time2p2)


# plot the sepctral signatures
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red", linetype="dotted") +
 geom_line(aes(y=time1p2), color="red", linetype="dotted") +
 geom_line(aes(y=time2), linetype="dotted") +
 geom_line(aes(y=time2p2), linetype="dotted") +
 labs(x="band",y="reflectance")

# image from Earth Observatory

eo <- brick("ida_vir_2021242_front.jpg")
plotRGB(eo, 1,2,3, stretch="hist")
click(eo, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# output
# 1 142.5 43.5 314063                       8                       8                       8
#      x     y   cell ida_vir_2021242_front.1 ida_vir_2021242_front.2 ida_vir_2021242_front.3
# 1 461.5 254.5 162462                     145                     145                     145
#     x     y   cell ida_vir_2021242_front.1 ida_vir_2021242_front.2 ida_vir_2021242_front.3
# 1 113.5 326.5 110274                      34                      34                      34
#      x     y   cell ida_vir_2021242_front.1 ida_vir_2021242_front.2 ida_vir_2021242_front.3


# define the columns of the dataset:
band <- c(1,2,3)
stratum1 <- c(8,8,8)
stratum2 <- c(145,145,145)
stratum3 <- c(34,34,34)

spectralsg <- data.frame(band, stratum1, stratum2, stratum3)

# plot the sepctral signatures
ggplot(spectralsg, aes(x=band)) +
 geom_line(aes(y=stratum1), color="yellow") +
 geom_line(aes(y=stratum2), color="green") +
 geom_line(aes(y=stratum3), color="blue") +
 labs(x="band",y="reflectance")
