# R code for spatial viow of points

install.packages("sp")

library(sp)

data(meuse)

head(meuse)

# coordinates
coordinates(meuse) = ~x+y   #alt+126

plot(meuse)
spplot(meuse, "zinc")

# Exercise: plot the spatial amount of copper
spplot(meuse, "copper", main= "Copper Concentration")

bubble(meuse, "zinc")

#Exercise: bubble Copper in red
bubble(meuse, "Copper", main= "Copper Concentration", col= "red")
