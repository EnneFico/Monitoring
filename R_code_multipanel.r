install.packages("sp")
install.packages("GGally") # is used for the function ggpairs()

library(sp)
library(GGally)

data(meuse)

attach(meuse)
names(meuse)
head(meuse)
plot(cadmium,zinc,pch=15,col="red",cex=2)

#Exercise: make all the possible plots
#plot(x,cadmium)
#plot(x,zinc)
#plot...
#plot is not a good idea
pairs(meuse)

#in case you recive the error "the size is too large" reshape with the mouse the graph window

pairs(~ cadmium + copper + lead + zinc, data=meuse) 

pairs(meuse[,3:6])

#GGally package will prettify the graph
ggpairs(meuse[,3:6])
