#R code to view biomass over the world and calculate changes in ecosystem functioning

#energy
#chemical cycling
#proxies

#rasterdiv() function is useful to calculate indices of diversity on numerical matrices based on information theory.
install.packages("rasterdiv")
#rasterVis() function comprehend methods for enhanced visualization and interaction with raster data
install.packages("rasterVis")
#import the libraries
library(rasterVis)
library(rasterdiv)
#the input dataset is the Copernicus Long-term (1999-2017) average Normalise Difference Vegetation Index (copNDVI)
data(copNDVI)
plot(copNDVI)

#reclassify is a function that (re)classifies groups of values to other values
#cbind is to remove some data from the library that is not useful for us
#we assign it to the vector copNDVI through <- symbol
copNDVI<- reclassify(copNDVI, cbind(253:255,NA), right=TRUE)

#important code for rappresentation of ecosystem services

#impressive function to impress your supervisor
levelplot(copNDVI)
#highlights the mean biomass over the last 20 years

#fact=10 (factor of 10) is aggregating 10 pixels in 1, so the new image has much visible boundaries beetween colours
#the number of pixel has to be select in relation to what we are trying to see, if it is possible to have less pixels with the same analysis results is better (the file will be smaller in size)
copNDVI10<- aggregate (copNDVI,fact=10)
levelplot(copNDVI10)

#let's try 100x100 pixels in one
copNDVI100<- aggregate (copNDVI,fact=100)
levelplot(copNDVI100)


##########################statistics: code for making plots from maps###########################
library(ggplot2)
library(RStoolbox)
 
#colorRampPalette contains functions that are useful for converting hand-designed `sequential' or `diverging' color schemes into continous color ramps eg for image and filled contour plots.
myPalette <- colorRampPalette(c('white','green','dark green'))
#scale_colour_gradientn is used to smooth colour gradient between n colours
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))

 

ggR(copNDVI, geom_raster = TRUE) + scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+ labs(x="Longitude",y="Latitude", fill="")+ theme(legend.position = "bottom") + NULL
#impressive function to impress your supervisor
#impressive function to impress your supervisor

##################################################################################

#working on images about the deforestation in the Amazon forest
setwd("/Users/alessandro/lab")  #mac
library(raster)
#uploading the two different images, brick() function to create a RasterBrick (multiple layers)
defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

#band1: NIR
#band2: red
#band3: green
#making the plot of the two images separately, selecting the bands, stretch to make a better passage between colours
plotRGB(defor1, r=1, g=2,b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#to see the two images one next to the other we use the par() function with multiframe by rows (1 line, 2 columns)
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#if you write defor1 on R you look at the names that correspond to the 3 bands
#names: defor1_.1,  defor1_.2,  defor1_.3

#band1: NIR    defor1_.1
#band2: red    defor1_.2
#dvi=difference vegetation index. 
dvi1 <- defor1$defor1_.1 - defor1$defor1_.2
 
 
 #same for defor2
 #names      : defor2_.1, defor2_.2, defor2_.3 
 #band1: NIR    defor2_.1
 #band2: red     defor2_.2
 
 dvi2 <- defor2$defor2_.1 - defor2$defor2_.2

#we create the palette with the colours that we think more useful to highlight our data
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
#to see the two images one next to the other we use the par() function with multiframe by rows (1 line, 2 columns) 
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi<- dvi1 - dvi2

dev.off() #to close what we opened before
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)
#hist() function computes a histogram of the given data values
hist(difdvi)
