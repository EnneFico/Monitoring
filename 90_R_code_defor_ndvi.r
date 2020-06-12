############# dvi on remote sensing data and deforestation

# presentazione su biomass
https://cran.r-project.org/web/packages/rasterdiv/vignettes/vignettes_rasterdiv.html

# biomass
install.packages("rasterdiv")
# plot dell'ndvi

library(rasterdiv)

defor1 <- brick("~/Documents/lectures_and_seminars/images/defor1_.jpg") 
defor2 <- brick("~/Documents/lectures_and_seminars/images/defor2_.jpg") 

plotRGB(defor1,1,2,3)
plotRGB(defor2,1,2,3)

# kernel density invece di histograms
# classify in three classes and calculate the amount of lost dvi classes

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2
dvi2 <- defor2$defor2_.1 - defor2$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

par(mfrow=c(2,1))
plot(dvi1,col=cl)
plot(dvi2,col=cl)

dvidif <- dvi1-dvi2 

par(mfrow=c(2,2))
plot(dvi1,col=cl)
plot(dvi2,col=cl)

cld <- colorRampPalette(c('blue','white','red'))(100) 

plot(dvidif, col=cld)
hist(dvidif)
q()
