
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



setwd("C:/Users/nicof/MExam/Data/)
#######################################
#try to stack all band together -input: file.jp2 -output: RasterStack



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

mshp <- spTransform(M_shp, proj4string(05.bands)) 

m05_msk <- mask(crop(s05.bands, extent(mshp)), mshp)

plot(m05_msk)

#########################################à
#plot single bands
#B1:blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
#B2: with but with green (B2) 
clg <- colorRampPalette(c('dark green','green','light green'))(100)
#B3: with but with red (B3) 
clr <- colorRampPalette(c('dark red','red','salmon'))(100) 
#B4: with but with NIR (B4) 
cln <- colorRampPalette(c('red','orange','yellow'))(100) 

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
par(mfrow=c(3,3))
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
plotRGB(m03_msk,4,3,2,scale= "65535", stretch = "hist"

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
#DVI
dvi01 <- m01_msk$T33TVG_20200103T095401_B02_10m - m01_msk$T33TVG_20200103T095401_B03_10m

plot(dvi01)

###############################################
