
install.packages("rgdal")
install.packages("gdalUtils")

install.packages("rasterdiv")
install.packages("raster")
install.packages("RStoolbox")

install.packages("sp")
install.packages("sf")

install.packages("maptools")


library(RStoolbox)
library(rasterdiv)
library(rgdal)
library(raster)
library(sp)
library(gdalUtils)
library(ggplot2)


setwd("C:/Users/nicof/MExam/Data")

#to read jp2
#BandNIR <- readGDAL("T33TVG_20200103T095401_B08_10m.jp2")

#to convert extention of images
#gdal_translate("T33TVG_20200103T095401_B08_10m.jp2", "BandNIR.jpg")
#gdal_translate("T33TVG_20200103T095401_B08_10m.jp2", "BandNIR.tif")

#BandNIR_jpg <- raster("BandNIR.jpg")
#BandNIR_tif <- raster("BandNIR.tif")

#palette NIR
#cln <- colorRampPalette(c('red','orange','yellow'))(100)

####################################

# b1 blue
# b2 green
# b3 red
# b4 NIR
# b5 SWIR
# b6 thermal infrared
# b7 SWIR
# b8 panchromatic

##################################

#to read a shpfile 
M_shp <- readOGR("C:/Users/nicof/MExam/Data/ShapeMajella/Parco Nazionale Majella.shp")
plot(M_shp)
#to create a shpfile
shp <- shapefile("C:/Users/nicof/MExam/Data/ShapeMajella/Parco Nazionale Majella.shp")
plot(shp)



#plot single bands
#B1:blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
#B2: with but with green (B2) 
clg <- colorRampPalette(c('dark green','green','light green'))(100)
#B3: with but with red (B3) 
clr <- colorRampPalette(c('dark red','red','salmon'))(100) 
#B4: with but with NIR (B4) 
cln <- colorRampPalette(c('red','orange','yellow'))(100)


#######################################
#try to stack all band together -input: file.jp2 -output: RasterStack


######################## 10m Resolution #########################
############## BLUE:  B02 (490 nm)
############## GREEN: B03 (560 nm)
############## RED:   B04 (665 nm)
############## NIR:   B08 (842 nm)

setwd("C:/Users/nicof/MExam/Data/10m")
#################################################################
rlist01 <- list.files(pattern = "Jan" )
import01 <- lapply(rlist01,raster)
s01.bands <- stack(import01)

#cut off images from a RasterStack with shapefile
proj4string(s01.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s01.bands)) 

m01_msk <- mask(crop(s01.bands, extent(mshp)), mshp)  

plot(m01_msk)

####

rlist02 <- list.files(pattern = "Feb" )
import02 <- lapply(rlist02,raster)
s02.bands <- stack(import02)

#cut off images from a RasterStack with shapefile
proj4string(s02.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s02.bands)) 

m02_msk <- mask(crop(s02.bands, extent(mshp)), mshp)

plot(m02_msk)

#####

rlist03 <- list.files(pattern = "Mar" )
import03 <- lapply(rlist03,raster)
s03.bands <- stack(import03)

#cut off images from a RasterStack with shapefile
proj4string(s03.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s03.bands)) 

m03_msk <- mask(crop(s03.bands, extent(mshp)), mshp)

plot(m03_msk)

#####

rlist04a <- list.files(pattern = "Apra" )
import04a <- lapply(rlist04a,raster)
s04a.bands <- stack(import04a)

#cut off images from a RasterStack with shapefile
proj4string(s04a.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04a.bands)) 

m04a_msk <- mask(crop(s04a.bands, extent(mshp)), mshp)

plot(m04a_msk)

#####
rlist04b <- list.files(pattern = "Aprb" )
import04b <- lapply(rlist04b,raster)
s04b.bands <- stack(import04b)

#cut off images from a RasterStack with shapefile
proj4string(s04b.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04b.bands)) 

m04b_msk <- mask(crop(s04b.bands, extent(mshp)), mshp)

plot(m04b_msk)

#####
rlist05 <- list.files(pattern = "May" )
import05 <- lapply(rlist05,raster)
s05.bands <- stack(import05)

