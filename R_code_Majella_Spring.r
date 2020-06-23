
install.packages("rasterdiv")
install.packages("raster")
install.packages("RStoolbox")
install.packages("sp")

#to read shapefile
install.packages("rgdal")
install.packages("gdalUtils")

library(RStoolbox)
library(rasterdiv)
library(raster)
library(sp)
library(ggplot2)

#for shp
library(rgdal)
library(gdalUtils)



######################## 20m Resolution #########################
############## BLUE:  B02 (490 nm)
############## GREEN: B03 (560 nm)
############## RED:   B04 (665 nm)
############## VRE:   B05 (705 nm)
############## VRE:   B06 (749 nm)
############## VRE:   B07 (783 nm)
############## NIR:   B8A (865 nm)
############## SWIR:  B11 (1610 nm)     
############## SWIR:  B12 (2190 nm)

setwd("C:/Users/nicof/MExam/Data/20m")

#import Bands images in a RasterStack
rlist02 <- list.files(pattern = "_20200227" )
import02 <- lapply(rlist02,raster)
B02 <- resample(import02[[1]], import02[[4]])
B03 <- resample(import02[[2]], import02[[4]])
B04 <- resample(import02[[3]], import02[[4]])
s02.bands <- stack(B02, B03, B04, import02[[4]],import02[[5]],import02[[6]],import02[[7]],import02[[8]],import02[[9]])

#################################################################
#to read a shpfile 
M_shp <- readOGR("C:/Users/nicof/MExam/Data/ShapeMajella/Parco Nazionale Majella.shp")
plot(M_shp)

#cut out images from a RasterStack with shapefile
proj4string(s02.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s02.bands)) 

m02_msk <- mask(crop(s02.bands, extent(mshp)), mshp)

plot(m02_msk)

hist(m02_msk)

#####

rlist03 <- list.files(pattern = "_20200318" )
import03 <- lapply(rlist03,raster)
s03.bands <- stack(import03)

#cut off images from a RasterStack with shapefile
proj4string(s03.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s03.bands)) 

m03_msk <- mask(crop(s03.bands, extent(mshp)), mshp)

#####

rlist04a <- list.files(pattern = "_20200407" )
import04a <- lapply(rlist04a,raster)
s04a.bands <- stack(import04a)

#cut off images from a RasterStack with shapefile
proj4string(s04a.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04a.bands)) 

m04a_msk <- mask(crop(s04a.bands, extent(mshp)), mshp)

#####

#####
rlist04b <- list.files(pattern = "_20200425" )
import04b <- lapply(rlist04b,raster)
s04b.bands <- stack(import04b)

#cut off images from a RasterStack with shapefile
proj4string(s04b.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04b.bands)) 

m04b_msk <- mask(crop(s04b.bands, extent(mshp)), mshp)


####
rlist04c <- list.files(pattern = "_20200430" )
import04c <- lapply(rlist04c,raster)
s04c.bands <- stack(import04c)

#cut off images from a RasterStack with shapefile
proj4string(s04c.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04c.bands)) 

m04c_msk <- mask(crop(s04c.bands, extent(mshp)), mshp)


#####

rlist05 <- list.files(pattern = "_20200522" )
import05 <- lapply(rlist05,raster)
s05.bands <- stack(import05)

#cut off images from a RasterStack with shapefile
proj4string(s05.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s05.bands)) 

m05_msk <- mask(crop(s05.bands, extent(mshp)), mshp)

plot(m05_msk)

#########

# RGB true Colour
par(mfrow=c(2,3))
# adjust the parameters so the axes colors are white. Also turn off tick marks.
par(col.axis = "white", col.lab = "white", tck = 0)
# plot
plotRGB(m02_msk,3,2,1,scale= "20000", stretch = "lin", axes = TRUE, main = "27/02/2020")
# set bounding box to white as well
box(col = "white")

plotRGB(m03_msk,3,2,1,scale= "20000", stretch = "lin", axes =TRUE, main = "18/03/2020")
box(col = "white")
plotRGB(m04a_msk,3,2,1,scale= "20000", stretch = "lin", axes =TRUE, main = "07/04/2020")
box(col = "white")
plotRGB(m04b_msk,3,2,1,scale= "20000", stretch = "lin", axes =TRUE, main = "25/04/2020")
box(col = "white")
plotRGB(m04c_msk,3,2,1,scale= "20000", stretch = "lin", axes =TRUE, main = "30/04/2020")
box(col = "white")
plotRGB(m05_msk,3,2,1,scale= "20000", stretch = "lin", axes =TRUE, main = "22/05/2020")
box(col = "white")

