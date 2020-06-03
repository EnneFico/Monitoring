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
source("prediction.r")

plot(predicted.snow.2025.norm, col=cl)

#############################################################

# Day 2

setwd("/")
setwd("C:/Users/nicof/lab/snow")

#Fast manner to import the set
rlistsnow <- list.files(pattern="snow20", full.names=T)

##save raster into list
##con lapply

list_rast <- lapply(rlistsnow, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

prediction <- raster("predicted.2025.norm.tif")

writeRaster(prediction, "final.tif")

# save rasters into a stack
final.stack <- stack(snow.multitemp, prediction)

#plot everything
plot(final.stack, col=cl)

#make a pdf
pdf("my_final_exciting_graph.pdf")
plot(final.stack, col=cl)
dev.off()

#make a png
png("my_final_exciting_graph.png")
plot(final.stack, col=cl)
dev.off()