#cut off images from a RasterStack with shapefile
proj4string(s05.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s05.bands)) 

m05_msk <- mask(crop(s05.bands, extent(mshp)), mshp)

plot(m05_msk)

#########################################

 

#if i want border line #plot(mshp, add=T) 
#01 single bands
par(mfrow=c(2,2))
plot(m01_msk$Jan_B02_10m, col = clb)
plot(m01_msk$Jan_B03_10m, col = clg)
plot(m01_msk$Jan_B04_10m, col = clr)
plot(m01_msk$Jan_B08_10m, col = cln)

#02 single bands
par(mfrow=c(2,2))
plot(m02_msk$Feb_B02_10m, col = clb)
plot(m02_msk$Feb_B03_10m, col = clg)
plot(m02_msk$Feb_B04_10m, col = clr)
plot(m02_msk$Feb_B08_10m, col = cln)

#03 single bands
par(mfrow=c(2,2))
plot(m03_msk$Mar_B02_10m, col = clb)
plot(m03_msk$Mar_B03_10m, col = clg)
plot(m03_msk$Mar_B04_10m, col = clr)
plot(m03_msk$Mar_B08_10m, col = cln)

#04a single bands
par(mfrow=c(2,2))
plot(m04a_msk$Apra_B02_10m, col = clb)
plot(m04a_msk$Apra_B03_10m, col = clg)
plot(m04a_msk$Apra_B04_10m, col = clr)
plot(m04a_msk$Apra_B08_10m, col = cln)

#04b single bands
par(mfrow=c(2,2))
plot(m04b_msk$Aprb_B02_10m, col = clb)
plot(m04b_msk$Aprb_B03_10m, col = clg)
plot(m04b_msk$Aprb_B04_10m, col = clr)
plot(m04b_msk$Aprb_B08_10m, col = cln)

#05 single bands
par(mfrow=c(2,2))
plot(m05_msk$May_B02_10m, col = clb)
plot(m05_msk$May_B03_10m, col = clg)
plot(m05_msk$May_B04_10m, col = clr)
plot(m05_msk$May_B08_10m, col = cln)

RGB true and false colours
#RGB
par(mfrow=c(2,3))
plotRGB(m01_msk,3,2,1,scale= "65535", stretch = "lin")
plotRGB(m01_msk,4,3,2,scale= "65535", stretch = "lin")
#false colour to see evapotraspiration, humidity and clouds
plotRGB(m01_msk,4,3,2,scale= "65535", stretch = "hist")

plotRGB(m02_msk,3,2,1,scale= "65535", stretch = "lin")
plotRGB(m02_msk,4,3,2,scale= "65535", stretch = "lin")
#false colour to see evapotraspiration, humidity and clouds
plotRGB(m02_msk,4,3,2,scale= "65535", stretch = "hist")

plotRGB(m03_msk,3,2,1,scale= "65535", stretch = "lin")
plotRGB(m03_msk,4,3,2,scale= "65535", stretch = "lin")
#false colour to see evapotraspiration, humidity and clouds
plotRGB(m03_msk,4,3,2,scale= "65535", stretch = "hist")

plotRGB(m04a_msk,3,2,1,scale= "65535", stretch = "lin")
plotRGB(m04a_msk,4,3,2,scale= "65535", stretch = "lin")
#false colour to see evapotraspiration, humidity and clouds
plotRGB(m04a_msk,4,3,2,scale= "65535", stretch = "hist")

plotRGB(m04b_msk,3,2,1,scale= "65535", stretch = "lin")
plotRGB(m04b_msk,4,3,2,scale= "65535", stretch = "lin")
#false colour to see evapotraspiration, humidity and clouds
plotRGB(m04b_msk,4,3,2,scale= "65535", stretch = "hist")

plotRGB(m05_msk,3,2,1,scale= "65535", stretch = "lin")
plotRGB(m05_msk,4,3,2,scale= "65535", stretch = "lin")
#false colour to see evapotraspiration, humidity and clouds
plotRGB(m05_msk,4,3,2,scale= "65535", stretch = "hist")
###############################################

#NDVI

