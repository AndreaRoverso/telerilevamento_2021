#R_code_knitr.r
setwd("C:/lab/")  
library(knitr)
stitch("R_code_greenland.r.txt", template=syestem.file("misc", "knitr-template.Rnw", package="knitr"))
