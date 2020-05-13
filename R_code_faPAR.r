# faPAR code

library(raster)
library(rasterVis)
library(rasterdiv)

#eliminating water from the raster
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

#plotting sum of NDVI in latitude and longitude
levelplot(copNDVI)

#set workin directory
setwd("~/lab/")
faPAR10 <- raster("~/lab/faPAR10.tif")

levelplot(faPAR10)

library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10,1000)

copNDVIp <- extract(copNDVI,pts)
faPAR10p <- extract(faPAR10,pts)

plot(copNDVIp,faPAR10p)

model1 <- lm(faPAR10p~copNDVIp)

plot(copNDVIp,faPAR10p,col="green")
abline(model1,col="red")

##########Day 2


load("faPAR.RData")

#the original faPAR from Copernicus is 2 Gb
#let's see how much space is needed for an 8-bit set

