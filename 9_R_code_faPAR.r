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

####################################################################################
######################################################################################


#how to look at chemical things by satellite images

setwd("/Users/alessandro/lab") #mac
#not needed to install packages because previously used, just open it with library() function
library(raster)
library(rasterVis)
library(rasterdiv)

#we also use copNDVI (copernicus NDVI) NDVI= works with layers of reflectance
#plants: high reflectance in NIR and low in RED
#no plants: lower NIR higher RED
#let's have a look to the Copernicus image by plotting it
plot(copNDVI)
#reclassify() function (re)classifies groups of values to other values
#cbind() function combines vector, matrix or data frame by columns
#we assign it to the vector copNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)
#levelplot makes the average of the values on the orizontal and on the vertical line of pixels and shows it as graph on the side of the graph
#faPAR is the Fraction of Absorbed Photosynthetically Active Radiation ( = fraction of the solar radiation absorbed by live leaves for the photosynthesis activity)
faPAR10 <- raster("faPAR10.tif")  #raster to import the data. 10 because used a factor of 10 to aggregate the pixels
levelplot(faPAR10)
#we have less values on the northern side rather than equator because now we are taking into account the photosynthetic activity

#save as pdf
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()