ndvi01 <- (m01_msk$Jan_B08_10m - m01_msk$Jan_B04_10m)/(m01_msk$Jan_B08_10m + m01_msk$Jan_B04_10m)
ndvi02 <- (m02_msk$Feb_B08_10m - m02_msk$Feb_B04_10m)/(m02_msk$Feb_B08_10m + m02_msk$Feb_B04_10m)
ndvi03 <- (m03_msk$Mar_B08_10m - m03_msk$Mar_B04_10m)/(m03_msk$Mar_B08_10m + m03_msk$Mar_B04_10m)
ndvi04a <- (m04a_msk$Apra_B08_10m - m04a_msk$Apra_B04_10m)/(m04a_msk$Apra_B08_10m + m04a_msk$Apra_B04_10m)
ndvi04b <- (m04b_msk$Aprb_B08_10m - m04b_msk$Aprb_B04_10m)/(m04b_msk$Aprb_B08_10m + m04b_msk$Aprb_B04_10m)
ndvi05 <- (m05_msk$May_B08_10m - m05_msk$May_B04_10m)/(m05_msk$May_B08_10m + m05_msk$May_B04_10m)

#plot NDVI
clNIR = colorRampPalette(c("blue", "white", "red"))(256)
par(mfrow=c(2,3))
plot(ndvi01, col = clNIR)
plot(ndvi02, col = clNIR)
plot(ndvi03, col = clNIR)
plot(ndvi04a, col = clNIR)
plot(ndvi04b, col = clNIR)
plot(ndvi05, col = clNIR)


###############################################


######################## 20m Resolution #########################
############## BLUE:  B02 (490 nm)
############## GREEN: B03 (560 nm)
############## RED:   B04 (665 nm)
############## VRE:   B05 (705 nm)
############## VRE:   B06 (749 nm)
############## VRE:   B07 (783 nm)
############## NIR:   B08 (842 nm)
############## SWIR:  B11 (1610 nm)     
############## SWIR:  B12 (2190 nm)
setwd("C:/Users/nicof/MExam/Data/20m")
#################################################################

rlist01 <- list.files(pattern = "_20200103" )
import01 <- lapply(rlist01,raster)
s01.bands <- stack(import01)

#cut off images from a RasterStack with shapefile
proj4string(s01.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s01.bands)) 

m01_msk <- mask(crop(s01.bands, extent(mshp)), mshp)  

plot(m01_msk)

####

rlist02 <- list.files(pattern = "_20200227" )
import02 <- lapply(rlist02,raster)
B02 <- resample(import02[[1]], import02[[4]]) #different resolution needs resample to use stack()
B03 <- resample(import02[[2]], import02[[4]])
B04 <- resample(import02[[3]], import02[[4]])
s02.bands <- stack(B02, B03, B04, import02[[4]],import02[[5]],import02[[6]],import02[[7]],import02[[8]],import02[[9]])

#cut off images from a RasterStack with shapefile
proj4string(s02.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s02.bands)) 

m02_msk <- mask(crop(s02.bands, extent(mshp)), mshp)

plot(m02_msk)

#####

rlist03 <- list.files(pattern = "_20200318" )
import03 <- lapply(rlist03,raster)
s03.bands <- stack(import03)

#cut off images from a RasterStack with shapefile
proj4string(s03.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s03.bands)) 

m03_msk <- mask(crop(s03.bands, extent(mshp)), mshp)

plot(m03_msk)

#####

rlist04a <- list.files(pattern = "_20200407" )
import04a <- lapply(rlist04a,raster)
s04a.bands <- stack(import04a)

#cut off images from a RasterStack with shapefile
proj4string(s04a.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04a.bands)) 

m04a_msk <- mask(crop(s04a.bands, extent(mshp)), mshp)

plot(m04a_msk)

#####
rlist04b <- list.files(pattern = "_20200417" )
import04b <- lapply(rlist04b,raster)
s04b.bands <- stack(import04b)

#cut off images from a RasterStack with shapefile
proj4string(s04b.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04b.bands)) 

m04b_msk <- mask(crop(s04b.bands, extent(mshp)), mshp)

plot(m04b_msk)

#####

