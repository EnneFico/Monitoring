# R  code to view biomass over the world




install.packages("rasterdiv")
install.packages("rasterVis")

library(rasterVis)
library(rasterdiv)

data(copNDVI)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
levelplot(copNDVI)

# it's important the resolution!
copNDVI10 <- aggregate(copNDVI, fact=10)

#important code for rappresentation of ecosystem services

install.packages("ggplot2")
library(ggplot2)



myPalette <- colorRampPalette(c('white','green','dark green'))
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))



ggR(copNDVI, geom_raster = TRUE) +
scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+
labs(x="Longitude",y="Latitude", fill="")+
# theme(legend.position = "bottom") +
NULL
# +
# ggtitle("NDVI")
