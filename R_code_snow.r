#R_code_snow.r

setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

# install.packages("ncdf4")
library(ncdf4)
library(raster)

snowmay <- raster("CopernicusFile.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

plot(snowmay,col=cl)

# Slow manner to import the set
setwd("~/lab/snow/")
# setwd("/Users/utente/lab/snow/") #mac
# setwd("C:/lab/snow/") # windows

snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

par(mfrow=c(2,3))
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

################################

#Fast manner to import the set
rlistsnow <- list.files(pattern="snow20", full.names=T)

##save raster into list
##con lapply

list_rast <- lapply(rlistsnow, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

# prediction
# go to IOL and downloand prediction.r into the folder snow
# source("prediction.r")