rlist04c <- list.files(pattern = "_20200425" )
import04c <- lapply(rlist04c,raster)
s04c.bands <- stack(import04c)

#cut off images from a RasterStack with shapefile
proj4string(s04c.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04c.bands)) 

m04c_msk <- mask(crop(s04c.bands, extent(mshp)), mshp)


#####
rlist04d <- list.files(pattern = "_20200430" )
import04d <- lapply(rlist04d,raster)
s04d.bands <- stack(import04d)

#cut off images from a RasterStack with shapefile
proj4string(s04d.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s04d.bands)) 

m04d_msk <- mask(crop(s04d.bands, extent(mshp)), mshp)


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


#######
rlist06 <- list.files(pattern = "_20200606" )
import06 <- lapply(rlist06,raster)
s06.bands <- stack(import06)

#cut off images from a RasterStack with shapefile
proj4string(s06.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(s06.bands)) 

m06_msk <- mask(crop(s06.bands, extent(mshp)), mshp)

plot(m06_msk)

################################################

# RGB true Colour
par(mfrow=c(2,3))
plotRGB(m01_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m02_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m03_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m04a_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m04b_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m04c_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m04d_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m05_msk,3,2,1,scale= "20000", stretch = "lin")
plotRGB(m06_msk,3,2,1,scale= "20000", stretch = "lin")

# RGB false Colour
par(mfrow=c(2,3))
plotRGB(m01_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m02_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m03_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m04a_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m04b_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m04c_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m04d_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m05_msk,9,3,2,scale= "20000", stretch = "lin")
plotRGB(m06_msk,9,3,2,scale= "20000", stretch = "lin")

# RGB Vegetation Analysis
par(mfrow=c(2,3))
plotRGB(m01_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m02_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m03_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m04a_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m04b_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m04c_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m04d_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m05_msk,7,9,3,scale= "20000", stretch = "lin")
plotRGB(m06_msk,7,9,3,scale= "20000", stretch = "lin")

####################
#NDVI
ndvi01 <- (m01_msk$T33TVG_20200103T095401_B8A_20m - m01_msk$T33TVG_20200103T095401_B04_20m)/(m01_msk$T33TVG_20200103T095401_B8A_20m + m01_msk$T33TVG_20200103T095401_B04_20m)
ndvi02 <- (m02_msk$T33TVG_20200227T095029_B8A - m02_msk$T33TVG_20200227T095029_B04)/(m02_msk$T33TVG_20200227T095029_B8A + m02_msk$T33TVG_20200227T095029_B04)
ndvi03 <- (m03_msk$T33TVG_20200318T095029_B8A_20m - m03_msk$T33TVG_20200318T095029_B04_20m)/(m03_msk$T33TVG_20200318T095029_B8A_20m + m03_msk$T33TVG_20200318T095029_B04_20m)
ndvi04a <-(m04a_msk$T33TVG_20200407T095029_B8A_20m - m04a_msk$T33TVG_20200407T095029_B04_20m)/(m04a_msk$T33TVG_20200407T095029_B8A_20m + m04a_msk$T33TVG_20200407T095029_B04_20m)
ndvi04b <-(m04b_msk$T33TVG_20200417T095029_B8A_20m - m04b_msk$T33TVG_20200417T095029_B04_20m)/(m04b_msk$T33TVG_20200417T095029_B8A_20m + m04b_msk$T33TVG_20200417T095029_B04_20m)
ndvi04c <- (m04c_msk$T33TVG_20200425T100031_B8A_20m - m04c_msk$T33TVG_20200425T100031_B04_20m)/(m04c_msk$T33TVG_20200425T100031_B8A_20m + m04c_msk$T33TVG_20200425T100031_B04_20m)
ndvi04d <- (m04d_msk$T33TVG_20200430T100019_B8A_20m - m04d_msk$T33TVG_20200430T100019_B04_20m)/(m04d_msk$T33TVG_20200430T100019_B8A_20m + m04d_msk$T33TVG_20200430T100019_B04_20m)
ndvi05 <- (m05_msk$T33TVG_20200522T095041_B8A_20m - m05_msk$T33TVG_20200522T095041_B04_20m)/(m05_msk$T33TVG_20200522T095041_B8A_20m + m05_msk$T33TVG_20200522T095041_B04_20m)
ndvi06 <- (m06_msk$T33TVG_20200606T095029_B8A_20m - m06_msk$T33TVG_20200606T095029_B04_20m)/(m06_msk$T33TVG_20200606T095029_B8A_20m + m06_msk$T33TVG_20200606T095029_B04_20m)

