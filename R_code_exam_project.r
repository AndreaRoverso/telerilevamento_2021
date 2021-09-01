# R_code_exam_project.r

# Shinking Aral Sea from 2000 to 2018 (2000-2006-2012-2018)
# Images from: https://earthobservatory.nasa.gov/world-of-change/AralSea

# library
library(raster)
library(rasterVis)
library(RStoolbox) # for the indices
library(ggplot2) # for the functional ggplot
library(gridExtra)
library(rgdal) # for spectral signatures

setwd("C:/lab/exam") #Windows

# Importo i file 
# creo una lista di file con list.files per la funzione lapply 
arallist <- list.files(pattern="aralsea") 
# info sulla lista di files
arallist
# applico con lapply una funzione raster alla lista dei file
import <- lapply(arallist,raster)
