
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


#######################################
#try to stack all band together -input: file.jp2 -output: RasterStack

setwd("C:/Users/nicof/MExam/Data/03012020")

rlist0301 <- list.files(pattern = "T33TVG" )
import0301 <- lapply(rlist0301,raster)
m0301.bands <- stack(import0301)

#cut off images from a RasterStack with shapefile
proj4string(m0301.bands)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(m0301.bands)) 

m0301_msk <- mask(crop(m0301.bands, extent(mshp)), mshp)  

plot(m0301_msk)


#plot single bands
#B1:blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
#B2: with but with green (B2) 
clg <- colorRampPalette(c('dark green','green','light green'))(100)
#B3: with but with red (B3) 
clr <- colorRampPalette(c('dark red','red','salmon'))(100) 
#B4: with but with NIR (B4) 
cln <- colorRampPalette(c('red','orange','yellow'))(100) 

#0301 single bands
plot(m0301_msk$T33TVG_20200103T095401_B02_10m, col = clb)
#plot(mshp, add=T)

plot(m0301_msk$T33TVG_20200103T095401_B03_10m, col = clg)
#plot(mshp, add=T)

plot(m0301_msk$T33TVG_20200103T095401_B04_10m, col = clr)
#plot(mshp, add=T)

plot(m0301_msk$T33TVG_20200103T095401_B08_10m, col = cln)
#plot(mshp, add=T)

#0301 RGB true and false colours
plotRGB(m0301_msk,3,2,1,scale= "65535", stretch = "lin")
#plot(mshp, add=T) #border line

plotRGB(m0301_msk,4,3,2,scale= "65535", stretch = "lin")
#plot(mshp, add=T) #border line

###############################################
#DVI
dvi0301 <- m0301_msk$T33TVG_20200103T095401_B02_10m - m0301_msk$T33TVG_20200103T095401_B03_10m

plot(dvi0301)

###############################################