#plot NDVI
clNDVI = colorRampPalette(c("blue", "white", "red"))(256)
par(mfrow=c(3,3))
plot(ndvi01, col = clNDVI)
plot(ndvi02, col = clNDVI)
plot(ndvi03, col = clNDVI)
plot(ndvi04a, col = clNDVI)
plot(ndvi04b, col = clNDVI)
plot(ndvi04c, col = clNDVI)
plot(ndvi04d, col = clNDVI)
plot(ndvi05, col = clNDVI)
plot(ndvi06, col = clNDVI)
##############

#NDSI
ndsi01 <- (m01_msk$T33TVG_20200103T095401_B03_20m - m01_msk$T33TVG_20200103T095401_B11_20m)/(m01_msk$T33TVG_20200103T095401_B03_20m + m01_msk$T33TVG_20200103T095401_B11_20m)
ndsi02 <- (m02_msk$T33TVG_20200227T095029_B03 - m02_msk$T33TVG_20200227T095029_B11)/(m02_msk$T33TVG_20200227T095029_B03 + m02_msk$T33TVG_20200227T095029_B11)
ndsi03 <- (m03_msk$T33TVG_20200318T095029_B03_20m - m03_msk$T33TVG_20200318T095029_B11_20m)/(m03_msk$T33TVG_20200318T095029_B03_20m + m03_msk$T33TVG_20200318T095029_B11_20m)           
ndsi04a <- (m04a_msk$T33TVG_20200407T095029_B03_20m - m04a_msk$T33TVG_20200407T095029_B11_20m)/(m04a_msk$T33TVG_20200407T095029_B03_20m + m04a_msk$T33TVG_20200407T095029_B11_20m)           
ndsi04b <- (m04b_msk$T33TVG_20200417T095029_B03_20m - m04b_msk$T33TVG_20200417T095029_B11_20m)/(m04b_msk$T33TVG_20200417T095029_B03_20m + m04b_msk$T33TVG_20200417T095029_B11_20m)
ndsi04c <- (m04c_msk$T33TVG_20200425T100031_B03_20m - m04c_msk$T33TVG_20200425T100031_B11_20m)/(m04c_msk$T33TVG_20200425T100031_B03_20m + m04c_msk$T33TVG_20200425T100031_B11_20m)
ndsi04d <- (m04d_msk$T33TVG_20200430T100019_B03_20m - m04d_msk$T33TVG_20200430T100019_B11_20m)/(m04d_msk$T33TVG_20200430T100019_B03_20m + m04d_msk$T33TVG_20200430T100019_B11_20m)           
ndsi05 <- (m05_msk$T33TVG_20200522T095041_B03_20m - m05_msk$T33TVG_20200522T095041_B11_20m)/(m05_msk$T33TVG_20200522T095041_B03_20m + m05_msk$T33TVG_20200522T095041_B11_20m)
ndsi06 <- (m06_msk$T33TVG_20200606T095029_B03_20m - m06_msk$T33TVG_20200606T095029_B11_20m)/(m06_msk$T33TVG_20200606T095029_B03_20m + m06_msk$T33TVG_20200606T095029_B11_20m)



clNDSI = colorRampPalette(c("green", "blue", "white"))(256)
par(mfrow=c(3,3))
plot(ndsi01, col = clNDSI )
plot(ndsi02, col = clNDSI )
plot(ndsi03, col = clNDSI )
plot(ndsi04a, col = clNDSI )
plot(ndsi04b, col = clNDSI )
plot(ndsi04c, col = clNDSI )
plot(ndsi04d, col = clNDSI )
plot(ndsi05, col = clNDSI )
plot(ndsi06, col = clNDSI )