# RGB false Colour
par(mfrow=c(2,3))
plotRGB(m02_msk,9,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "27/02/2020")
box(col = "white")
plotRGB(m03_msk,9,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "18/03/2020")
box(col = "white")
plotRGB(m04a_msk,9,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "07/04/2020")
box(col = "white")
plotRGB(m04b_msk,9,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "25/04/2020")
box(col = "white")
plotRGB(m04c_msk,9,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "30/04/2020")
box(col = "white")
plotRGB(m05_msk,9,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "22/05/2020")
box(col = "white")

# RGB Vegetation Analysis
par(mfrow=c(2,3))
plotRGB(m02_msk,7,9,3,scale= "20000", stretch = "lin", axes = TRUE, main = "27/02/2020")
box(col = "white")
plotRGB(m03_msk,7,9,3,scale= "20000", stretch = "lin", axes = TRUE, main = "18/03/2020")
box(col = "white")
plotRGB(m04a_msk,7,9,3,scale= "20000", stretch = "lin", axes = TRUE, main = "07/04/2020")
box(col = "white")
plotRGB(m04b_msk,7,9,3,scale= "20000", stretch = "lin", axes = TRUE, main = "25/04/2020")
box(col = "white")
plotRGB(m04c_msk,7,9,3,scale= "20000", stretch = "lin", axes = TRUE, main = "30/04/2020")
box(col = "white")
plotRGB(m05_msk,7,9,3,scale= "20000", stretch = "lin", axes = TRUE, main = "22/05/2020")
box(col = "white")

#NDVI
ndvi02 <- (m02_msk$T33TVG_20200227T095029_B8A - m02_msk$T33TVG_20200227T095029_B04)
/(m02_msk$T33TVG_20200227T095029_B8A + m02_msk$T33TVG_20200227T095029_B04)
ndvi03 <- (m03_msk$T33TVG_20200318T095029_B8A_20m - m03_msk$T33TVG_20200318T095029_B04_20m)
/(m03_msk$T33TVG_20200318T095029_B8A_20m + m03_msk$T33TVG_20200318T095029_B04_20m)
ndvi04a <-(m04a_msk$T33TVG_20200407T095029_B8A_20m - m04a_msk$T33TVG_20200407T095029_B04_20m)
/(m04a_msk$T33TVG_20200407T095029_B8A_20m + m04a_msk$T33TVG_20200407T095029_B04_20m)
ndvi04b <- (m04b_msk$T33TVG_20200425T100031_B8A_20m - m04b_msk$T33TVG_20200425T100031_B04_20m)
/(m04b_msk$T33TVG_20200425T100031_B8A_20m + m04b_msk$T33TVG_20200425T100031_B04_20m)
ndvi04c <- (m04c_msk$T33TVG_20200430T100019_B8A_20m - m04c_msk$T33TVG_20200430T100019_B04_20m)
/(m04c_msk$T33TVG_20200430T100019_B8A_20m + m04c_msk$T33TVG_20200430T100019_B04_20m)
ndvi05 <- (m05_msk$T33TVG_20200522T095041_B8A_20m - m05_msk$T33TVG_20200522T095041_B04_20m)
/(m05_msk$T33TVG_20200522T095041_B8A_20m + m05_msk$T33TVG_20200522T095041_B04_20m)

dev.off()

#plot NDVI
clNDVI = colorRampPalette(c("blue", "white", "red"))(256)
par(mfrow=c(2,3))
plot(ndvi02, col = clNDVI, main = "27/02/2020")
plot(ndvi03, col = clNDVI, main = "18/03/2020")
plot(ndvi04a, col = clNDVI, main = "07/04/2020")
plot(ndvi04b, col = clNDVI, main = "25/04/2020")
plot(ndvi04c, col = clNDVI, main = "25/04/2020")
plot(ndvi05, col = clNDVI, main = "30/04/2020")

################   SNOW  ################

