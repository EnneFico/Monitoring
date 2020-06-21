########## librerie usate di prova
install.packages("rasterdiv")
install.packages("raster")
install.packages("RStoolbox")

install.packages("sp")
install.packages("sf")

install.packages("maptools")




##########################################################
install.packages("rgdal")
install.packages("gdalUtils")

#to read jp2
BandNIR <- readGDAL("T33TVG_20200103T095401_B08_10m.jp2")

#to convert extention of images
gdal_translate("T33TVG_20200103T095401_B08_10m.jp2", "BandNIR.jpg")
gdal_translate("T33TVG_20200103T095401_B08_10m.jp2", "BandNIR.tif")





####################################################
#cutoff image from single rasterLayer with shapefile
#input: rasterRalyer, Shapefile
#output: RasterLayer cutted on the Shapefile

#to import a RasterLayer
M_0301BN <- raster("T33TVG_20200103T095401_B08_10m.jp2")
plot(M_0301BN)

#to import a Shapefile
M_shp <- readOGR("C:/Users/nicof/MExam/Data/ShapeMajella/Parco Nazionale Majella.shp")
plot(M_shp)
#to create a Shapefile
shp <- shapefile("C:/Users/nicof/MExam/Data/ShapeMajella/Parco Nazionale Majella.shp")
plot(shp)


proj4string(M_0301BN)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(M_0301BN)) 

plot(M_0301BN)
plot(shp1, add=T)

BN_msk <- mask(crop(M_0301BN, extent(shp1)), mshp)  

plot(BN_msk)
plot(shp1, add=T)


#######################################################
#create a Raster unificato da una lista di RasterLayer

#input: List of RasterLayer
#output: file.grd

import0301$fun <- mean
rast.mosaic <- do.call(mosaic,import0301)
plot(rast.mosaic)
writeRaster(rast.mosaic,"Output_Raster_Name",format="raster",overwrite=TRUE)

###################################################
#create a raster and cut off image with shapefile
import0301$fun <- mean
rast.mosaic <- do.call(mosaic,import0301)
plot(rast.mosaic)
writeRaster(rast.mosaic,"Output_Raster_Name",format="raster",overwrite=TRUE)

proj4string(rast.mosaic)
proj4string(M_shp)

mshp <- spTransform(M_shp, proj4string(rast.mosaic)) 

allb_msk <- mask(crop(rast.mosaic, extent(mshp)), mshp)  

plot(allb_msk)

