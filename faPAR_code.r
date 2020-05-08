# faPAR code

library(raster)
library(rasterVis)
library(rasterdiv)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI)

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