#RGB snow cover 1
# adjust the parameters so the axes colors are white. Also turn off tick marks.
par(col.axis = "white", col.lab = "white", tck = 0)
par(mfrow=c(2,3))
plotRGB(m02_msk,3,7,8,scale= "20000", stretch = "lin", axes = TRUE, main = "27/02/2020")
box(col = "white")
plotRGB(m03_msk,3,7,8,scale= "20000", stretch = "lin", axes = TRUE, main = "18/03/2020")
box(col = "white")
plotRGB(m04a_msk,3,7,8,scale= "20000", stretch = "lin", axes =TRUE, main = "07/04/2020")
box(col = "white")
plotRGB(m04b_msk,3,7,8,scale= "20000", stretch = "lin", axes =TRUE, main = "25/04/2020")
box(col = "white")
plotRGB(m04c_msk,3,7,8,scale= "20000", stretch = "lin", axes =TRUE, main = "30/04/2020")
box(col = "white")
plotRGB(m05_msk,3,7,8,scale= "20000", stretch = "lin", axes =TRUE, main = "22/05/2020")
box(col = "white")

#RGB false colours: snow cover 2 + vegetation
par(mfrow=c(2,3))
plotRGB(m02_msk,8,9,1,scale= "20000", stretch = "lin", axes = TRUE, main = "27/02/2020")
box(col = "white")
plotRGB(m03_msk,8,9,1,scale= "20000", stretch = "lin", axes = TRUE, main = "18/03/2020")
box(col = "white")
plotRGB(m04a_msk,8,9,1,scale= "20000", stretch = "lin", axes =TRUE, main = "07/04/2020")
box(col = "white")
plotRGB(m04b_msk,8,9,1,scale= "20000", stretch = "lin", axes =TRUE, main = "25/04/2020")
box(col = "white")
plotRGB(m04c_msk,8,9,1,scale= "20000", stretch = "lin", axes =TRUE, main = "30/04/2020")
box(col = "white")
plotRGB(m05_msk,8,9,1,scale= "20000", stretch = "lin", axes =TRUE, main = "22/05/2020")
box(col = "white")


#NDSI
ndsi02 <- (m02_msk$T33TVG_20200227T095029_B03 - m02_msk$T33TVG_20200227T095029_B11)
/(m02_msk$T33TVG_20200227T095029_B03 + m02_msk$T33TVG_20200227T095029_B11)
ndsi03 <- (m03_msk$T33TVG_20200318T095029_B03_20m - m03_msk$T33TVG_20200318T095029_B11_20m)
/(m03_msk$T33TVG_20200318T095029_B03_20m + m03_msk$T33TVG_20200318T095029_B11_20m)           
ndsi04a <- (m04a_msk$T33TVG_20200407T095029_B03_20m - m04a_msk$T33TVG_20200407T095029_B11_20m)
/(m04a_msk$T33TVG_20200407T095029_B03_20m + m04a_msk$T33TVG_20200407T095029_B11_20m)           
ndsi04b <- (m04b_msk$T33TVG_20200425T100031_B03_20m - m04b_msk$T33TVG_20200425T100031_B11_20m)
/(m04b_msk$T33TVG_20200425T100031_B03_20m + m04b_msk$T33TVG_20200425T100031_B11_20m)
ndsi04c <- (m04c_msk$T33TVG_20200430T100019_B03_20m - m04c_msk$T33TVG_20200430T100019_B11_20m)
/(m04c_msk$T33TVG_20200430T100019_B03_20m + m04c_msk$T33TVG_20200430T100019_B11_20m)           
ndsi05 <- (m05_msk$T33TVG_20200522T095041_B03_20m - m05_msk$T33TVG_20200522T095041_B11_20m)
/(m05_msk$T33TVG_20200522T095041_B03_20m + m05_msk$T33TVG_20200522T095041_B11_20m)




clNDSI = colorRampPalette(c("green", "blue", "white"))(256)
par(mfrow=c(2,3))
plot(ndsi02, col = clNDSI, main = "27/02/2020")
plot(ndsi03, col = clNDSI, main = "18/03/2020")
plot(ndsi04a, col = clNDSI, main = "07/04/2020")
plot(ndsi04b, col = clNDSI, main = "25/04/2020")
plot(ndsi04c, col = clNDSI, main = "30/04/2020")
plot(ndsi05, col = clNDSI, main = "22/05/2020")
